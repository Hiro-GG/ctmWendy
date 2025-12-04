using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {
        //copia e instancia de la clase 
        clsUsuario objUsuario = new clsUsuario();

        //objeto de tipo dataset para recibir los registros
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                listarUsuarios();
            }
        }

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
            // CLAVE viene de DataKeyNames="CLAVE"
            int clave = int.Parse(gvUsuarios.DataKeys[e.NewSelectedIndex].Value.ToString());

            // Guardar en sesión para la página de ABC Usuarios
            Session["cveSel"] = clave;

            // MUY IMPORTANTE: reiniciar opMod para que frmAdABCUsuario cargue los datos
            Session["opMod"] = 0;

            Response.Redirect("frmAdABCUsuario.aspx", false);
        }

        protected void gvUsuarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //ejecutar el metodo de eliminar
            int resultado = objUsuario.eliminarUsuario(
                Application["cnnVentas"].ToString(),
                int.Parse(gvUsuarios.Rows[e.RowIndex].Cells[3].Text.ToString()));

            //validar el resultado para saber que se hizo
            if (resultado == 1)
            {
                Response.Write("<script language='javascript'>alert('El usuario con clave: "
                    + gvUsuarios.Rows[e.RowIndex].Cells[3].Text.ToString() +
                    " fue dado de baja correctamente!');</script>");
                listarUsuarios();
            }
            else if (resultado == 0)
            {
                Response.Write("<script language='javascript'>alert ('El usuario con clave: "
                    + gvUsuarios.Rows[e.RowIndex].Cells[3].Text.ToString() +
                    " ya ha sido dado de baja anteriormente.');</script>");
            }
            else
            {
                Response.Write("<script language='javascript'>alert ('La clave: "
                    + gvUsuarios.Rows[e.RowIndex].Cells[3].Text.ToString() +
                    " NO pertenece a ningún usuario registrado anteriormente.');</script>");
            }
        }

        protected void gvUsuarios_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int claveEmpleado = int.Parse(gvUsuarios.DataKeys[e.NewEditIndex].Value.ToString());
            Session["cveSel"] = claveEmpleado;

            // Aquí lo sigues mandando a frmAdMensajes, lo dejo igual:
            Response.Redirect("frmAdMensajes.aspx", false);

            // Si algún día quisieras que esto también vaya a frmAdABCUsuario:
            // Session["opMod"] = 0;
            // Response.Redirect("frmAdABCUsuario.aspx", false);
        }

        protected void gvUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuarios.PageIndex = e.NewPageIndex;
            listarUsuarios();
        }
    }
}
