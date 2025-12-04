using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Formulario_web19 : System.Web.UI.Page
    {
        // Instancia de la clase que maneja las ventas/servicios
        clsCarrito objCarrito = new clsCarrito();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                listarTopMasVendidos();
                listarTopMenosVendidos();
            }
        }

        // ======================================================
        // LISTAR 10 SERVICIOS MÁS VENDIDOS (GRID)
        // ======================================================
        void listarTopMasVendidos()
        {
            DataSet ds = objCarrito.listarTopMasVendidos(
                Application["cnnVentas"].ToString());

            gvMasVendidos.DataSource = ds;
            gvMasVendidos.DataMember = "TopMasVendidos";  // nombre de la tabla interna en el DataSet
            gvMasVendidos.DataBind();
        }

        protected void gvMasVendidos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMasVendidos.PageIndex = e.NewPageIndex;
            listarTopMasVendidos();
        }

        // ======================================================
        // LISTAR 10 SERVICIOS MENOS VENDIDOS (GRID)
        // ======================================================
        void listarTopMenosVendidos()
        {
            DataSet ds = objCarrito.listarTopMenosVendidos(
                Application["cnnVentas"].ToString());

            gvMenosVendidos.DataSource = ds;
            gvMenosVendidos.DataMember = "TopMenosVendidos";
            gvMenosVendidos.DataBind();
        }

        protected void gvMenosVendidos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMenosVendidos.PageIndex = e.NewPageIndex;
            listarTopMenosVendidos();
        }
    }
}
