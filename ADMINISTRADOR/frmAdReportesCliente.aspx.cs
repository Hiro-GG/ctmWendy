using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Formulario_web18 : System.Web.UI.Page
    {
        clsUsuario objUsuario = new clsUsuario();
        clsCarrito objCarrito = new clsCarrito();
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ⛔ Validación por si entran sin seleccionar un usuario
            if (Session["cveSel"] == null || Session["cveSel"].ToString() == "0")
            {
                Response.Redirect("frmAdReportes.aspx");
                return;
            }

            if (!IsPostBack)
            {
                int claveCliente = int.Parse(Session["cveSel"].ToString());

                // 🧍‍♂️ OBTENER LA CLAVE Y EL NOMBRE COMPLETO DEL CLIENTE
                try
                {
                    // Usa el SP tspMostrarUsuario a través de buscarUsuario
                    objUsuario.buscarUsuario(
                        Application["cnnVentas"].ToString(),
                        claveCliente
                    );

                    // Armamos el nombre completo
                    string nombreCompleto = objUsuario.NomUsuario;

                    if (!string.IsNullOrWhiteSpace(objUsuario.ApeP1))
                        nombreCompleto += " " + objUsuario.ApeP1;

                    if (!string.IsNullOrWhiteSpace(objUsuario.ApeM1))
                        nombreCompleto += " " + objUsuario.ApeM1;

                    // IMPORTANTE: Clave viene de la clase (ya se llena en buscarUsuario)
                    MainContent_lblSes.Text =
                        "Cliente: " + objUsuario.Clave + " - " + nombreCompleto;
                }
                catch
                {
                    // Si algo falla, por lo menos muestra la clave
                    MainContent_lblSes.Text =
                        "Cliente: " + claveCliente.ToString();
                }

                // Cargar las ventas del cliente
                ventasRealizadas();
            }
        }

        void ventasRealizadas()
        {
            ds = objCarrito.listarVentasCliente(
                Application["cnnVentas"].ToString(),
                int.Parse(Session["cveSel"].ToString())   // ✔️ USAR cveSel
            );

            if (ds.Tables.Count > 0 &&
    ds.Tables[0].Columns.Contains("FechaReserva"))
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    gvComprasAnteriores.DataSource = ds;
                    gvComprasAnteriores.DataMember = "ReservasRealizadas";
                    gvComprasAnteriores.DataBind();
                }
                else
                {
                    gvComprasAnteriores.DataSource = null;
                    gvComprasAnteriores.DataBind();
                    lblR.Text = "Este usuario no tiene compras registradas.";
                }
            }
            else
            {
                // Si la tabla no trae columnas → evitar que truene el GridView
                gvComprasAnteriores.DataSource = null;
                gvComprasAnteriores.DataBind();
                lblR.Text = "Este usuario no tiene compras registradas.";
            }
        }

        void detalleVentas()
        {
            ds = objCarrito.listarDetalleReserva(
                Application["cnnVentas"].ToString(),
                int.Parse(Session["selCompra"].ToString())
            );

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvDetalleVentas.Visible = true;
                lblDet.Visible = true;

                gvDetalleVentas.DataSource = ds;
                gvDetalleVentas.DataMember = "ReservaActual";
                gvDetalleVentas.DataBind();
            }
            else
            {
                lblDet.Visible = false;
                gvDetalleVentas.Visible = false;

                lblR.Visible = true;
                lblR.Text = "La reserva seleccionada no tiene detalles o está cancelada.";
            }
        }

        protected void gvComprasAnteriores_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            gvDetalleVentas.Visible = false;
            lblR.Visible = false;

            // ✔️ Guardar la clave de la reserva seleccionada
            Session["selCompra"] = gvComprasAnteriores.Rows[e.NewSelectedIndex].Cells[0].Text;

            detalleVentas();
        }

        protected void gvComprasAnteriores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvComprasAnteriores.PageIndex = e.NewPageIndex;
            ventasRealizadas();
        }

        protected void gvDetalleVentas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDetalleVentas.PageIndex = e.NewPageIndex;
            detalleVentas();
        }
    }
}
