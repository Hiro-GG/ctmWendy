using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.CLIENTE
{
    public partial class Formulario_web14 : System.Web.UI.Page
    {
        clsCarrito objCarrito = new clsCarrito();
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            MainContent_lblSes.Text = Session["cveUsuario"].ToString() + "-" + Session["nombreUsuario"].ToString();
            ventasRealizadas();
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
                id = dr["claveReserva"].ToString();
                break;
            }

            if (id != "0")
            {
                // Pasa los datos de la BD al GridView
                gvComprasAnteriores.DataSource = ds;
                gvComprasAnteriores.DataMember = "ReservasRealizadas";
                gvComprasAnteriores.DataBind();
            }
            else
            {
                lblR.Text = "Por el momento no ha realizado ninguna reserva";
            }
        }
        void detalleVentas()
        {
            string id = "0";
            ds = new DataSet();
            ds = objCarrito.listarDetalleReserva(Application["cnnVentas"].ToString(),
                int.Parse(Session["selCompra"].ToString()));
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                id = dr["claveReserva"].ToString();
                break;
            }
            if (id != "0")
            {
                gvDetalleVentas.Visible = true;
                lblDet.Visible = true;
                gvDetalleVentas.DataSource = ds;
                gvDetalleVentas.DataMember = "ReservaActual";
                gvDetalleVentas.DataBind();
            }
            else
            {
                lblR.Visible = true;
                lblDet.Visible = false;
                lblR.Text = "La reserva no tiene nada, verificar su estatus";
            }
        }

        protected void gvComprasAnteriores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvComprasAnteriores.PageIndex = e.NewPageIndex;
            ventasRealizadas();
        }

        protected void gvComprasAnteriores_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            gvDetalleVentas.Visible = false;
            lblR.Visible = false;
            Session["selCompra"] = gvComprasAnteriores.Rows[e.NewSelectedIndex].Cells[0].Text;
            detalleVentas();
        }

        protected void gvDetalleVentas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDetalleVentas.PageIndex = e.NewPageIndex;
            detalleVentas();
        }
    }
}