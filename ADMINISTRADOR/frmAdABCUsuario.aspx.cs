using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Formulario_web14 : System.Web.UI.Page
    {
        clsUsuario objUsuario = new clsUsuario();
        DataSet dsRoles;
        string ruta = "", foto = "";
        int clave = 0, bandera = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                llenarDrop();
                txtUsuarioAcceso.ReadOnly = false;
                lblMensajes.Visible = false;
            }

            // Para evitar NullReference si no han puesto cveSel / opMod
            if (Session["cveSel"] == null) Session["cveSel"] = 0;
            if (Session["opMod"] == null) Session["opMod"] = 0;

            // Cargar datos de usuario seleccionado SOLO UNA VEZ (opMod = 0)
            if (Session["cveSel"].ToString() != "0" && Session["opMod"].ToString() == "0")
            {
                Session["opMod"] = 1;
                clave = int.Parse(Session["cveSel"].ToString());
                objUsuario.buscarUsuario(Application["cnnVentas"].ToString(), clave);

                // Datos
                txtNombre.Text = objUsuario.NomUsuario;
                txtApPa.Text = objUsuario.ApeP1;
                txtApMa.Text = objUsuario.ApeM1;
                txtUsuarioAcceso.ReadOnly = true;
                txtUsuarioAcceso.Text = objUsuario.UsuAcceso1;

                // Solo llenamos la contraseña, NO la confirmación
                txtContraseña.Text = objUsuario.ContrAcceso;
                txtConfiContra.Text = "";   // queda vacía para que el admin la escriba si cambia la contraseña

                txtRfc.Text = objUsuario.Rfc1;
                txtEmail.Text = objUsuario.Correo;
                txtTel.Text = objUsuario.Telefono;
                txtCel.Text = objUsuario.Celular;
                txtCalle.Text = objUsuario.Calle;
                txtCol.Text = objUsuario.Colonia;
                txtEstado.Text = objUsuario.Estado;
                txtNum.Text = objUsuario.Numero;
                txtColo.Text = objUsuario.CodigoPostal.ToString();
                txtCiudad.Text = objUsuario.Ciudad;
                txtMuni.Text = objUsuario.Municipio;

                // Foto
                hddRutaFisica.Text = objUsuario.Foto1;
                imgbFoto.ImageUrl = objUsuario.Foto1;

                // Rol (por descripción)
                seleccionarRol(objUsuario.Rol);
            }
        }

        void llenarDrop()
        {
            dsRoles = new DataSet();
            dsRoles = objUsuario.listarRoles(Application["cnnVentas"].ToString());
            dwlRoles.DataSource = dsRoles;
            dwlRoles.DataMember = "roles";
            dwlRoles.DataValueField = "Clave";
            dwlRoles.DataTextField = "Rol";
            dwlRoles.DataBind();
            dwlRoles.Items.Insert(0, "--Selecciona el tipo de usuario--");
        }

        void seleccionarRol(string rol)
        {
            for (int i = 0; i < dwlRoles.Items.Count; i++)
            {
                if (dwlRoles.Items[i].Text == rol)
                {
                    dwlRoles.SelectedIndex = i;
                    break;
                }
            }
        }

        void limpiarControles()
        {
            dwlRoles.SelectedIndex = 0;
            txtNombre.Text = "";
            txtApPa.Text = "";
            txtApMa.Text = "";
            txtEmail.Text = "";
            txtTel.Text = "";
            txtCel.Text = "";
            txtRfc.Text = "";
            txtCiudad.Text = "";
            txtCalle.Text = "";
            txtCol.Text = "";
            txtEstado.Text = "";
            txtMuni.Text = "";
            txtColo.Text = "";
            txtNum.Text = "";
            txtUsuarioAcceso.Text = "";
            txtUsuarioAcceso.ReadOnly = false;
            txtContraseña.Text = "";
            txtConfiContra.Text = "";
            hddRutaFisica.Text = "";
            imgbFoto.ImageUrl = "";
            lblMensajes.Visible = false;

            dwlRoles.Focus();
            Session["cveSel"] = 0;
            Session["opMod"] = 0;

            objUsuario = new clsUsuario();
        }

        // =========================
        //  REGISTRAR (ADMIN)
        // =========================
        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                lblMensajes.Visible = false;
                string msg = validarDatos();

                if (dwlRoles.SelectedIndex <= 0)
                {
                    MostrarMensaje("Debes seleccionar un rol o tipo de usuario.");
                    return;
                }

                if (string.IsNullOrEmpty(msg))
                {
                    int cp = 0;
                    int.TryParse(txtColo.Text.Trim(), out cp);

                    // USAR EL ROL SELECCIONADO, NO FIJO 2
                    int claveRol = int.Parse(dwlRoles.SelectedValue);

                    int resultado = objUsuario.RegistrarUsuario(
                        Application["cnnVentas"].ToString(),
                        claveRol,                            // rol desde el DropDown
                        txtNombre.Text.Trim(),
                        txtApPa.Text.Trim(),
                        txtApMa.Text.Trim(),
                        txtUsuarioAcceso.Text.Trim(),
                        txtContraseña.Text,
                        hddRutaFisica.Text,
                        txtRfc.Text.Trim(),
                        txtCalle.Text.Trim(),
                        txtNum.Text.Trim(),
                        txtCol.Text.Trim(),
                        txtCiudad.Text.Trim(),
                        txtMuni.Text.Trim(),
                        txtEstado.Text.Trim(),
                        cp,
                        txtTel.Text.Trim(),
                        txtCel.Text.Trim(),
                        txtEmail.Text.Trim()
                    );

                    if (resultado == 1)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "okReg",
                            "alert('El usuario ha sido registrado correctamente.');", true);
                        limpiarControles();
                    }
                    else if (resultado == 2)
                    {
                        MostrarMensaje("El nombre de usuario ya está asignado a otro usuario.");
                    }
                    else if (resultado == 3)
                    {
                        MostrarMensaje("El correo ya está registrado por otro usuario.");
                    }
                    else
                    {
                        MostrarMensaje("No fue posible registrar al usuario. Contacte al administrador.");
                    }
                }
                else
                {
                    MostrarMensaje(msg);
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error interno: " + ex.Message);
            }
        }

        // =========================
        //  CARGAR FOTO
        // =========================
        protected void imgbFoto_Click(object sender, ImageClickEventArgs e)
        {
            if (examinar.HasFile)
            {
                ruta = ""; foto = "";
                ruta = Server.MapPath("../IMAGENES/");
                examinar.PostedFile.SaveAs(ruta + examinar.FileName);
                foto = examinar.FileName;

                imgbFoto.ImageUrl = "../IMAGENES/" + foto;
                imgbFoto.ImageAlign = ImageAlign.Middle;

                hddRutaFisica.Text = "../IMAGENES/" + foto;
            }
        }

        protected void btnNuevoUsuario_Click(object sender, EventArgs e)
        {
            Session["cveSel"] = 0;
            Session["opMod"] = 0;
            bandera = 0;
            limpiarControles();
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Session["cveSel"] = 0;
            Session["opMod"] = 0;
            Response.Redirect("frmUadmin.aspx");
        }

        // =========================
        //  MODIFICAR USUARIO
        // =========================
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            int resultado = 0;
            string msg = validarDatos();
            string msgParaJS = msg.Replace("\n", "\\n");

            if (msg == "")
            {
                if (dwlRoles.SelectedIndex <= 0)
                {
                    string scriptRol = "alert('Debes seleccionar un rol válido.');";
                    Response.Write("<script language='javascript'>" + scriptRol + "</script>");
                    return;
                }

                int rolSeleccionado = int.Parse(dwlRoles.SelectedValue);

                resultado = objUsuario.modificarUsuario(
                    Application["cnnVentas"].ToString(),
                    int.Parse(Session["cveSel"].ToString()),
                    rolSeleccionado,
                    txtNombre.Text.Trim(),
                    txtApPa.Text.Trim(),
                    txtApMa.Text.Trim(),
                    txtEmail.Text.Trim(),
                    txtTel.Text.Trim(),
                    txtCel.Text.Trim(),
                    txtRfc.Text.Trim(),
                    txtCalle.Text.Trim(),
                    txtNum.Text.Trim(),
                    txtCol.Text.Trim(),
                    int.Parse(txtColo.Text.Trim()),
                    txtCiudad.Text.Trim(),
                    txtMuni.Text.Trim(),
                    txtEstado.Text.Trim(),
                    hddRutaFisica.Text,
                    txtContraseña.Text
                );

                if (resultado > 0)
                {
                    string nombreCompleto = txtNombre.Text + " " + txtApPa.Text;
                    if (!string.IsNullOrEmpty(txtApMa.Text))
                    {
                        nombreCompleto += " " + txtApMa.Text;
                    }

                    string script = "alert('Los datos del usuario " + nombreCompleto +
                                    " (Clave: " + Session["cveSel"].ToString() +
                                    ") han sido modificados correctamente.');";

                    Response.Write("<script language='javascript'>" + script + "</script>");
                    Session["opMod"] = 0;  // permitir recargar datos si se vuelve a entrar
                }
                else if (resultado == 0)
                {
                    string script = "alert('El usuario no existe o está dado de baja.');";
                    Response.Write("<script language='javascript'>" + script + "</script>");
                }
                else
                {
                    string script = "alert('El usuario " + txtNombre.Text + " " + txtApPa.Text +
                                    " NO pudo modificar sus datos. Verifique o contacte al administrador.');";
                    Response.Write("<script language='javascript'>" + script + "</script>");
                }
            }
            else
            {
                string scriptError = "alert('Los siguientes datos deben ser ingresados: \\n" + msgParaJS + "');";
                Response.Write("<script language='javascript'>" + scriptError + "</script>");
            }
        }

        // =========================
        //  MENSAJES
        // =========================
        private void MostrarMensaje(string mensaje)
        {
            lblMensajes.Text = mensaje;
            lblMensajes.Visible = true;

            string js = "alert('" + mensaje.Replace("'", "\\'").Replace("\n", "\\n") + "');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", js, true);
        }

        // =========================
        //  VALIDAR DATOS
        // =========================
        string validarDatos()
        {
            string mensaje = "";

            if (dwlRoles.SelectedIndex <= 0)
                mensaje += "* Rol o tipo de usuario \n";

            if (string.IsNullOrWhiteSpace(txtNombre.Text))
                mensaje += "* Nombre del usuario \n";

            if (string.IsNullOrWhiteSpace(txtApPa.Text))
                mensaje += "* Apellido paterno \n";

            if (string.IsNullOrWhiteSpace(txtApMa.Text))
                mensaje += "* Apellido materno \n";

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
                mensaje += "* Correo electrónico \n";

            if (string.IsNullOrWhiteSpace(txtCel.Text))
                mensaje += "* Número de celular \n";

            if (string.IsNullOrWhiteSpace(txtCalle.Text))
                mensaje += "* Calle \n";

            if (string.IsNullOrWhiteSpace(txtCol.Text))
                mensaje += "* Colonia \n";

            if (string.IsNullOrWhiteSpace(txtNum.Text))
                mensaje += "* Número interior o exterior \n";

            if (string.IsNullOrWhiteSpace(txtColo.Text))
                mensaje += "* Código postal \n";

            if (string.IsNullOrWhiteSpace(txtCiudad.Text))
                mensaje += "* Ciudad \n";

            if (string.IsNullOrWhiteSpace(txtMuni.Text))
                mensaje += "* Municipio \n";

            if (string.IsNullOrWhiteSpace(txtEstado.Text))
                mensaje += "* Estado \n";

            if (string.IsNullOrWhiteSpace(hddRutaFisica.Text))
                mensaje += "* Fotografía \n";

            if (string.IsNullOrWhiteSpace(txtUsuarioAcceso.Text))
                mensaje += "* Usuario \n";

            if (string.IsNullOrWhiteSpace(txtContraseña.Text))
                mensaje += "* Contraseña \n";

            if (string.IsNullOrWhiteSpace(txtConfiContra.Text))
                mensaje += "* Confirmar contraseña \n";

            if (!string.IsNullOrEmpty(txtContraseña.Text) || !string.IsNullOrEmpty(txtConfiContra.Text))
            {
                if (txtContraseña.Text != txtConfiContra.Text)
                    mensaje += "* La contraseña y la confirmación no coinciden \n";
            }

            return mensaje;
        }
    }
}
