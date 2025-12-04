using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.CLIENTE
{
    public partial class Formulario_web13 : System.Web.UI.Page
    {
        clsUsuario objCarrito = new clsUsuario();

        // Variables para foto
        string ruta = "", foto = "";
        int clave = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Aseguramos que existan las variables de sesión
                if (Session["opMod"] == null) Session["opMod"] = 0;
                if (Session["cveSel"] == null) Session["cveSel"] = 0;

                // RECUPERAR LA CLAVE CORRECTA
                int claveParaBuscar = 0;

                // Caso 1: Vienes de seleccionar un usuario (Admin editando a alguien)
                if (Session["cveSel"] != null && Session["cveSel"].ToString() != "0")
                {
                    claveParaBuscar = int.Parse(Session["cveSel"].ToString());
                    Session["opMod"] = 1; // Indicamos que es modificación
                }
                // Caso 2: Es el usuario viendo su propio perfil (desde login)
                else if (Session["CveUsuario"] != null)
                {
                    claveParaBuscar = int.Parse(Session["CveUsuario"].ToString());
                    Session["cveSel"] = claveParaBuscar; // Igualamos para que funcione el botón modificar
                    Session["opMod"] = 1;
                }

                // SI ENCONTRAMOS UNA CLAVE VÁLIDA, BUSCAMOS
                if (claveParaBuscar > 0)
                {
                    // Asignamos a la variable global
                    clave = claveParaBuscar;

                    objCarrito.buscarUsuario(Application["cnnVentas"].ToString(), claveParaBuscar);

                    // Asignar valores a los controles
                    txtNombre.Text = objCarrito.NomUsuario;
                    txtApPa.Text = objCarrito.ApeP1;
                    txtApMa.Text = objCarrito.ApeM1;

                    txtUsuarioAcceso.ReadOnly = true;
                    txtUsuarioAcceso.Text = objCarrito.UsuAcceso1;

                    // Contraseña
                    txtContraseña.Text = objCarrito.ContrAcceso;
                    txtConfiContra.Text = objCarrito.ContrAcceso;

                    txtRfc.Text = objCarrito.Rfc1;
                    txtEmail.Text = objCarrito.Correo;
                    txtTel.Text = objCarrito.Telefono;
                    txtCel.Text = objCarrito.Celular;
                    txtCalle.Text = objCarrito.Calle;
                    txtCol.Text = objCarrito.Colonia;
                    txtEstado.Text = objCarrito.Estado;
                    txtNum.Text = objCarrito.Numero;
                    txtColo.Text = objCarrito.CodigoPostal.ToString();
                    txtCiudad.Text = objCarrito.Ciudad;
                    txtMuni.Text = objCarrito.Municipio;

                    // Foto
                    hddRutaFisica.Text = objCarrito.Foto1;
                    if (!string.IsNullOrEmpty(objCarrito.Foto1))
                    {
                        imgbFoto.ImageUrl = hddRutaFisica.Text;
                    }

                    // Rol solo informativo
                    txtRol.Text = objCarrito.Rol;
                }
            }
        }

        protected void imgbFoto_Click(object sender, ImageClickEventArgs e)
        {
            if (examinar.HasFile)
            {
                ruta = ""; foto = "";
                //permite refenciar una carpeta en el sitio web
                ruta = Server.MapPath("../IMAGENES/");
                //guarda la imagen en la ruta especifica
                examinar.PostedFile.SaveAs(ruta + examinar.FileName);
                //muestra la imagen cargada 
                foto = examinar.FileName;

                imgbFoto.ImageUrl = "../IMAGENES/" + foto;
                imgbFoto.ImageAlign = ImageAlign.Middle;

                hddRutaFisica.Text = "../IMAGENES/" + foto;
            }
        }

        // ======================================================
        //  VALIDAR DATOS
        // ======================================================
        private string validarDatos()
        {
            string mensaje = "";

            if (txtNombre.Text == "")
                mensaje += "* Nombre del usuario \n";
            if (txtApPa.Text == "")
                mensaje += "* Apellido paterno \n";
            if (txtApMa.Text == "")
                mensaje += "* Apellido materno \n";
            if (txtEmail.Text == "")
                mensaje += "* Correo electrónico \n";
            if (txtRfc.Text == "")
                mensaje += "* RFC \n";
            if (txtCel.Text == "")
                mensaje += "* Número de celular \n";
            if (txtCalle.Text == "")
                mensaje += "* Calle \n";
            if (txtCol.Text == "")
                mensaje += "* Colonia \n";
            if (txtNum.Text == "")
                mensaje += "* Número interior o exterior \n";
            if (txtColo.Text == "")
                mensaje += "* Código postal \n";
            if (txtCiudad.Text == "")
                mensaje += "* Ciudad \n";
            if (txtMuni.Text == "")
                mensaje += "* Municipio \n";
            if (txtEstado.Text == "")
                mensaje += "* Estado \n";
            if (hddRutaFisica.Text == "")
                mensaje += "* Fotografía \n";
            if (txtUsuarioAcceso.Text == "")
                mensaje += "* Usuario \n";

            // Contraseña
            if (txtContraseña.Text == "")
                mensaje += "* Contraseña \n";
            if (txtConfiContra.Text == "")
                mensaje += "* Confirmar contraseña \n";
            if (txtContraseña.Text != "" && txtConfiContra.Text != txtContraseña.Text)
                mensaje += "* Las contraseñas no coinciden \n";

            return mensaje;
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            int resultado = 0;
            string msg = validarDatos();
            string msgParaJS = msg.Replace("\n", "\\n");

            if (msg == "")
            {
                // ======================================
                // Para el cliente, forzamos el rol CLIENTE
                // en tu tabla TG_ROL, CLIENTE es ROL_Clave = 3
                // ======================================
                int rolCliente = 3; // ajusta si en tu catálogo de roles CLIENTE tiene otro número

                // Obtenemos la clave del usuario desde sesión
                int claveUsuario = 0;
                if (Session["cveSel"] != null && Session["cveSel"].ToString() != "0")
                    claveUsuario = int.Parse(Session["cveSel"].ToString());
                else if (Session["CveUsuario"] != null)
                    claveUsuario = int.Parse(Session["CveUsuario"].ToString());

                if (claveUsuario == 0)
                {
                    string scriptSinClave = "alert('No se encontró la clave del usuario en la sesión. Vuelva a iniciar sesión.');";
                    Response.Write("<script language='javascript'>" + scriptSinClave + "</script>");
                    return;
                }

                // --- NO HAY ERRORES, LLAMAMOS A modificarUsuario CON LA NUEVA FIRMA ---
                resultado = objCarrito.modificarUsuario(
                    Application["cnnVentas"].ToString(),
                    claveUsuario,                    // p_USU_Clave
                    rolCliente,                      // p_ROL_Clave
                    txtNombre.Text.Trim(),           // Nombre
                    txtApPa.Text.Trim(),             // Apellido Paterno
                    txtApMa.Text.Trim(),             // Apellido Materno
                    txtEmail.Text.Trim(),            // Correo
                    txtTel.Text.Trim(),              // Teléfono
                    txtCel.Text.Trim(),              // Celular
                    txtRfc.Text.Trim(),              // RFC
                    txtCalle.Text.Trim(),            // Calle
                    txtNum.Text.Trim(),              // Número
                    txtCol.Text.Trim(),              // Colonia
                    int.Parse(txtColo.Text.Trim()),  // Código Postal
                    txtCiudad.Text.Trim(),           // Ciudad
                    txtMuni.Text.Trim(),             // Municipio
                    txtEstado.Text.Trim(),           // Estado
                    hddRutaFisica.Text,              // Foto
                    txtContraseña.Text               // Contraseña
                );

                if (resultado > 0)
                {
                    // --- ÉXITO ---
                    string nombreCompleto = txtNombre.Text + " " + txtApPa.Text;
                    if (!string.IsNullOrEmpty(txtApMa.Text))
                    {
                        nombreCompleto += " " + txtApMa.Text;
                    }

                    Session["nombreUsuario"] = nombreCompleto;

                    // Actualizar label de la master si existe
                    Label lblSesionEnMaster = (Label)this.Master.FindControl("lblSesion");
                    if (lblSesionEnMaster != null)
                    {
                        // Si tienes Session["Rol"] con texto de rol, lo concatenas
                        if (Session["Rol"] != null)
                            lblSesionEnMaster.Text = Session["nombreUsuario"].ToString() + "\n, " + Session["Rol"].ToString();
                        else
                            lblSesionEnMaster.Text = Session["nombreUsuario"].ToString();
                    }

                    string script = "alert('Los datos del cliente " + nombreCompleto +
                                    " han sido modificados correctamente.');";
                    Response.Write("<script language='javascript'>" + script + "</script>");

                    Session["opMod"] = 0;
                }
                else if (resultado == 0)
                {
                    string script = "alert('El usuario no existe o está dado de baja, por lo tanto los datos no fueron modificados.');";
                    Response.Write("<script language='javascript'>" + script + "</script>");
                }
                else
                {
                    string script = "alert('El usuario " + txtNombre.Text + " " + txtApPa.Text +
                                    " NO pudo modificar sus datos, verifique la información o contacte al administrador.');";
                    Response.Write("<script language='javascript'>" + script + "</script>");
                }
            }
            else
            {
                // --- SÍ HAY ERRORES DE VALIDACIÓN ---
                string scriptError = "alert('Los siguientes datos deben ser ingresados: \\n" + msgParaJS + "');";
                Response.Write("<script language='javascript'>" + scriptError + "</script>");
            }
        }
    }
}
