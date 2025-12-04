using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Formulario_web15 : System.Web.UI.Page
    {
        clsUsuario objUsuario = new clsUsuario();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["cveSel"] != null && Session["cveSel"].ToString() != "")
                {
                    int clave = int.Parse(Session["cveSel"].ToString());
                    mostrarUsuario(clave);
                }
                else
                {
                    Response.Redirect("frmUadmin.aspx", false);
                }
            }
        }
        void mostrarUsuario(int clave)
        {
            objUsuario.buscarUsuario(Application["cnnVentas"].ToString(), clave);

            if (objUsuario.Clave != 0)
            {
                if (objUsuario.Rol != "")
                {
                    Session["numTel"] = objUsuario.Celular;

                    txtUsuario.Text = objUsuario.NomUsuario + " " +
                                      objUsuario.ApeP1 + " " +
                                      objUsuario.ApeM1;

                    txtRol.Text = objUsuario.Rol;
                    imgFoto.ImageUrl = objUsuario.Foto1;
                }
                else
                {
                    Response.Write("<script>alert('Debes seleccionar un usuario con número de teléfono correcto.');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('El usuario está dado de baja.');</script>");
            }
        }

        protected void btnEnviarMensaje_Click(object sender, EventArgs e)
        {
            int ban = 0;
            string msg = "Necesitas los siguientes datos para enviar un mensaje por WhatsApp:\\n\\n";

            if (txtUsuario.Text == "")
                msg += "* Nombre del contacto y su teléfono\\n";

            if (txtMensaje.Text == "")
            {
                ban = 1;
                msg += "* Mensaje a enviar\\n";
            }

            if (ban == 0)
            {
                string ruta = "https://api.whatsapp.com/send?phone=52"
                    + Session["numTel"].ToString() + "&text=" + txtMensaje.Text;

                Response.Write("<script>window.open('" + ruta + "','popup','width=700,height=700');</script>");
            }
            else
            {
                Response.Write("<script>alert('" + msg + "');</script>");
            }
        }

        protected void btnSeleccionarU_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmUadmin.aspx", false);
        }
    }
}