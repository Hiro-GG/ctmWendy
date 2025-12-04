using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Formulario_web16 : System.Web.UI.Page
    {
        clsServicio objServicio = new clsServicio();
        string ruta = "", foto = "";
        int clave = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Form.Enctype = "multipart/form-data";

            ScriptManager sm = ScriptManager.GetCurrent(this);
            if (sm != null)
            {
                sm.RegisterPostBackControl(btnRegistrar);
                sm.RegisterPostBackControl(btnModificar);
                sm.RegisterPostBackControl(btnNuevo);
            }

            if (Session["cveSel"] == null) Session["cveSel"] = 0;
            if (Session["opMod"] == null) Session["opMod"] = 0;

            if (!IsPostBack)
            {
                try
                {
                    llenarDropProveedor();
                    llenarDropCategoria();
                    llenarDropDestino();

                    // Estatus por defecto
                    ddlEstatus.SelectedValue = "1";
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error cargando listas: " + ex.Message);
                }

                int claveSel = 0;
                int.TryParse(Session["cveSel"].ToString(), out claveSel);

                if (claveSel > 0)
                {
                    Session["opMod"] = 1;
                    clave = claveSel;

                    try
                    {
                        objServicio.buscarServicio(Application["cnnVentas"].ToString(), clave);

                        seleccionarDropByValue(ddlCategoria, objServicio.Categoria.ToString());
                        seleccionarDropByValue(ddlDestino, objServicio.Destino.ToString());
                        seleccionarDropByValue(ddlProveedor, objServicio.Proveedor.ToString());

                        txtCodigo.Text = objServicio.Codigo;
                        txtNombre.Text = objServicio.Nombre;
                        txtDescripcion.Text = objServicio.Descripcion;
                        txtCosto.Text = objServicio.Costo.ToString();
                        txtDisponibilidad.Text = objServicio.Disponibilidad.ToString();

                        if (!string.IsNullOrEmpty(objServicio.Imagen))
                        {
                            hddRutaFisica.Text = objServicio.Imagen;
                            imgbFoto.ImageUrl = objServicio.Imagen;
                        }

                        // Cargar estatus desde la BD (1 = disponible, 0 = no disponible)
                        if (ddlEstatus.Items.FindByValue(objServicio.Estatus.ToString()) != null)
                            ddlEstatus.SelectedValue = objServicio.Estatus.ToString();

                        GestionarBotones(false);
                    }
                    catch (Exception ex)
                    {
                        MostrarMensaje("Error cargando servicio: " + ex.Message);
                    }
                }
                else
                {
                    GestionarBotones(true);
                    txtCodigo.Text = GenerarCodigoServicio();
                    ddlEstatus.SelectedValue = "1";
                }
            }
        }

        private void GestionarBotones(bool esNuevo)
        {
            if (esNuevo)
            {
                btnRegistrar.Visible = true;
                btnModificar.Visible = false;
            }
            else
            {
                btnRegistrar.Visible = false;
                btnModificar.Visible = true;
            }
        }

        private void llenarDropProveedor() { LlenarDropGenerico(ddlProveedor, "call tspListarProveedores();", "PRO_Id", "PRO_Nombre", "proveedor"); }
        private void llenarDropCategoria() { LlenarDropGenerico(ddlCategoria, "SELECT CAT_Clave, CAT_Nombre FROM TG_CATEGORIA WHERE CAT_Estatus='A'", "CAT_Clave", "CAT_Nombre", "categoría"); }
        private void llenarDropDestino() { LlenarDropGenerico(ddlDestino, "SELECT DES_Id, DES_Nombre FROM TG_DESTINO WHERE DES_Estatus='A'", "DES_Id", "DES_Nombre", "destino"); }

        private void LlenarDropGenerico(DropDownList ddl, string query, string valueField, string textField, string nombreEntidad)
        {
            string cnn = Application["cnnVentas"].ToString();
            DataTable dt = new DataTable();
            using (MySqlDataAdapter da = new MySqlDataAdapter(query, cnn)) { da.Fill(dt); }
            ddl.DataSource = dt;
            ddl.DataValueField = valueField;
            ddl.DataTextField = textField;
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem($"-- Selecciona {nombreEntidad} --", "0"));
        }

        private void seleccionarDropByValue(DropDownList ddl, string value)
        {
            if (ddl == null || string.IsNullOrEmpty(value)) return;
            ListItem item = ddl.Items.FindByValue(value);
            if (item != null) { ddl.ClearSelection(); item.Selected = true; }
        }

        protected void imgbFoto_Click(object sender, ImageClickEventArgs e)
        {
            if (examinar.HasFile)
            {
                ruta = "";
                foto = "";
                ruta = Server.MapPath("../SERVICIOS/");

                if (!System.IO.Directory.Exists(ruta))
                    System.IO.Directory.CreateDirectory(ruta);

                examinar.PostedFile.SaveAs(ruta + examinar.FileName);
                foto = examinar.FileName;

                imgbFoto.ImageUrl = "../SERVICIOS/" + foto;
                imgbFoto.ImageAlign = ImageAlign.Middle;

                hddRutaFisica.Text = "../SERVICIOS/" + foto;
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            limpiarControles();
            txtCodigo.Text = GenerarCodigoServicio();
            ddlEstatus.SelectedValue = "1";
            GestionarBotones(true);
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                string msg = validarDatos();
                if (!string.IsNullOrEmpty(msg)) { MostrarMensaje(msg); return; }

                int resultado = objServicio.registrarServicio(
                    Application["cnnVentas"].ToString(),
                    int.Parse(ddlCategoria.SelectedValue),
                    int.Parse(ddlDestino.SelectedValue),
                    int.Parse(ddlProveedor.SelectedValue),
                    txtCodigo.Text.Trim(),
                    txtNombre.Text.Trim(),
                    txtDescripcion.Text.Trim(),
                    float.Parse(txtCosto.Text.Trim()),
                    int.Parse(txtDisponibilidad.Text.Trim()),
                    hddRutaFisica.Text,
                    int.Parse(ddlEstatus.SelectedValue)   // estatus desde ddl
                );

                if (resultado > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "okReg", "alert('Servicio registrado correctamente.');", true);
                    limpiarControles();
                    txtCodigo.Text = GenerarCodigoServicio();
                    ddlEstatus.SelectedValue = "1";
                }
                else { MostrarMensaje("No fue posible registrar el servicio."); }
            }
            catch (Exception ex) { MostrarMensaje("Error interno: " + ex.Message); }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                string msg = validarDatos();
                if (!string.IsNullOrEmpty(msg)) { MostrarMensaje(msg); return; }

                if (Session["cveSel"] == null || Session["cveSel"].ToString() == "0")
                {
                    MostrarMensaje("Error de sesión.");
                    return;
                }

                int idEditar = int.Parse(Session["cveSel"].ToString());

                int resultado = objServicio.modificarServicio(
                    Application["cnnVentas"].ToString(),
                    idEditar,
                    int.Parse(ddlCategoria.SelectedValue),
                    int.Parse(ddlDestino.SelectedValue),
                    int.Parse(ddlProveedor.SelectedValue),
                    txtCodigo.Text.Trim(),
                    txtNombre.Text.Trim(),
                    txtDescripcion.Text.Trim(),
                    float.Parse(txtCosto.Text.Trim()),
                    int.Parse(txtDisponibilidad.Text.Trim()),
                    hddRutaFisica.Text,
                    int.Parse(ddlEstatus.SelectedValue)   // estatus desde ddl
                );

                if (resultado > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "okMod", "alert('Servicio modificado correctamente.');", true);
                    Session["opMod"] = 0;
                }
                else { MostrarMensaje("No fue posible modificar."); }
            }
            catch (Exception ex) { MostrarMensaje("Error: " + ex.Message); }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Session["cveSel"] = 0;
            Session["opMod"] = 0;
            Response.Redirect("frmAdminProd.aspx");
        }

        private string GenerarCodigoServicio()
        {
            string cnn = Application["cnnVentas"].ToString();
            int numeroCandidato = 1;
            string codigoFinal = "";
            bool disponible = false;

            using (MySqlConnection cn = new MySqlConnection(cnn))
            {
                cn.Open();
                string sqlMax = "SELECT MAX(SER_Id) FROM TG_SERVICIO;";
                using (MySqlCommand cmd = new MySqlCommand(sqlMax, cn))
                {
                    object r = cmd.ExecuteScalar();
                    if (r != DBNull.Value && r != null && r.ToString() != "")
                        numeroCandidato = Convert.ToInt32(r) + 1;
                }

                while (!disponible)
                {
                    codigoFinal = "SV" + numeroCandidato.ToString("000");
                    string sqlCheck = "SELECT COUNT(*) FROM TG_SERVICIO WHERE SER_Codigo = @codigo";
                    using (MySqlCommand cmdCheck = new MySqlCommand(sqlCheck, cn))
                    {
                        cmdCheck.Parameters.AddWithValue("@codigo", codigoFinal);
                        int count = Convert.ToInt32(cmdCheck.ExecuteScalar());
                        if (count == 0) disponible = true; else numeroCandidato++;
                    }
                }
            }
            return codigoFinal;
        }

        void limpiarControles()
        {
            ddlCategoria.SelectedIndex = 0;
            ddlDestino.SelectedIndex = 0;
            ddlProveedor.SelectedIndex = 0;
            txtCodigo.Text = "";
            txtNombre.Text = "";
            txtDescripcion.Text = "";
            txtCosto.Text = "";
            txtDisponibilidad.Text = "";
            ddlEstatus.SelectedValue = "1";

            imgbFoto.ImageUrl = "";
            hddRutaFisica.Text = "";

            Session["cveSel"] = 0;
            Session["opMod"] = 0;
            objServicio = new clsServicio();
        }

        string validarDatos()
        {
            string msg = "";
            if (ddlCategoria.SelectedIndex == 0) msg += "* Seleccione Categoría\\n";
            if (ddlDestino.SelectedIndex == 0) msg += "* Seleccione Destino\\n";
            if (ddlProveedor.SelectedIndex == 0) msg += "* Seleccione Proveedor\\n";
            if (string.IsNullOrWhiteSpace(txtCodigo.Text)) msg += "* Código\\n";
            if (string.IsNullOrWhiteSpace(txtNombre.Text)) msg += "* Nombre\\n";
            if (string.IsNullOrWhiteSpace(txtDescripcion.Text)) msg += "* Descripción\\n";
            if (string.IsNullOrWhiteSpace(txtCosto.Text)) msg += "* Costo\\n";
            if (string.IsNullOrWhiteSpace(txtDisponibilidad.Text)) msg += "* Disponibilidad\\n";
            if (string.IsNullOrWhiteSpace(hddRutaFisica.Text))
                msg += "* Fotografía\\n";
            return msg;
        }

        protected void lnkPaquetes_Click(object sender, EventArgs e)
        {
            // Limpia selección actual por si venías editando un servicio
            Session["cveSel"] = 0;
            Session["opMod"] = 0;

            // Redirige al ABC de paquetes
            Response.Redirect("frmAdABCPaquetes.aspx");
        }

        private void MostrarMensaje(string mensaje)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.Visible = true;
            string js = "alert('" + mensaje.Replace("'", "\\'").Replace("\n", "\\n") + "');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", js, true);
        }
    }
}
