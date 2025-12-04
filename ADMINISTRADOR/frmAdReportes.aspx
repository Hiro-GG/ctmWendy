<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAdministrador.Master" AutoEventWireup="true" CodeBehind="frmAdReportes.aspx.cs" Inherits="wssProyecto.ADMINISTRADOR.Formulario_web17" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>

/* ==========================================================
   HEADER CON IMAGEN (MISMO ESTILO QUE frmAdminProd)
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

/* Botones dentro del grid */
.btn-accion-grid {
    width: 26px;
    height: 26px;
    cursor: pointer;
    border-radius: 5px;
    transition: .2s;
}
.btn-accion-grid:hover {
    transform: scale(1.15);
}

/* Foto clientes */
.foto-usuario {
    width: 60px;
    height: 60px;
    border-radius: 10px;
    object-fit: cover;
    box-shadow: 0 2px 6px rgba(0,0,0,0.15);
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
        <i class="fa fa-chart-line mr-3"></i>
        Reportes de Ventas
    </h1>
    <p class="text-white-50" style="font-size:18px">
        Consulta las ventas por cliente y el reporte general
    </p>
</div>


<!-- ==========================================================
     REPORTE 1: VENTAS POR CLIENTE
=========================================================== -->
<div class="container">
    <div class="section-box">

        <asp:Label ID="lblUsuarios" runat="server"
            Text="Ventas por Cliente"
            CssClass="section-title">
        </asp:Label>

        <asp:GridView 
            ID="gvUsuarios" 
            runat="server" 
            AllowPaging="True"
            AutoGenerateColumns="False"
            CssClass="custom-gridview"
            PageSize="5"
            DataKeyNames="CLAVE"
            PagerStyle-CssClass="pager-style text-center py-3"
            OnSelectedIndexChanging="gvUsuarios_SelectedIndexChanging"
            OnPageIndexChanging="gvUsuarios_PageIndexChanging">

            <Columns>

                <%-- SELECCIONAR --%>
                <asp:TemplateField HeaderText="Sel">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnSeleccionar" runat="server"
                            ImageUrl="~/IMAGENES/select.jpg"
                            CssClass="btn-accion-grid"
                            CommandName="Select" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="CLAVE" HeaderText="Clave" />

                <asp:ImageField DataImageUrlField="FOTO" HeaderText="Foto">
                    <ControlStyle CssClass="foto-usuario" />
                </asp:ImageField>

                <asp:BoundField DataField="USUARIO" HeaderText="Usuario" />
                <asp:BoundField DataField="ROL" HeaderText="Rol" />
                <asp:BoundField DataField="VIGENTE" HeaderText="Estatus" />

            </Columns>

        </asp:GridView>

    </div>
</div>


<!-- ==========================================================
     REPORTE 2: VENTAS GENERALES
=========================================================== -->
<div class="container">
    <div class="section-box">

        <asp:Label ID="lblReporteGeneral" runat="server"
            Text="Reporte General de Ventas"
            CssClass="section-title">
        </asp:Label>

        <asp:GridView 
            ID="gvVentas" 
            runat="server" 
            AutoGenerateColumns="False"
            CssClass="custom-gridview"
            AllowPaging="True"
            PageSize="6"
            PagerStyle-CssClass="pager-style text-center py-3"
            OnPageIndexChanging="gvVentas_PageIndexChanging"
            OnSelectedIndexChanging="gvVentas_SelectedIndexChanging">

            <Columns>

                <%-- Clave Venta --%>
                <asp:BoundField DataField="ClaveVenta" HeaderText="Clave Venta" />

                <%-- Cliente --%>
                <asp:BoundField DataField="Cliente" HeaderText="Cliente" />

                <%-- Correo del cliente --%>
                <asp:BoundField DataField="EmailCliente" HeaderText="Correo" />

                <%-- Fecha de reserva --%>
                <asp:BoundField DataField="FechaReserva" HeaderText="Fecha" />

                <%-- Total --%>
                <asp:BoundField DataField="TotalVenta" HeaderText="Total" DataFormatString="${0:N2}" />

                <%-- Estatus --%>
                <asp:BoundField DataField="EstatusVenta" HeaderText="Estatus" />

                <%-- Servicios (lista) --%>
                <asp:BoundField DataField="Servicios" HeaderText="Servicios" />

            </Columns>

        </asp:GridView>

    </div>
</div>

</asp:Content>
