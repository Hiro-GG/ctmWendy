using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.CLIENTE
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {
        clsCarrito objCarrito = new clsCarrito();
        DataSet ds;

        private const int PageSize = 6; // servicios por página

        private int CurrentPage
        {
            get
            {
                return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 0;
            }
            set
            {
                ViewState["CurrentPage"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cveUsuario"] != null && Session["nombreUsuario"] != null)
            {
                lblSesion.Text = Session["cveUsuario"].ToString() + "-" + Session["nombreUsuario"].ToString();
            }

            if (Session["venActual"] == null)
                Session["venActual"] = "0";

            if (!IsPostBack)
            {
                ConfigurarEstadoVenta();

                if (Session["venActual"].ToString() != "0")
                {
                    CargarServicios();
                    detalleReservas();
                }
            }
        }

        #region Estado visual

        private void ConfigurarEstadoVenta()
        {
            bool hayVenta = Session["venActual"] != null && Session["venActual"].ToString() != "0";

            if (hayVenta)
            {
                lblVenta.Text = "Compra actual: " + Session["venActual"].ToString();
                pnlContenidoCompra.Visible = true;
                pnlSinCompra.Visible = false;
                pnlBusqueda.Visible = true;
                lblProductos.Visible = true;
            }
            else
            {
                lblVenta.Text = "[Pendiente de generarse una venta]";
                pnlContenidoCompra.Visible = false;
                pnlSinCompra.Visible = true;
                pnlBusqueda.Visible = false;
                lblProductos.Visible = false;

                pnlCarritoVacio.Visible = true;
                rptCarrito.DataSource = null;
                rptCarrito.DataBind();

                lblSubtotal.Visible = false;
                lblIva.Visible = false;
                lblTotal.Visible = true;
                txtTotal.Visible = true;
                txtTotal.Text = "0.00";
                lblDescuento.Visible = false;
                lblAvisoPaquete.Visible = false;
                pnlFechasVuelo.Visible = false;
                pnlFechasHotel.Visible = false;
                pnlFechasTour.Visible = false;
            }
        }

        #endregion

        #region Nueva compra

        protected void btnNuevaCompra_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["venActual"] == null || Session["venActual"].ToString() == "0")
                {
                    // Insertar nueva reserva pendiente
                    Session["venActual"] = objCarrito.insertarVenta(
                        Application["cnnVentas"].ToString(),
                        int.Parse(Session["cveUsuario"].ToString()),
                        0
                    ).ToString();

                    lblVenta.Text = "Compra actual: " + Session["venActual"].ToString();
                    ConfigurarEstadoVenta();
                    CargarServicios();
                    detalleReservas();

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "VentaRegistrada",
                        "alert('Venta registrada: " + Session["venActual"].ToString() + "');",
                        true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "VentaExistente",
                        "alert('Ya hay una venta registrada, selecciona servicios para esa compra.');",
                        true);
                }
            }
            catch
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "ErrorVenta",
                    "alert('Ha sucedido un error en el registro de la venta.');",
                    true);
            }
        }

        #endregion

        #region Servicios disponibles + paginación

        void CargarServicios(string filtroTexto = "", string filtroCategoria = "Todos")
        {
            ds = new DataSet();
            ds = objCarrito.listarServiciosCliente(Application["cnnVentas"].ToString());

            DataView dv = ds.Tables[0].DefaultView;
            string expresionFiltro = "";

            if (!string.IsNullOrEmpty(filtroTexto))
            {
                expresionFiltro += "(Destino LIKE '%" + filtroTexto + "%' OR Servicio LIKE '%" + filtroTexto + "%')";
            }

            if (filtroCategoria != "Todos")
            {
                if (expresionFiltro != "")
                    expresionFiltro += " AND ";

                expresionFiltro += "Categoria = '" + filtroCategoria + "'";
            }

            dv.RowFilter = expresionFiltro;

            DataTable dtFiltrado = dv.ToTable();
            ViewState["ServiciosData"] = dtFiltrado;

            CurrentPage = 0;
            BindServiciosPage();
        }

        private void BindServiciosPage()
        {
            DataTable dt = ViewState["ServiciosData"] as DataTable;

            if (dt == null || dt.Rows.Count == 0)
            {
                rptServicios.DataSource = null;
                rptServicios.DataBind();
                lblPaginaActual.Text = "0";
                lblTotalPaginas.Text = "0";
                btnAnterior.Enabled = false;
                btnSiguiente.Enabled = false;
                return;
            }

            PagedDataSource pds = new PagedDataSource
            {
                DataSource = dt.DefaultView,
                AllowPaging = true,
                PageSize = PageSize,
                CurrentPageIndex = CurrentPage
            };

            btnAnterior.Enabled = !pds.IsFirstPage;
            btnSiguiente.Enabled = !pds.IsLastPage;

            lblPaginaActual.Text = (CurrentPage + 1).ToString();
            lblTotalPaginas.Text = pds.PageCount.ToString();

            rptServicios.DataSource = pds;
            rptServicios.DataBind();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarServicios(txtBuscarDestino.Text.Trim(), ddlCategoria.SelectedValue);
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscarDestino.Text = "";
            ddlCategoria.SelectedValue = "Todos";
            CargarServicios();
        }

        protected void btnAnterior_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
            {
                CurrentPage--;
                BindServiciosPage();
            }
        }

        protected void btnSiguiente_Click(object sender, EventArgs e)
        {
            DataTable dt = ViewState["ServiciosData"] as DataTable;
            if (dt == null) return;

            int totalPages = (int)Math.Ceiling(dt.Rows.Count / (double)PageSize);

            if (CurrentPage < totalPages - 1)
            {
                CurrentPage++;
                BindServiciosPage();
            }
        }

        #endregion

        #region Agregar / Detalle servicio

        protected void rptServicios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int claveServicio = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "VerDetalle")
            {
                // Se respeta la lógica original: usar Session["selProducto"]
                Session["selProducto"] = claveServicio.ToString();
                Response.Redirect("frmCliDetServicio.aspx");
                return;
            }

            if (e.CommandName == "Agregar")
            {
                if (Session["venActual"] == null || Session["venActual"].ToString() == "0")
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "SinVenta",
                        "alert('Primero haz clic en \"Iniciar nueva compra\".');",
                        true);
                    return;
                }

                DropDownList ddlCantidad = (DropDownList)e.Item.FindControl("ddlCantidad");
                int cantidad = int.Parse(ddlCantidad.SelectedValue);

                DataTable dt = ViewState["ServiciosData"] as DataTable;
                if (dt == null) return;

                DataRow[] filas = dt.Select("Clave = " + claveServicio);
                if (filas.Length == 0) return;

                int cupos = Convert.ToInt32(filas[0]["Cupos"]);
                double precio = Convert.ToDouble(filas[0]["Precio"]);

                if (cantidad > cupos)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "CuposInsuficientes",
                        "alert('No hay suficientes lugares disponibles para este servicio.');",
                        true);
                    return;
                }

                double subtotalUnidad = cantidad * precio;

                // Insertar detalle en BD
                objCarrito.insertarDetalleReserva(
                    Application["cnnVentas"].ToString(),
                    int.Parse(Session["venActual"].ToString()),
                    claveServicio,
                    cantidad,
                    subtotalUnidad
                );

                detalleReservas();
            }
        }

        #endregion

        #region Detalle reserva (carrito) + totales

        void detalleReservas()
        {
            if (Session["venActual"] == null || Session["venActual"].ToString() == "0")
                return;

            ds = new DataSet();
            ds = objCarrito.listarDetalleReserva(
                Application["cnnVentas"].ToString(),
                int.Parse(Session["venActual"].ToString())
            );

            if (ds != null && ds.Tables.Count > 0 && ds.Tables["ReservaActual"].Rows.Count > 0)
            {
                pnlCarritoVacio.Visible = false;
                rptCarrito.DataSource = ds.Tables["ReservaActual"];
                rptCarrito.DataMember = "ReservaActual";
                rptCarrito.DataBind();

                lblSubtotal.Visible = true;
                lblIva.Visible = true;
                txtTotal.Visible = true;
                lblTotal.Visible = true;

                // Mostrar paneles de fechas solo si hay servicios de esa categoría
                ConfigurarPanelesFechas(ds.Tables["ReservaActual"]);
                calcularTotalReserva();
            }
            else
            {
                pnlCarritoVacio.Visible = true;
                rptCarrito.DataSource = null;
                rptCarrito.DataBind();

                lblSubtotal.Text = "Subtotal: $0.00";
                lblIva.Text = "I.V.A (16%) : $0.00";
                txtTotal.Text = "0.00";
                lblDescuento.Visible = false;
                lblAvisoPaquete.Visible = false;

                pnlFechasVuelo.Visible = false;
                pnlFechasHotel.Visible = false;
                pnlFechasTour.Visible = false;
            }
        }

        private void ConfigurarPanelesFechas(DataTable tabla)
        {
            bool tieneVuelo = false;
            bool tieneHotel = false;
            bool tieneTour = false;

            foreach (DataRow row in tabla.Rows)
            {
                int categoria = Convert.ToInt32(row["CAT_Clave"]);
                if (categoria == 1) tieneVuelo = true;
                if (categoria == 2) tieneHotel = true;
                if (categoria == 3) tieneTour = true;
            }

            pnlFechasVuelo.Visible = tieneVuelo;
            pnlFechasHotel.Visible = tieneHotel;
            pnlFechasTour.Visible = tieneTour;
        }

        private int ObtenerNochesHotel()
        {
            if (DateTime.TryParse(txtHotelCheckIn.Text, out DateTime checkIn) &&
                DateTime.TryParse(txtHotelCheckOut.Text, out DateTime checkOut))
            {
                int noches = (checkOut - checkIn).Days;
                if (noches < 1) noches = 1;
                return noches;
            }
            return 1;
        }

        void calcularTotalReserva()
        {
            double subtotal = 0, total = 0, iva = 0;

            bool tieneVuelo = false;
            bool tieneHotel = false;
            bool tieneTour = false;

            bool hayProductos = false;

            int nochesHotel = ObtenerNochesHotel();

            if (ds != null && ds.Tables.Contains("ReservaActual") && ds.Tables["ReservaActual"].Rows.Count > 0)
            {
                hayProductos = true;

                foreach (DataRow row in ds.Tables["ReservaActual"].Rows)
                {
                    int categoria = Convert.ToInt32(row["CAT_Clave"]);

                    double linea = Convert.ToDouble(row["Total"]);

                    if (categoria == 1) tieneVuelo = true;
                    if (categoria == 2)
                    {
                        tieneHotel = true;
                        // Para hoteles recalculamos total como: precioUnitario * cantidad * noches
                        double precioUnitario = Convert.ToDouble(row["PrecioUnitario"]);
                        int cantidad = Convert.ToInt32(row["CantidadReservada"]);
                        linea = precioUnitario * cantidad * nochesHotel;
                    }
                    if (categoria == 3) tieneTour = true;

                    subtotal += linea;
                }
            }

            if (!hayProductos)
            {
                lblAvisoPaquete.Visible = false;
                lblDescuento.Visible = false;

                lblSubtotal.Text = "Subtotal: $0.00";
                lblIva.Text = "I.V.A (16%) : $0.00";
                lblTotal.Text = "Total Venta: $";
                txtTotal.Text = "0.00";
            }
            else
            {
                iva = subtotal * 0.16;
                total = subtotal + iva;

                if (tieneVuelo && tieneHotel && tieneTour)
                {
                    double porcentaje = 0.20;
                    double montoDescuento = total * porcentaje;
                    total = total - montoDescuento;

                    lblDescuento.Visible = true;
                    lblDescuento.Text = "¡Ahorro aplicado: -$" + montoDescuento.ToString("N2") + "!";

                    lblAvisoPaquete.Visible = true;
                    lblAvisoPaquete.Text = "¡Felicidades! Paquete Vuelo + Hotel + Tour. Has obtenido el 20% de descuento";
                    lblAvisoPaquete.ForeColor = System.Drawing.Color.Green;

                    lblTotal.Text = "Total con Descuento: $";
                }
                else
                {
                    lblDescuento.Visible = false;

                    List<string> faltantes = new List<string>();
                    if (!tieneVuelo) faltantes.Add("Vuelo");
                    if (!tieneHotel) faltantes.Add("Hotel");
                    if (!tieneTour) faltantes.Add("Tour");

                    string textoFaltante = string.Join(" y ", faltantes);

                    lblAvisoPaquete.Visible = true;
                    lblAvisoPaquete.Text = "¡Tip de Ahorro! Agrega " + textoFaltante + " para obtener 20% de descuento.";
                    lblAvisoPaquete.ForeColor = System.Drawing.Color.DarkOrange;

                    lblTotal.Text = "Total Venta: $";
                }

                lblSubtotal.Text = "Subtotal: $" + subtotal.ToString("N2");
                lblIva.Text = "I.V.A (16%) : $" + iva.ToString("N2");
                txtTotal.Text = total.ToString("0.00");
            }
        }

        #endregion

        #region Quitar servicios del carrito

        protected void rptCarrito_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                string[] partes = e.CommandArgument.ToString().Split('|');
                if (partes.Length == 3)
                {
                    int claveReserva = int.Parse(partes[0]);
                    int claveServicio = int.Parse(partes[1]);
                    int cantidad = int.Parse(partes[2]);

                    objCarrito.eliminarServicioReserva(
                        Application["cnnVentas"].ToString(),
                        claveReserva,
                        claveServicio,
                        cantidad
                    );

                    detalleReservas();
                }
            }
        }

        #endregion

        #region Confirmar / Cancelar compra

        protected void btnConfirmarCompra_Click(object sender, EventArgs e)
        {
            if (Session["venActual"] == null || Session["venActual"].ToString() == "0")
                return;

            if (string.IsNullOrEmpty(txtTotal.Text) || txtTotal.Text == "0" || txtTotal.Text == "0.00")
                return;

            // Aseguramos recálculo antes de confirmar
            detalleReservas();

            objCarrito.confirmarReserva(
                Application["cnnVentas"].ToString(),
                int.Parse(Session["venActual"].ToString()),
                float.Parse(txtTotal.Text)
            );

            Session["venActual"] = "0";
            ConfigurarEstadoVenta();
            CargarServicios(); // vuelve a cargar cupos disponibles

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "CompraConfirmada",
                "alert('Compra confirmada correctamente.');",
                true);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            if (Session["venActual"] == null || Session["venActual"].ToString() == "0")
                return;

            try
            {
                // Recuperar detalle para liberar cupos
                ds = objCarrito.listarDetalleReserva(
                    Application["cnnVentas"].ToString(),
                    int.Parse(Session["venActual"].ToString())
                );

                if (ds != null && ds.Tables.Contains("ReservaActual"))
                {
                    foreach (DataRow row in ds.Tables["ReservaActual"].Rows)
                    {
                        int claveReserva = Convert.ToInt32(row["ClaveReserva"]);
                        int claveServicio = Convert.ToInt32(row["ClaveServicio"]);
                        int cantidad = Convert.ToInt32(row["CantidadReservada"]);

                        objCarrito.eliminarServicioReserva(
                            Application["cnnVentas"].ToString(),
                            claveReserva,
                            claveServicio,
                            cantidad
                        );
                    }
                }

                // Cancelar reserva en BD
                objCarrito.cancelarReserva(
                    Application["cnnVentas"].ToString(),
                    int.Parse(Session["venActual"].ToString())
                );

                Session["venActual"] = "0";

                ConfigurarEstadoVenta();
                CargarServicios();

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "CompraCancelada",
                    "alert('Compra cancelada y productos liberados.');",
                    true);
            }
            catch
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "ErrorCancelar",
                    "alert('Ocurrió un error al cancelar la compra.');",
                    true);
            }
        }

        #endregion

        #region Fechas hotel (recalcular total al cambiar)

        protected void FechasHotel_TextChanged(object sender, EventArgs e)
        {
            // Solo recalculamos totales; no modificamos el detalle en BD,
            // pero el total mostrado ya considera noches de hospedaje.
            detalleReservas();
        }

        #endregion
    }
}
