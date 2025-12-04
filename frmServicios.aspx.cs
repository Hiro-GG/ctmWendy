using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {
        //copia e instancia de la clase 
        clsCarrito objCarrito = new clsCarrito();
        //objeeto de tipo dataset para recibir los registros
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            //metodo que muestra los productos
            verProducto();

        }
        void verProducto()
        {
            ds = new DataSet();
            ds = objCarrito.listarServiciosCliente(Application["cnnVentas"].ToString());

            //asigna los valores recibidos al gridview
            gvServicios.DataSource = ds;
            //necesita el alias que se genero en la clase 
            gvServicios.DataMember = "Servicios";
            //permite que se muestren los datos
            gvServicios.DataBind();
            //se hace visible el grid view
            gvServicios.Visible = true;
        }

        protected void gvServicios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //se genera la nueva pagina de datos 
            gvServicios.PageIndex = e.NewPageIndex;
            //se llenan los registros de la pagina
            verProducto();
        }
    }
}