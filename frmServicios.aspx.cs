using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wssProyecto
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {
        clsCarrito objCarrito = new clsCarrito();
        DataSet ds;

        // Página actual del paginador
        private int PaginaActual
        {
            get
            {
                object o = ViewState["PaginaActual"];
                return (o == null) ? 0 : (int)o;
            }
            set
            {
                ViewState["PaginaActual"] = value;
            }
        }

        // Filtro de texto (Destino / Servicio)
        private string FiltroTexto
        {
            get { return (ViewState["FiltroTexto"] as string) ?? string.Empty; }
            set { ViewState["FiltroTexto"] = value; }
        }

        // Filtro de categoría
        private string FiltroCategoria
        {
            get { return (ViewState["FiltroCategoria"] as string) ?? "Todos"; }
            set { ViewState["FiltroCategoria"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PaginaActual = 0;
                FiltroTexto = string.Empty;
                FiltroCategoria = "Todos";

                ddlCategoria.SelectedValue = "Todos";

                CargarServicios();
            }
        }

        private void CargarServicios()
        {
            ds = objCarrito.listarServiciosCliente(
                    Application["cnnVentas"].ToString()
                 );

            if (ds != null &&
                ds.Tables.Count > 0 &&
                ds.Tables["Servicios"].Rows.Count > 0)
            {
                DataTable tabla = ds.Tables["Servicios"];
                DataView dv = tabla.DefaultView;

                // Construir expresión de filtro
                string expresionFiltro = string.Empty;

                // 1) Filtro de texto (Destino o Servicio)
                if (!string.IsNullOrEmpty(FiltroTexto))
                {
                    string textoEscapado = FiltroTexto.Replace("'", "''");
                    expresionFiltro += $"(Destino LIKE '%{textoEscapado}%' OR Servicio LIKE '%{textoEscapado}%')";
                }

                // 2) Filtro de categoría
                if (FiltroCategoria != "Todos")
                {
                    string categoriaEscapada = FiltroCategoria.Replace("'", "''");
                    if (!string.IsNullOrEmpty(expresionFiltro))
                    {
                        expresionFiltro += " AND ";
                    }
                    expresionFiltro += $"Categoria = '{categoriaEscapada}'";
                }

                dv.RowFilter = expresionFiltro;

                // Paginación
                var pds = new PagedDataSource
                {
                    DataSource = dv,
                    AllowPaging = true,
                    PageSize = 6,
                    CurrentPageIndex = PaginaActual
                };

                ViewState["TotalPaginas"] = pds.PageCount;

                if (pds.Count > 0)
                {
                    rptServicios.DataSource = pds;
                    rptServicios.DataBind();

                    rptServicios.Visible = true;
                    pnlSinServicios.Visible = false;

                    if (pds.PageCount > 1)
                    {
                        pnlPager.Visible = true;
                        lblPagina.Text = $"Página {PaginaActual + 1} de {pds.PageCount}";
                        lnkAnterior.Enabled = !pds.IsFirstPage;
                        lnkSiguiente.Enabled = !pds.IsLastPage;
                    }
                    else
                    {
                        pnlPager.Visible = false;
                    }
                }
                else
                {
                    rptServicios.Visible = false;
                    pnlSinServicios.Visible = true;
                    pnlPager.Visible = false;
                }

                // Reflejar filtros en los controles
                txtBuscar.Text = FiltroTexto;
                if (ddlCategoria.Items.FindByValue(FiltroCategoria) != null)
                {
                    ddlCategoria.SelectedValue = FiltroCategoria;
                }
            }
            else
            {
                rptServicios.Visible = false;
                pnlSinServicios.Visible = true;
                pnlPager.Visible = false;
            }
        }

        protected void lnkAnterior_Click(object sender, EventArgs e)
        {
            if (PaginaActual > 0)
            {
                PaginaActual--;
                CargarServicios();
            }
        }

        protected void lnkSiguiente_Click(object sender, EventArgs e)
        {
            int totalPaginas = (ViewState["TotalPaginas"] == null)
                ? 0
                : (int)ViewState["TotalPaginas"];

            if (PaginaActual < totalPaginas - 1)
            {
                PaginaActual++;
                CargarServicios();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            FiltroTexto = txtBuscar.Text.Trim();
            FiltroCategoria = ddlCategoria.SelectedValue;
            PaginaActual = 0;
            CargarServicios();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            ddlCategoria.SelectedValue = "Todos";

            FiltroTexto = string.Empty;
            FiltroCategoria = "Todos";
            PaginaActual = 0;

            CargarServicios();
        }
    }
}
