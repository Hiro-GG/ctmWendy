using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //esto se hace para personalizar la sesion
            if (Session["nombreUsuario"].ToString() != "")
            {
                Session["cveUsuario"] = Session["cveUsuario"].ToString();
                lblSesion.Text = Session["nombreUsuario"].ToString() + "\n" + ", " + Session["Rol"].ToString();
            }
        }
    }
}