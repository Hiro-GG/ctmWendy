<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAdministrador.Master" AutoEventWireup="true" CodeBehind="frmAdVentas.aspx.cs" Inherits="wssProyecto.ADMINISTRADOR.Formulario_web19" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>

        /* ==========================================================
           HEADER CON IMAGEN (MISMO ESTILO QUE frmAdReportes)
        ========================================================== */
        .reportes-header {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), 
                        url('img/carousel-2.jpg');
            background-size: cover;
            background-position: center;
            padding: 80px 0;
            margin-bottom: 50px;
        }
        .reportes-header h1 {
            font-weight: 700;
        }

        /* ==========================================================
           GRIDVIEW GENERAL ESTILO PREMIUM
        ========================================================== */

        .custom-gridview {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            border-radius: 12px;
            overflow: hidden;
        }

        /* Encabezados */
        .custom-gridview th {
            background-color: #FE810B !important;
            color: white !important;
            padding: 15px !important;
            text-align: center !important;
            font-weight: 600;
            font-size: 16px;
            letter-spacing: 0.5px;
            border: none !important;
        }

        /* Celdas */
        .custom-gridview td {
            padding: 15px 10px !important;
            text-align: center !important;
            background: #ffffff;
            border-bottom: 1px solid #f0f0f0 !important;
            font-size: 15px;
        }

        /* Hover */
        .custom-gridview tr:hover td {
            background-color: #f9f9f9 !important;
            transition: 0.25s ease;
        }

        /* Paginación */
        .pager-style a, .pager-style span {
            padding: 8px 16px;
            margin: 0 4px;
            background-color: #FE810B;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: 0.3s;
        }
        .pager-style a:hover {
            background-color: #d96f09;
            transform: translateY(-2px);
        }
        .pager-style span {
            background-color: #333;
        }

        /* CONTENEDORES */
        .section-title {
            font-size: 32px;
            font-weight: 700;
            color: #FE810B;
            margin-bottom: 25px;
            text-align: center;
        }
        .section-box {
            background: #ffffff;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 0 18px rgba(0,0,0,0.08);
            margin-bottom: 50px;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- ==========================================================
         ENCABEZADO (HERO)
    =========================================================== -->
    <div class="reportes-header text-center">
        <h1 class="display-4 text-white">
            <i class="fa fa-chart-bar mr-3"></i>
            Top de Servicios Vendidos
        </h1>
        <p class="text-white-50" style="font-size:18px">
            Consulta los 10 servicios más vendidos y los 10 menos vendidos
        </p>
    </div>

    <!-- ==========================================================
         GRID 1: 10 SERVICIOS MÁS VENDIDOS
    =========================================================== -->
    <div class="container">
        <div class="section-box">

            <asp:Label ID="lblMasVendidos" runat="server"
                Text="Top 10 Servicios Más Vendidos"
                CssClass="section-title">
            </asp:Label>

            <asp:GridView 
                ID="gvMasVendidos" 
                runat="server" 
                AutoGenerateColumns="False"
                CssClass="custom-gridview"
                AllowPaging="True"
                PageSize="10"
                PagerStyle-CssClass="pager-style text-center py-3"
                OnPageIndexChanging="gvMasVendidos_PageIndexChanging">

                <Columns>
                    <asp:BoundField DataField="ClaveServicio" HeaderText="Clave" />
                    <asp:BoundField DataField="Codigo"        HeaderText="Código" />
                    <asp:BoundField DataField="Servicio"      HeaderText="Servicio" />
                    <asp:BoundField DataField="Categoria"     HeaderText="Categoría" />
                    <asp:BoundField DataField="TotalVendido"  HeaderText="Total Vendido" />
                </Columns>

            </asp:GridView>

        </div>
    </div>

    <!-- ==========================================================
         GRID 2: 10 SERVICIOS MENOS VENDIDOS
    =========================================================== -->
    <div class="container">
        <div class="section-box">

            <asp:Label ID="lblMenosVendidos" runat="server"
                Text="Top 10 Servicios Menos Vendidos"
                CssClass="section-title">
            </asp:Label>

            <asp:GridView 
                ID="gvMenosVendidos" 
                runat="server" 
                AutoGenerateColumns="False"
                CssClass="custom-gridview"
                AllowPaging="True"
                PageSize="10"
                PagerStyle-CssClass="pager-style text-center py-3"
                OnPageIndexChanging="gvMenosVendidos_PageIndexChanging">

                <Columns>
                    <asp:BoundField DataField="ClaveServicio" HeaderText="Clave" />
                    <asp:BoundField DataField="Codigo"        HeaderText="Código" />
                    <asp:BoundField DataField="Servicio"      HeaderText="Servicio" />
                    <asp:BoundField DataField="Categoria"     HeaderText="Categoría" />
                    <asp:BoundField DataField="TotalVendido"  HeaderText="Total Vendido" />
                </Columns>

            </asp:GridView>

        </div>
    </div>

</asp:Content>
