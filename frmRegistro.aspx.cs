using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto
{
    public partial class Formulario_web15 : System.Web.UI.Page
    {
        clsUsuario objUsuario = new clsUsuario();

        // Variables para foto
        string ruta = "", foto = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtRol.Text = "CLIENTE";

                if (string.IsNullOrEmpty(imgbFoto.ImageUrl))
                {
                    imgbFoto.ImageUrl = "~/IMAGENES/userDefault.jpg";
                }
            }
        }

        protected void imgbFoto_Click(object sender, ImageClickEventArgs e)
        {
            if (examinar.HasFile)
            {
                ruta = Server.MapPath("~/IMAGENES/");
                string nombreArchivo = System.IO.Path.GetFileName(examinar.FileName);
                string rutaCompleta = System.IO.Path.Combine(ruta, nombreArchivo);

                examinar.PostedFile.SaveAs(rutaCompleta);

                foto = "~/IMAGENES/" + nombreArchivo;

                imgbFoto.ImageUrl = foto;
                imgbFoto.ImageAlign = ImageAlign.Middle;

                hddRutaFisica.Text = foto;
            }
            else
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "noFoto",
                    "alert('Primero selecciona una imagen dando clic en \"Elegir Archivo\".');",
                    true
                );
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmPrincipal.aspx");
        }

        // ======================================================
        //  VALIDAR DATOS
        // ======================================================
        private string validarDatos()
        {
            string mensaje = "";

            if (txtNombre.Text == "") mensaje += "* Nombre del usuario \\n";
            if (txtApPa.Text == "") mensaje += "* Apellido paterno \\n";
            if (txtApMa.Text == "") mensaje += "* Apellido materno \\n";
            if (txtEmail.Text == "") mensaje += "* Correo electrónico \\n";
            if (txtRfc.Text == "") mensaje += "* RFC \\n";
            if (txtCel.Text == "") mensaje += "* Número de celular \\n";
            if (txtCalle.Text == "") mensaje += "* Calle \\n";
            if (txtCol.Text == "") mensaje += "* Colonia \\n";
            if (txtNum.Text == "") mensaje += "* Número interior o exterior \\n";
            if (txtColo.Text == "") mensaje += "* Código postal \\n";
            if (txtCiudad.Text == "") mensaje += "* Ciudad \\n";
            if (txtMuni.Text == "") mensaje += "* Municipio \\n";
            if (txtEstado.Text == "") mensaje += "* Estado \\n";
            if (hddRutaFisica.Text == "") mensaje += "* Fotografía \\n";

            if (txtUsuarioAcceso.Text == "") mensaje += "* Usuario de acceso \\n";

            // Contraseñas
            if (txtContraseña.Text == "") mensaje += "* Contraseña \\n";
            if (txtConfiContra.Text == "") mensaje += "* Confirmar contraseña \\n";
            if (txtContraseña.Text != "" && txtConfiContra.Text != "" &&
                txtContraseña.Text != txtConfiContra.Text)
                mensaje += "* Las contraseñas no coinciden \\n";

            return mensaje;
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            string msg = validarDatos();

            if (msg != "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "errores",
                    "alert('Los siguientes datos deben ser ingresados: \\n" + msg + "');",
                    true
                );
                return;
            }

            // =================================
            //     REGISTRO SIN ERRORES
            // =================================

            int resultado = -1;

            // Rol CLIENTE (en tu BD es 3)
            int rol = 3;

            try
            {
                resultado = objUsuario.RegistrarUsuario(
                    Application["cnnVentas"].ToString(),
                    rol,
                    txtNombre.Text,
                    txtApPa.Text,
                    txtApMa.Text,
                    txtUsuarioAcceso.Text,
                    txtContraseña.Text,
                    hddRutaFisica.Text,
                    txtRfc.Text,
                    txtCalle.Text,
                    txtNum.Text,
                    txtCol.Text,
                    txtCiudad.Text,
                    txtMuni.Text,
                    txtEstado.Text,
                    int.Parse(txtColo.Text),
                    txtTel.Text,
                    txtCel.Text,
                    txtEmail.Text
                );
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "errorBD",
                    "alert('Ocurrió un error en la Base de Datos: " +
                    ex.Message.Replace("'", "") + "');",
                    true
                );
                return;
            }

            // =================================
            //   INTERPRETAR CÓDIGO RESULTADO
            //   SP: 1 = OK, 2 = usuario repetido, 3 = correo repetido
            // =================================

            if (resultado == 1)
            {
                string nombreCompleto = txtNombre.Text + " " + txtApPa.Text;
                if (!string.IsNullOrWhiteSpace(txtApMa.Text))
                    nombreCompleto += " " + txtApMa.Text;

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "ok",
                    "alert('El cliente " + nombreCompleto +
                    " ha sido registrado correctamente.');" +
                    "window.location='frmInicioSesion.aspx';",
                    true
                );
            }
            else if (resultado == 2)
            {
                // Usuario de acceso repetido
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "usuarioDuplicado",
                    "alert('El nombre de usuario \"" + txtUsuarioAcceso.Text +
                    "\" ya está en uso. Por favor elige otro.');",
                    true
                );
            }
            else if (resultado == 3)
            {
                // Correo repetido
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "correoDuplicado",
                    "alert('El correo \"" + txtEmail.Text +
                    "\" ya está registrado. Usa otro correo o inicia sesión.');",
                    true
                );
            }
            else
            {
                // Cualquier otro código inesperado
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "fail",
                    "alert('No fue posible registrar al usuario. Intenta más tarde.');",
                    true
                );
            }
        }
    }
}
