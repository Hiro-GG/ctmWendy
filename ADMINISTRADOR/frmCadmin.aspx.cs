using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Formulario_web11 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //se limpian todas las variables de sesion 
            Session["cveUsuario"] = 0;
            Session["nombreUsuario"] = "";
            Session["Rol"] = "";
            Session["cveSel"] = 0;

            //cuando se tengan otras variables de sesión se deben liberar tambien 

            //se redirecciona a la pagina principal
            Response.Redirect("../frmPrincipal.aspx");
        }
    }
}