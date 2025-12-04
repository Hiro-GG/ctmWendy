using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{

    public partial class Formulario_web1 : System.Web.UI.Page
    {
        clsCarrito objCarrito = new clsCarrito();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["nombreUsuario"] != null)
            {
                lblSesion.Text = Session["nombreUsuario"].ToString();
            }

            if (!IsPostBack)
            {
                CargarMetricas();
            }
        }
        private void CargarMetricas()
        {
            try
            {
                // Llamamos al método 
                DataSet ds = objCarrito.obtenerResumenAdmin(Application["cnnVentas"].ToString());

                if (ds.Tables["ResumenAdmin"].Rows.Count > 0)
                {
                    DataRow dr = ds.Tables["ResumenAdmin"].Rows[0];

                    // Asignamos los valores a los Labels
                    lblTotalViajes.Text = dr["TotalViajes"].ToString();
                    lblTotalClientes.Text = dr["TotalClientes"].ToString();
                    lblReservasHoy.Text = dr["ReservasHoy"].ToString();

                    
                    double ingresos = Convert.ToDouble(dr["IngresosMes"]);
                    lblIngresosMes.Text = ingresos.ToString("C2"); 
                }
            }
            catch (Exception ex)
            {
                // Si falla la conexión, mostramos ceros
                lblTotalViajes.Text = "-";
                lblIngresosMes.Text = "$0.00";
            }
        }
    }
}