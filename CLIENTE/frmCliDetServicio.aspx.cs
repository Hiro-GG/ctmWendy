using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.CLIENTE
{
    public partial class frmCliDetServicio : System.Web.UI.Page
    {
        clsCarrito objCarrito = new clsCarrito();
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            verProducto();
        }
        void verProducto()
        { 
            ds=new DataSet();
            ds = objCarrito.buscarProducto(Application["cnnVentas"].ToString(),
                int.Parse(Session["selProducto"].ToString()));

            dtvProducto.DataSource = ds;
            dtvProducto.DataMember = "ServicioEncontrado";
            dtvProducto.DataBind();
            dtvProducto.Visible = true;
        }
    }
}