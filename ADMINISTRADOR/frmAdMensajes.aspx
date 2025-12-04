<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAdministrador.Master" AutoEventWireup="true" CodeBehind="frmAdMensajes.aspx.cs" Inherits="wssProyecto.ADMINISTRADOR.Formulario_web15" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
    .msg-container {
        width: 80%;
        max-width: 700px;
        margin: 30px auto;
        padding: 20px;
        background: #ffffff;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        font-family: 'Segoe UI', sans-serif;
    }

    .title {
        font-size: 22px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 25px;
        color: #2c3e50;
    }

    .form-group {
        margin-bottom: 18px;
    }

    .form-group label {
        display: block;
        font-size: 15px;
        font-weight: 600;
        color: #34495e;
        margin-bottom: 5px;
    }

    .form-group input[type=text],
    .form-group textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #dcdcdc;
        border-radius: 8px;
        font-size: 14px;
    }

    .photo-box {
        text-align: center;
        margin-bottom: 20px;
    }

    .photo-box img {
        width: 120px;
        height: 120px;
        object-fit: cover;
        border-radius: 50%;
        border: 3px solid #3498db;
    }

    .btn {
        background-color: #3498db;
        color: white;
        padding: 12px 22px;
        border: none;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        margin: 10px;
        width: 220px;
    }

    .btn-secondary {
        background-color: #7f8c8d;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="msg-container">

    <div class="title">ENVÍO DE MENSAJES ADMINISTRADOS</div>

    <div class="photo-box">
        <asp:Image ID="imgFoto" runat="server" />
    </div>

    <div class="form-group">
        <label>Usuario</label>
        <asp:TextBox ID="txtUsuario" runat="server" ReadOnly="True"></asp:TextBox>
    </div>

    <div class="form-group">
        <label>Rol</label>
        <asp:TextBox ID="txtRol" runat="server" ReadOnly="True"></asp:TextBox>
    </div>

    <div class="form-group">
        <label>Mensaje (máx. 250 caracteres)</label>
        <asp:TextBox ID="txtMensaje" runat="server" TextMode="MultiLine" MaxLength="250" Rows="5"></asp:TextBox>
    </div>

</div>

<div class="buttons-box" style="text-align:center;">
    <asp:Button ID="btnEnviarMensaje" runat="server" Text="Enviar Mensaje" CssClass="btn" OnClick="btnEnviarMensaje_Click" />
    <asp:Button ID="btnSeleccionarU" runat="server" Text="Seleccionar otro usuario" CssClass="btn btn-secondary" OnClick="btnSeleccionarU_Click" />
</div>
</asp:Content>
