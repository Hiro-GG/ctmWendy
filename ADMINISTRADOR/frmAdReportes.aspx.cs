using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Formulario_web17 : System.Web.UI.Page
    {
        // copia e instancia de la clase 
        clsUsuario objUsuario = new clsUsuario();
        clsCarrito objCarrito = new clsCarrito();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                listarUsuarios();
                listarVentas();
            }
        }

        // ================================
        // LISTAR USUARIOS
        // ================================
        void listarUsuarios()
        {
            DataSet ds = objUsuario.listarUsuarios(
                Application["cnnVentas"].ToString(), 0, 0);

            gvUsuarios.DataSource = ds;
            gvUsuarios.DataMember = "usuarios";
            gvUsuarios.DataBind();
        }

        protected void gvUsuarios_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            int clave = int.Parse(gvUsuarios.DataKeys[e.NewSelectedIndex].Value.ToString());
            Session["cveSel"] = clave;
            Response.Redirect("frmAdReportesCliente.aspx", false);
        }

        protected void gvUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuarios.PageIndex = e.NewPageIndex;
            listarUsuarios();
        }

        // ================================
        // LISTAR TODAS LAS VENTAS
        // ================================
        void listarVentas()
        {
            DataSet ds = objCarrito.listarVentas(
                Application["cnnVentas"].ToString());

            gvVentas.DataSource = ds;
            gvVentas.DataMember = "VentasRealizadas";   // tabla interna del DataSet
            gvVentas.DataBind();
        }

        // ================================
        // PAGINACIÓN DEL GRIDVIEW DE VENTAS
        // ================================
        protected void gvVentas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvVentas.PageIndex = e.NewPageIndex;
            listarVentas();
        }

        protected void gvVentas_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {

        }
    }
}
