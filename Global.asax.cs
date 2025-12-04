using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace wssProyecto
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            //variable de aplicacion que contiene la cadena de conexion a la base de datos
            Application["cnnVentas"] = ConfigurationManager.ConnectionStrings["cnnVentas"].ConnectionString.ToString();
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            //variables de sesion
            Session["cveUsuario"] = 0;
            Session["nombreUsuario"] = "";
            Session["Rol"] = "";
            Session["cveSel"] = 0;
            Session["numTel"] = 0;
            //variable para manejo de ventas
            Session["venActual"] = 0;
            Session["selProducto"] = 0;
            Session["selCompra"] = 0;
            Session["opMod"] = 0;
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}