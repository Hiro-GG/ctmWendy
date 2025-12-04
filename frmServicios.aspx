<%@ Page Title="" Language="C#" MasterPageFile="~/mpPrincipal.Master" AutoEventWireup="true" CodeBehind="frmServicios.aspx.cs" Inherits="wssProyecto.Formulario_web12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        .services-header {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('img/carousel-1.jpg');
            background-position: center;
            background-size: cover;
            padding: 80px 0;
            margin-bottom: 50px;
        }
        
        .custom-gridview {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        
        .custom-gridview th {
            background-color: #FE810B !important;
            color: white !important;
            padding: 15px !important;
            text-align: center !important;
            font-weight: 600 !important;
            font-size: 16px !important;
            letter-spacing: 1px;
            border: none !important;
        }
        
        .custom-gridview td {
            padding: 20px 15px !important;
            text-align: center !important;
            border-bottom: 1px solid #f0f0f0 !important;
            vertical-align: middle !important;
            background-color: white;
        }
        
        .custom-gridview tr:hover td {
            background-color: #f8f9fa !important;
            transition: all 0.3s ease;
        }
        
        .custom-gridview img {
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            transition: transform 0.3s ease;
        }
        
        .custom-gridview img:hover {
            transform: scale(1.05);
        }
        
        .pager-style a, .pager-style span {
            padding: 8px 16px;
            margin: 0 4px;
            background-color: #FE810B;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .pager-style a:hover {
            background-color: #e67209;
            transform: translateY(-2px);
        }
        
        .pager-style span {
            background-color: #333;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header Section -->
    <div class="services-header">
        <div class="container text-center">
            <h1 class="display-4 text-white mb-3" style="font-weight: 700;">
                <i class="fa fa-suitcase mr-3"></i>Servicios Disponibles
            </h1>
            <p class="text-white-50 mb-0" style="font-size: 18px;">
                Descubre nuestros mejores paquetes turísticos
            </p>
        </div>
    </div>

    <!-- GridView Section -->
    <div class="container pb-5">
        <div class="row">
            <div class="col-12">
                <asp:GridView 
                    ID="gvServicios" 
                    runat="server" 
                    AutoGenerateColumns="False" 
                    OnPageIndexChanging="gvServicios_PageIndexChanging" 
                    PageSize="5"
                    AllowPaging="True"
                    CssClass="custom-gridview"
                    PagerStyle-CssClass="pager-style text-center py-3"
                    GridLines="None">
                    
                    <Columns>
                        <asp:ImageField 
                            DataAlternateTextField="Imagen" 
                            DataAlternateTextFormatString="Imagen del servicio" 
                            DataImageUrlField="Imagen"
                            HeaderText="Imagen">
                            <ControlStyle Height="120px" Width="180px" />
                        </asp:ImageField>
                        
                        <asp:BoundField 
                            DataField="Servicio" 
                            HeaderText="Servicio"
                            ItemStyle-Font-Bold="true"
                            ItemStyle-ForeColor="#333" />
                        
                        
                        <asp:BoundField 
                            DataField="Descripcion" 
                            HeaderText="Descripción"
                            ItemStyle-Font-Size="14px"
                            ItemStyle-ForeColor="#555" />
                        
                        <asp:BoundField 
                            DataField="Precio" 
                            HeaderText="Precio" 
                            DataFormatString="${0:N2}"
                            ItemStyle-Font-Bold="true"
                            ItemStyle-ForeColor="#FE810B"
                            ItemStyle-Font-Size="18px" />
                        
                        
                    </Columns>
                    
                    <PagerStyle CssClass="pager-style text-center py-3" />
                    <EmptyDataTemplate>
                        <div class="text-center py-5">
                            <i class="fa fa-exclamation-circle fa-3x text-warning mb-3"></i>
                            <h4>No hay servicios disponibles</h4>
                            <p class="text-muted">Vuelve pronto para ver nuestras ofertas</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>