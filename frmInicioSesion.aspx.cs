using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto
{
    public partial class Formulario_web11 : System.Web.UI.Page
    {
        //copia e instancia de la clase 
        clsUsuario objUsu = new clsUsuario();
        protected void Page_Load(object sender, EventArgs e)
        {
            // Se verifica que la sesión no sea nula antes de usarla para evitar errores en la carga inicial.
            if (Session["nombreUsuario"] != null && !string.IsNullOrEmpty(Session["nombreUsuario"].ToString()))
            {
                Session["cveUsuario"] = Session["cveUsuario"].ToString();
                lblSesion.Text = "Sesión activa: " + Session["nombreUsuario"].ToString() + " (" + Session["Rol"].ToString() + ")";
                Session["cveSel"] = Session["cveUsuario"].ToString();
            }
        }

   

        protected void btnLogin_Click1(object sender, EventArgs e)
        {
            try
            {
                //3.validar que lo controles tengan datos 
                if (txtUsuario.Text != "" && txtPassword.Text != "")
                {
                    //3.1 asignar los valores a las propiedades de la clase
                    objUsu.Usuario = txtUsuario.Text;
                    objUsu.Contra = txtPassword.Text;

                    //3.2 ejecutar el metodo de la clase que valida el acceso
                    objUsu.validarAcceso(Application["cnnVentas"].ToString());

                    //3.3 si permite el acceso o no al sistema 
                    if (objUsu.Clave != 0)
                    {
                        //se asignan los datos a la variable de sesion
                        Session["cveUsuario"] = objUsu.Clave;
                        Session["nombreUsuario"] = objUsu.NomUsuario;
                        Session["Rol"] = objUsu.Rol;

                        if (objUsu.Rol.ToUpper() == "ADMINISTRADOR")
                        {
                            Response.Write("<script language='javascript'>alert('Bienvenido "
                                + objUsu.NomUsuario + ", estás accediendo como " + objUsu.Rol + "');"
                                + "document.location.href='ADMINISTRADOR/frmAdministrador.aspx';</script>");
                        }
                        else if (objUsu.Rol.ToUpper() == "VENDEDOR")
                        {
                            Response.Write("<script language='javascript'>alert('Bienvenido "
                               + objUsu.NomUsuario + ", estás accediendo como " + objUsu.Rol + "');"
                               + "document.location.href='VENDEDOR/frmVendedor.aspx';</script>");
                        }
                        else if (objUsu.Rol.ToUpper() == "CLIENTE")
                        {
                            Response.Write("<script language='javascript'>alert('Bienvenido "
                                + objUsu.NomUsuario + ", estás accediendo como " + objUsu.Rol + "');"
                                + "document.location.href='CLIENTE/frmCliente.aspx';</script>");
                        }
                    }
                    else
                    {
                        Response.Write("<script language='javascript'>" +
                            "alert('!ACCESO DENEGADO!');" +
                            "</script>");
                    }
                }
                else
                {
                    // aquí podrías agregar código para manejar campos vacíos si deseas
                    Response.Write("<script language='javascript'>" +
                            "alert('!DEBES DE INGRESAR EL USUARIO Y LA CONTRASEÑA!');" +
                            "</script>");
                    txtUsuario.Focus();

                }
            }
            catch (Exception)
            {
                Response.Write("<script language='javascript'>" +
                            "alert('!Verificar la cadena de conexion y datos de conexión!');" +
                            "</script>");
            }
        }
    }
}

