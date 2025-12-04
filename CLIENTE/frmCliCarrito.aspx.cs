using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.CLIENTE
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {
        clsCarrito objCarrito = new clsCarrito();
        // Variable que recibe los registros para mostrarlos en el GridView
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cveUsuario"] != null && Session["nombreUsuario"] != null)
            {
                lblSesion.Text = Session["cveUsuario"].ToString() + "-" + Session["nombreUsuario"].ToString();
            }

            if (Session["venActual"] != null && Session["venActual"].ToString() != "0")
            {
                lblVenta.Text = "Compra actual: " + Session["venActual"].ToString();
                //se visualizara los prodcutos que se pueden comprar y el boton de agregar
                lblVenta.Visible = true;
                gvServicios.Visible = true;
                btnAñadir.Visible = true;
            }

            //VALIDACION PARA SABER SI HAY UNA VENTA ACTUAL
            if (Session["venActual"].ToString() == "0")
            {
                lblProductos.Visible = false;
                gvServicios.Visible = false;
                lblCarrito.Visible = false;
                gvServicosCarrito.Visible = false;
                lblTotal.Visible = false;
                lblSubtotal.Visible = false;
                lblIva.Visible = false;
                btnCerrarCarrito.Visible = false;
                btnAñadir.Visible = false;
                btnConfirmarCompra.Visible = false;
                txtTotal.Visible = false;
                pnlBusqueda.Visible = false;
            }
            else
            {
                lblVenta.Text = "Compra actual: " + Session["venActual"].ToString();
                //SE VISUALIZAN LOS PRODUCTOS QUE SE PUEDEN COMPRAR Y EL BOTON DE AGREGAR
                lblProductos.Visible = true;
                gvServicios.Visible = true;
                btnAñadir.Visible = true;
                btnCerrarCarrito.Visible = true;
                btnConfirmarCompra.Visible = true;
                pnlBusqueda.Visible = true;
            }




            // Sección de consultas para llenar GridViews
            if (!IsPostBack)
            {
                ventasRealizadas();
                servicios();
            }

        }
        void ventasRealizadas()
        {
            string id = "";
            ds = new DataSet();
            ds = objCarrito.listarVentasCliente(
                Application["cnnVentas"].ToString(),
                int.Parse(Session["cveUsuario"].ToString())
            );

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                id = dr["ClaveReserva"].ToString();
                break;
            }

            if (id != "0")
            {
                // Pasa los datos de la BD al GridView
                gvReservasAnteriores.DataSource = ds;
                gvReservasAnteriores.DataMember = "ReservasRealizadas";
                gvReservasAnteriores.DataBind();
            }
            else
            {
                lblVenta.Text = "Por el momento no ha realizado ninguna compra";
            }
        }

        protected void gvReservasAnteriores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //Establecer el nuevo índice de página
            gvReservasAnteriores.PageIndex = e.NewPageIndex;
            //Volver a cargar y enlazar los datos
            ventasRealizadas();

        }

        protected void btnGenerarReserva_Click(object sender, EventArgs e)
        {
            try
            {
                // Asegurarse de que Session["venActual"] no sea null
                if (Session["venActual"] == null || Session["venActual"].ToString() == "0")
                {
                    // Genera una nueva venta y asigna el número de venta a la variable de sesión
                    Session["venActual"] = objCarrito.insertarVenta(
                        Application["cnnVentas"].ToString(),
                        int.Parse(Session["cveUsuario"].ToString()),
                        0
                    ).ToString();

                    // Mostrar alerta y redireccionar
                    string script = "alert('Venta registrada: " + Session["venActual"].ToString() + "');" +
                                    "window.location='frmCliCarrito.aspx';";
                    ClientScript.RegisterStartupScript(this.GetType(), "VentaRegistrada", script, true);
                }
                else
                {
                    string script = "alert('Ya hay una venta registrada, seleccionar productos...');" +
                                    "window.location='frmCliCarrito.aspx';";
                    ClientScript.RegisterStartupScript(this.GetType(), "VentaExistente", script, true);
                }

                lblVenta.Text = "Venta actual: " + Session["venActual"].ToString();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorVenta",
                    "alert('Ha sucedido un error en el registro de venta.');", true);
                
            }
        }

        protected void gvServicios_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            Session["selProducto"] = gvServicios.Rows[e.NewSelectedIndex].Cells[3].Text;

            Response.Write("<script> window.open('frmCliDetProducto.aspx', 'Detalle " +
                "producto', 'height=600,width=350,resizable=no,left=-1000,top=-1000','_blank');" + "</script>");
        }
        void servicios(string filtroTexto = "", string filtroCategoria = "Todos")
        {
            ds = new DataSet();
            ds = objCarrito.listarServiciosCliente(Application["cnnVentas"].ToString());

            DataView dv = ds.Tables[0].DefaultView;
            string expresionFiltro = "";

            // 1. Lógica para el filtro de TEXTO (Destino o Nombre)
            if (!string.IsNullOrEmpty(filtroTexto))
            {
                expresionFiltro += "(Destino LIKE '%" + filtroTexto + "%' OR Servicio LIKE '%" + filtroTexto + "%')";
            }

            // 2. Lógica para el filtro de CATEGORÍA (Vuelos, Hoteles, Tours)
            if (filtroCategoria != "Todos")
            {
                
                if (expresionFiltro != "")
                {
                    expresionFiltro += " AND ";
                }
                expresionFiltro += "Categoria = '" + filtroCategoria + "'";
            }

            
            dv.RowFilter = expresionFiltro;

            gvServicios.DataSource = dv;
            gvServicios.DataMember = "";
            gvServicios.DataBind();
        }
        void detalleReservas()
        {
            ds = new DataSet();
            ds = objCarrito.listarDetalleReserva(Application["cnnVentas"].ToString(),
                int.Parse(Session["venActual"].ToString()));
            gvServicosCarrito.DataSource = ds;
            gvServicosCarrito.DataMember = "ReservaActual";
            gvServicosCarrito.DataBind();
        }
        void calcularTotalReserva()
        {
            double stotalVtaNva = 0, totalVta = 0, iva = 0;

            // Banderas para detectar categorías
            bool tieneVuelo = false;
            bool tieneHotel = false;
            bool tieneTour = false;

            // Verificamos si hay datos en el carrito
            bool hayProductos = false;

            if (ds != null && ds.Tables.Contains("ReservaActual") && ds.Tables["ReservaActual"].Rows.Count > 0)
            {
                hayProductos = true; //  Si es que si hay cosas en el carrito!

                foreach (DataRow row in ds.Tables["ReservaActual"].Rows)
                {
                    stotalVtaNva += Convert.ToDouble(row["Total"]);
                    int categoria = Convert.ToInt32(row["CAT_Clave"]);

                    if (categoria == 1) tieneVuelo = true;
                    if (categoria == 2) tieneHotel = true;
                    if (categoria == 3) tieneTour = true;
                }
            }

            
            if (!hayProductos)
            {
                
                lblAvisoPaquete.Visible = false;
                lblDescuento.Visible = false;
                lblTotal.Text = "Total Venta: $";
            }
            else
            {
               
                lblAvisoPaquete.Visible = true; 

                // 1. Cálculos base
                iva = stotalVtaNva * 0.16;
                totalVta = stotalVtaNva + iva;

                // 2. Verificar si tiene el paquete completo
                if (tieneVuelo && tieneHotel && tieneTour)
                {
                    // APLICAR DESCUENTO
                    double porcentaje = 0.20;
                    double montoDescuento = totalVta * porcentaje;
                    totalVta = totalVta - montoDescuento;

                    lblDescuento.Visible = true;
                    lblDescuento.Text = "¡Ahorro aplicado: -$" + montoDescuento.ToString("N2") + "!";

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

                    lblAvisoPaquete.Text = "¡Tip de Ahorro! Agrega " + textoFaltante + " para obtener 20% de descuento.";
                    lblAvisoPaquete.ForeColor = System.Drawing.Color.DarkOrange;

                    lblTotal.Text = "Total Venta: $";
                }
            }

            // Actualizar etiquetas de montos
            lblSubtotal.Text = "Subtotal: $" + stotalVtaNva.ToString("N2");
            lblIva.Text = "I.V.A. (16%) : $" + iva.ToString("N2");
            txtTotal.Text = totalVta.ToString("0.00");
        }

        protected void btnAñadir_Click(object sender, EventArgs e)
        {
            double subtotalUnidad = 0;
            lblCarrito.Visible = true;
            lblTotal.Visible = true;
            lblSubtotal.Visible = true;
            lblIva.Visible = true;
            txtTotal.Visible = true;

            //RECORRE EL GRID PARA AGREGAR LOS PRODUCTOS SELECCIONADOS
            for (int i = 0; i < gvServicios.Rows.Count; i++)
            {
                //chk toma el valor del checkbox que tiene cada registro de productos 
                CheckBox chk = (CheckBox)gvServicios.Rows[i].FindControl("chkSeleccionado");
                //verifica que se haya seleccionado para poder insertarlo en el carrito de compras 
                if (chk.Checked && chk != null)
                {
                    //accedo al drop
                    DropDownList dd = (DropDownList)gvServicios.Rows[i].FindControl("dwlCantidad");
                    if (int.Parse(dd.SelectedItem.ToString()) <= int.Parse(gvServicios.Rows[i].Cells[6].Text))
                    {
                        subtotalUnidad = double.Parse(dd.SelectedItem.ToString()) * double.Parse(gvServicios.Rows[i].Cells[7].Text);
                        //enviar el regristro al grid de carrito de compras nuevas
                        objCarrito.insertarDetalleReserva(Application["cnnVentas"].ToString(),
                            int.Parse(Session["venActual"].ToString()),
                            int.Parse(gvServicios.Rows[i].Cells[3].Text),
                            int.Parse(dd.SelectedItem.ToString()), subtotalUnidad);
                        detalleReservas();
                        calcularTotalReserva();

                    }
                }

            }
            lblCarrito.Visible = true;
            gvServicosCarrito.Visible = true;
            btnCerrarCarrito.Visible = true;
            btnEliminarProd.Visible = true;
            servicios();
        }

        protected void gvServicosCarrito_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
   
        }

        protected void btnEliminarProd_Click(object sender, EventArgs e)
        {
            //RECORRE EL GRID PARA QUITAR LOS PRODUCTOS DE LA NUEVA COMPRA
            for (int i = 0; i < gvServicosCarrito.Rows.Count; i++)
            {
                //chk, toma el valor del checkbox que tiene cada registro de productos
                CheckBox chk = (CheckBox)gvServicosCarrito.Rows[i].FindControl("chkSelect");
                //vreifica que se haya seleccionado para poder insertarlo en el carrito de compras
                if (chk.Checked && chk != null)
                {
                    //ELIMINAR EL PRODUCTO SELECCIONADO DEL CARRITO DE COMPRAS
                    objCarrito.eliminarServicioReserva(Application["cnnVentas"].ToString(),
                        int.Parse(gvServicosCarrito.Rows[i].Cells[1].Text),
                        int.Parse(gvServicosCarrito.Rows[i].Cells[2].Text),
                        int.Parse(gvServicosCarrito.Rows[i].Cells[4].Text));
                    //resta del total la cantidad de productos que ya no se van a comprar
                    txtTotal.Text = (double.Parse(txtTotal.Text) - double.Parse(gvServicosCarrito.Rows[i].Cells[6].Text)).ToString();
                }
            }
            servicios();
            detalleReservas();
            calcularTotalReserva();

        }

        protected void btnConfirmarCompra_Click(object sender, EventArgs e)
        {
            if (Session["venActual"].ToString() == "0")
            {
                Response.Write("<script language='javascript'>" +
                    "alert('No puedes confimar la compra porque no" +
                    "has generado ninguna compra actual...');</script>");
            }
            else if (txtTotal.Text == "" || txtTotal.Text == "0")
            {
                Response.Write("<script language='javascript'>" +
                    "alert('No puedes confirmar la compra " +
                    "porque no has comprado productos...');</script>");
            }
            else
            {
                //ejecuta la actualización de la venta
                objCarrito.confirmarReserva(Application["cnnVentas"].ToString(),
                    int.Parse(Session["venActual"].ToString()),
                    float.Parse(txtTotal.Text));
                Session["venActual"] = "0";

                ventasRealizadas();
                servicios();
                detalleReservas();
                lblVenta.Text = "[Pendiente de generarse una venta]";
                gvServicosCarrito.Visible = false;
                gvServicios.Visible = false;
                btnAñadir.Visible = false;
                lblReservas.Visible = false;
                lblTotal.Visible = false;
                lblIva.Visible = false;
                lblSubtotal.Visible = false;
                txtTotal.Visible = false;
                btnCancelar.Visible = false;
                lblCarrito.Visible = false;
                btnConfirmarCompra.Visible = false;
                lblDescuento.Visible = false;    
                lblAvisoPaquete.Visible = false;
                pnlBusqueda.Visible = false;
                Response.Write("<script language='javascript'>" +
                    "alert('La compra se ha confirmado y cerrado correctamente...');" +
                    "</script>");

            }
        }

        protected void btnCerrarCarrito_Click(object sender, EventArgs e)
        {
            // 1) Validaciones iguales a tu lógica vieja
            if (Session["venActual"].ToString() == "0")
            {
                Response.Write("<script language='javascript'>" +
                    "alert('No puedes cerrar el carrito porque no has generado ninguna compra actual...');" +
                    "</script>");
            }
            else if (txtTotal.Text == "" || txtTotal.Text == "0")
            {
                Response.Write("<script language='javascript'>" +
                    "alert('No puedes cerrar el carrito porque no has agregado productos...');" +
                    "</script>");
            }
            else
            {
                // ============================================
                // 2) Quitar TODOS los productos del detalle reserva
                //    (similar a tu viejo for de gvListaCarrito)
                // ============================================
                for (int i = 0; i < gvServicosCarrito.Rows.Count; i++)
                {
                    // NO usamos checkbox, aquí se eliminan todos los renglones
                    int claveReserva = int.Parse(gvServicosCarrito.Rows[i].Cells[1].Text); // ClaveReserva
                    int claveServicio = int.Parse(gvServicosCarrito.Rows[i].Cells[2].Text); // ClaveServicio
                    int cantidad = int.Parse(gvServicosCarrito.Rows[i].Cells[4].Text);      // CantidadReservada

                    objCarrito.eliminarServicioReserva(
                        Application["cnnVentas"].ToString(),
                        claveReserva,
                        claveServicio,
                        cantidad
                    );
                }

                // ============================================
                // 3) Actualizar grids / datos
                // ============================================
                servicios();        // vuelve a listar servicios disponibles (actualiza cupos)
                detalleReservas();  // ya no debería mostrar nada para la venta actual
                gvServicosCarrito.Visible = false;

                // Ocultar resumen de compra
                lblSubtotal.Visible = false;
                lblIva.Visible = false;
                lblTotal.Visible = false;
                txtTotal.Visible = false;
                txtTotal.Text = "0";

                // Ocultar productos / botones de carrito
                lblCarrito.Visible = false;
                btnCerrarCarrito.Visible = false;
                btnEliminarProd.Visible = false;
                btnConfirmarCompra.Visible = false;
                pnlBusqueda.Visible = false;
                lblProductos.Visible = false;
                gvServicios.Visible = false;
                btnAñadir.Visible = false;
                lblDescuento.Visible = false;
                lblAvisoPaquete.Visible = false;

                // ============================================
                // 4) Cancelar la reserva en BD (tspCancelarReserva)
                // ============================================
                objCarrito.cancelarReserva(
                    Application["cnnVentas"].ToString(),
                    int.Parse(Session["venActual"].ToString())
                );

                // 5) Liberar la venta actual
                Session["venActual"] = "0";

                // Actualizar historial de reservas
                ventasRealizadas();

                lblVenta.Text = "[Pendiente de generarse una venta]";

                // Mensaje final
                Response.Write("<script language='javascript'>" +
                    "alert('La compra se ha cancelado y cerrado correctamente...');" +
                    "</script>");
            }
        }


        protected void gvServicios_SelectedIndexChanging1(object sender, GridViewSelectEventArgs e)
        {
            Session["selProducto"] = gvServicios.Rows[e.NewSelectedIndex].Cells[3].Text;

            Response.Write("<script> window.open('frmCliDetServicio.aspx', 'Detalle " +
                "producto', 'height=600,width=350,resizable=no,left=-1000,top=-1000','_blank');" + "</script>");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            if (Session["venActual"] != null && Session["venActual"].ToString() != "0")
            {
                try
                {
                    // 2. Llamamos al método de la clase clsCarrito para cambiar el estatus a 'CANCELADA' en la BD
                    objCarrito.cancelarReserva(
                        Application["cnnVentas"].ToString(),
                        int.Parse(Session["venActual"].ToString())
                    );

                    // 3. Reiniciamos la variable de sesión para indicar que ya no hay venta activa
                    Session["venActual"] = "0";

                    // 4. Actualizamos el historial 
                    ventasRealizadas();

                    // 5. LIMPIEZA DE INTERFAZ 
                    lblVenta.Text = "[Pendiente de generarse una venta]";

                    
                    gvServicios.Visible = false;
                    lblProductos.Visible = false;
                    pnlBusqueda.Visible = false; 
                    btnAñadir.Visible = false;

                    // Ocultamos el carrito y los totales
                    gvServicosCarrito.Visible = false;
                    lblCarrito.Visible = false;
                    lblTotal.Visible = false;
                    lblSubtotal.Visible = false;
                    lblIva.Visible = false;
                    txtTotal.Visible = false;
                    txtTotal.Text = "0";

                    // Ocultamos los botones de acción del carrito
                    btnCerrarCarrito.Visible = false;
                    btnConfirmarCompra.Visible = false;
                    btnEliminarProd.Visible = false;

                    // Ocultamos mensajes de promociones
                    lblDescuento.Visible = false;
                    lblAvisoPaquete.Visible = false;

                    // 6. Mensaje de confirmación para el usuario
                    Response.Write("<script language='javascript'>alert('La reserva ha sido cancelada correctamente.');</script>");
                }
                catch (Exception ex)
                {
                    // Por si ocurre algún error de conexión
                    Response.Write("<script>alert('Error al cancelar: " + ex.Message + "');</script>");
                }
            }
            else
            {
                // Si el usuario da clic sin tener una reserva activa
                Response.Write("<script>alert('No tienes ninguna reserva activa para cancelar.');</script>");
            }
        }

        protected void gvServicios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // Cambiar a la página seleccionada
            gvServicios.PageIndex = e.NewPageIndex;

            // Volver a cargar los datos del GridView
            servicios(txtBuscarDestino.Text.Trim(), ddlCategoria.SelectedValue);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            servicios(txtBuscarDestino.Text.Trim(), ddlCategoria.SelectedValue);
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscarDestino.Text = "";
            ddlCategoria.SelectedValue = "Todos";

            // Recargamos sin filtros
            servicios();
        }
    }
}