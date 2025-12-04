using System;
using System.Data;
using System.Web;
using System.Web.UI;

namespace wssProyecto.CLIENTE
{
    public partial class Formulario_web1 : System.Web.UI.Page
    {
        clsCarrito objCarrito = new clsCarrito();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                string soloNombre = "Cliente";

                
                if (Session["nombreUsuario"] != null)
                {
                    string nombreCompleto = Session["nombreUsuario"].ToString();
                    soloNombre = ObtenerSoloNombre(nombreCompleto);
                }
                lblNombreCliente.Text = soloNombre;
                if (Session["cveUsuario"] != null)
                {
                    CargarResumenUsuario(int.Parse(Session["cveUsuario"].ToString()));
                }
            }
        }
        private void CargarResumenUsuario(int idUsuario)
        {
            try
            {
                // Llamamos al método 
                DataSet ds = objCarrito.obtenerResumenCliente(
                    Application["cnnVentas"].ToString(),
                    idUsuario
                );

                if (ds.Tables["Resumen"].Rows.Count > 0)
                {
                    DataRow dr = ds.Tables["Resumen"].Rows[0];

                    // Asignamos los valores a los Labels nuevos
                    lblReservasActivas.Text = dr["Activas"].ToString();
                    lblUltimoViaje.Text = dr["UltimoViaje"].ToString();
                }
            }
            catch (Exception)
            {
                // En caso de error, dejamos valores por defecto
                lblReservasActivas.Text = "0";
                lblUltimoViaje.Text = "N/A";
            }
        }

        private string ObtenerSoloNombre(string nombreCompleto)
        {
            if (string.IsNullOrWhiteSpace(nombreCompleto))
                return "Cliente";

            string[] partes = nombreCompleto
                                .Trim()
                                .Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

            if (partes.Length == 0)
                return "Cliente";

            return partes[0];
        }
    }
}
