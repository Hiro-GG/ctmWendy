<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAdministrador.Master" AutoEventWireup="true" CodeBehind="frmAdReportesCliente.aspx.cs" Inherits="wssProyecto.ADMINISTRADOR.Formulario_web18" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
     <!-- Fuentes modernas -->
 <link rel="preconnect" href="https://fonts.googleapis.com">
 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
 <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

 <style>

 :root {
     --primary-color: #2e7d32;
     --primary-light: #43a047;
     --primary-lighter: #66bb6a;
     --secondary-color: #1b5e20;
     --accent-color: #81c784;
     --background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 50%, #a5d6a7 100%);
     --text-primary: #1b5e20;
     --border-color: #c8e6c9;
     --shadow-lg: 0 15px 40px rgba(46, 125, 50, 0.2);
 }

 /* Animación general */
 @keyframes fadeIn {
     from { opacity: 0; transform: translateY(20px); }
     to { opacity: 1; transform: translateY(0); }
 }

 body {
     font-family: 'Poppins', sans-serif;
     background: var(--background);
 }

 .compras-container {
     padding: 2.5rem;
     animation: fadeIn 0.8s ease-out;
 }

 .page-header {
     background: linear-gradient(135deg, #2e7d32 0%, #43a047 50%);
     padding: 3rem;
     border-radius: 30px;
     box-shadow: var(--shadow-lg);
     position: relative;
     color: white;
     margin-bottom: 2rem;
 }

 /* Título grande */
 #lblConsultas {
     font-size: 5.2em;
     font-weight: 900;
     text-transform: uppercase;
     letter-spacing: 3px;
     display: block;
     text-shadow: 
         0 6px 22px rgba(0,0,0,0.35),
         0 3px 10px rgba(0,0,0,0.25);
     line-height: 1;
     margin-bottom: 10px;
 }

 /* Sesión arriba enfrente */
 #MainContent_lblSes {
     position: absolute;
     top: 20px;
     right: 40px;
     z-index: 999;
     font-size: 1.4rem;
     font-weight: 600;
     color: white;
     background: rgba(0,0,0,0.4);
     padding: 8px 15px;
     border-radius: 10px;
     backdrop-filter: blur(4px);
     animation: fadeIn 1s ease-out;
 }

 /* Cards */
 .section-card {
     background: white;
     padding: 2.2rem;
     border-radius: 20px;
     box-shadow: 0 10px 30px rgba(0,0,0,0.08);
     margin-bottom: 2rem;
     animation: fadeIn 1.2s ease-out;
 }

 .section-title {
     font-size: 1.9rem;
     font-weight: 700;
     margin-bottom: 1.4rem;
     color: var(--text-primary);
 }

 /* GridView */
 .GridView {
     width: 100%;
     border-collapse: collapse;
     border-radius: 15px;
     overflow: hidden;
     animation: fadeIn 1s ease;
     font-size: 1.1rem;
 }

 .GridView th {
     background: linear-gradient(135deg, #2e7d32, #43a047);
     padding: 1.2rem;
     color: white;
     text-transform: uppercase;
     font-weight: 700;
     font-size: 1rem;
 }

 .GridView td {
     padding: 1.3rem;
     border-bottom: 2px solid #f1f8e9;
     font-size: 1.1rem;
     font-weight: 500;
 }

 .GridView tr:hover td {
     background: #e8f5e9;
     transition: 0.3s;
 }

 /* Imagen del detalle */
 .GridView img {
     width: 100px;
     height: 100px;
     object-fit: cover;
     border-radius: 12px;
     transition: 0.3s;
 }

 .GridView img:hover {
     transform: scale(1.15);
 }

 /* Mensaje */
 #lblR {
     display: block;
     margin-top: 1rem;
     padding: 1rem;
     background: #fff8c5;
     border-left: 5px solid #fbc02d;
     border-radius: 10px;
     font-weight: 600;
     color: #8a6d00;
 }

 /* 🌟 BOTÓN "Ver detalle" BONITO 🌟 */
 .btn-detalle {
     display: inline-block;
     padding: 0.55rem 1.4rem;
     border-radius: 999px;
     border: none;
     background: linear-gradient(135deg, #43a047, #66bb6a);
     color: #ffffff;
     font-size: 0.95rem;
     font-weight: 600;
     text-transform: uppercase;
     letter-spacing: 0.5px;
     cursor: pointer;
     box-shadow: 0 4px 12px rgba(67, 160, 71, 0.4);
     transition: all 0.25s ease;
 }

 .btn-detalle:hover {
     transform: translateY(-2px) scale(1.03);
     box-shadow: 0 7px 18px rgba(46, 125, 50, 0.5);
     background: linear-gradient(135deg, #2e7d32, #43a047);
 }

 .btn-detalle:active {
     transform: translateY(0);
     box-shadow: 0 3px 8px rgba(46, 125, 50, 0.4);
 }

 .GridView .btn-detalle {
     margin: 0.1rem 0;
 }

 </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="compras-container">

    <div class="page-header">
        <asp:Label ID="lblConsultas" runat="server" Text="Ventas del Cliente"></asp:Label>
        <asp:Label ID="MainContent_lblSes" runat="server" ClientIDMode="Static"></asp:Label>
    </div>

    <!-- HISTORIAL -->
    <div class="section-card">
        <div class="section-title">Reporte de Ventas </div>

        <asp:GridView ID="gvComprasAnteriores" runat="server"
            AutoGenerateColumns="False"
            OnPageIndexChanging="gvComprasAnteriores_PageIndexChanging"
            OnSelectedIndexChanging="gvComprasAnteriores_SelectedIndexChanging"
            PageSize="6"
            CssClass="GridView"
            AllowPaging="True">

            <Columns>
                <asp:BoundField DataField="ClaveReserva" HeaderText="Clave Reserva" />
                <asp:BoundField DataField="FechaReserva" HeaderText="Fecha" />
                <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="${0:N2}" />
                <asp:BoundField DataField="Estatus" HeaderText="Estatus" />

                <%-- Botón "Ver detalle" personalizado --%>
                <asp:TemplateField HeaderText="Acción">
                    <ItemTemplate>
                        <asp:Button ID="btnVerDetalle" runat="server"
                            Text="Ver detalle"
                            CommandName="Select"
                            CssClass="btn-detalle" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>

        <asp:Label ID="lblR" runat="server" Text=""></asp:Label>
    </div>

    <!-- DETALLE -->
    <div class="section-card">
        <asp:Label ID="lblDet" runat="server" Text="Detalle de la Compra" CssClass="section-title"></asp:Label>

        <asp:GridView ID="gvDetalleVentas" runat="server"
            AutoGenerateColumns="False"
            OnPageIndexChanging="gvDetalleVentas_PageIndexChanging"
            CssClass="GridView">

            <Columns>
                <asp:BoundField DataField="ClaveReserva" HeaderText="Clave" />

                <asp:ImageField DataImageUrlField="Imagen" HeaderText="Producto"></asp:ImageField>

                <asp:BoundField DataField="Servicio" HeaderText="Servicio" />
                <asp:BoundField DataField="CantidadReservada" HeaderText="Cantidad" />
                <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unit." DataFormatString="${0:N2}" />
                <asp:BoundField DataField="Total" HeaderText="Subtotal" DataFormatString="${0:N2}" />
            </Columns>

        </asp:GridView>
    </div>

</div>
</asp:Content>
