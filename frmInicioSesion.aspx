<%@ Page Title="Iniciar Sesión - TRIP&GO" Language="C#" MasterPageFile="~/mpPrincipal.Master" AutoEventWireup="true" CodeBehind="frmInicioSesion.aspx.cs" Inherits="wssProyecto.Formulario_web11" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        .login-container {
            min-height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 0;
        }
        .login-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .login-card .card-title {
            margin-bottom: 25px;
            font-weight: 600;
            color: #333;
        }
        .form-control {
            border-radius: 8px;
            padding: 20px 15px;
        }
        .btn-login {
            border-radius: 8px;
            padding: 12px;
            font-weight: bold;
            letter-spacing: 0.5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container login-container">
        <div class="col-md-6 col-lg-5">
            <div class="card login-card">
                <div class="card-body">
                    <h3 class="card-title text-center">Iniciar Sesión en TRIP&GO</h3>
                    
                    <!-- Formulario de Inicio de Sesión -->
                    <div class="form-group">
                        <label for="txtUsuario">Usuario</label>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Usuario"></asp:TextBox>
                    </div>
                    
                    <div class="form-group">
                        <label for="txtPassword">Contraseña</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Tu contraseña"></asp:TextBox>
                    </div>
                    
                    <asp:Label ID="lblSesion" runat="server" ForeColor="Red" CssClass="text-center d-block mb-3"></asp:Label>
                    
                    <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-primary btn-block btn-login mt-4" OnClick="btnLogin_Click1" />

                    <div class="text-center mt-4">
                        <p>¿No tienes una cuenta? <a href="frmRegistro.aspx">Regístrate aquí</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

