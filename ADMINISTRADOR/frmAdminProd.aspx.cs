using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto.ADMINISTRADOR
{
    public partial class Formulario_web13 : System.Web.UI.Page
    {
        //copia e instancia de la clase 
        clsCarrito objCarrito = new clsCarrito();
        clsServicio objServicio = new clsServicio();
        //objeeto de tipo dataset para recibir los registros
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //metodo que muestra los productos
                verProducto();
            }
        }

        void verProducto()
        {
            ds = new DataSet();
            ds = objCarrito.listarProductos(Application["cnnVentas"].ToString());
            //asigna los valores recibidos al gridview
            gvAdServicios.DataSource = ds;
            //necesita el alias que se genero en la clase 
            gvAdServicios.DataMember = "Productos";
            //permite que se muestren los datos
            gvAdServicios.DataBind();
            //se hace visible el grid view
            gvAdServicios.Visible = true;
        }

        protected void gvServicios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //se genera la nueva pagina de datos 
            gvAdServicios.PageIndex = e.NewPageIndex;
            //se llenan los registros de la pagina
            verProducto();
        }

        protected void gvAdServicios_SelectedIndexChanging1(object sender, GridViewSelectEventArgs e)
        {
            int clave = int.Parse(gvAdServicios.DataKeys[e.NewSelectedIndex].Value.ToString());
            Session["cveSel"] = clave;
            Response.Redirect("frmAdABCServicios.aspx", false);
        }

        protected void gvAdServicios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //ejecutar el metodo de eliminar
            int resultado = objServicio.eliminarServicio(Application["cnnVentas"].ToString(),
                int.Parse(gvAdServicios.Rows[e.RowIndex].Cells[2].Text.ToString()));

            //validar el resultado para saber que se hizo
            if (resultado == 1)
            {
                Response.Write("<script language='javascript'>alert('El servicio con clave: "
                    + gvAdServicios.Rows[e.RowIndex].Cells[2].Text.ToString() +
                    " fue dado de baja correctamente!');</script>");
                verProducto();
            }
            else if (resultado == 0)
            {
                Response.Write("<script language='javascript'>alert ('El servicio con clave: "
                    + gvAdServicios.Rows[e.RowIndex].Cells[2].Text.ToString() +
                    " ya ha sido dado de baja anteriormente.');</script>");
            }
            else
            {
                Response.Write("<script language='javascript'>alert ('La clave: "
                    + gvAdServicios.Rows[e.RowIndex].Cells[2].Text.ToString() +
                    " NO pertenece a ningún servicio registrado anteriormente.');</script>");
            }
        }
    }
}