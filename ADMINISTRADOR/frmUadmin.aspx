<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAdministrador.Master" AutoEventWireup="true" CodeBehind="frmUadmin.aspx.cs" Inherits="wssProyecto.ADMINISTRADOR.Formulario_web12" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        /* ============================================
           HEADER TIPO HERO (similar a frmAdminProd)
        ============================================ */
        .users-header {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                        url('img/carousel-2.jpg');
            background-position: center;
            background-size: cover;
            padding: 80px 0;
            margin-bottom: 50px;
        }

        /* ============================================
           GRIDVIEW ESTILO PREMIUM (reutilizado)
        ============================================ */
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
            padding: 15px 12px !important;
            text-align: center !important;
            border-bottom: 1px solid #f0f0f0 !important;
            vertical-align: middle !important;
            background-color: white;
            font-size: 14px;
        }

        .custom-gridview tr:hover td {
            background-color: #f8f9fa !important;
            transition: all 0.3s ease;
        }

        /* Botones de acción (select / edit / delete) */
        .btn-accion-grid {
            border-radius: 5px;
            transition: transform 0.2s;
            cursor: pointer;
        }
        .btn-accion-grid:hover {
            transform: scale(1.1);
        }

        /* Foto de usuario */
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

    <!-- ENCABEZADO -->
    <div class="users-header">
        <div class="container text-center">
            <h1 class="display-4 text-white mb-3" style="font-weight:700;">
                <i class="fa fa-users mr-3"></i>Administración de Usuarios
            </h1>
            <p class="text-white-50 mb-0" style="font-size:18px;">
                Consulta, edita o elimina los usuarios registrados en el sistema
            </p>
        </div>
    </div>

    <!-- LISTA DE USUARIOS -->
    <div class="container pb-5">
        <div class="row">
            <div class="col-12">

                <asp:GridView 
                    ID="gvUsuarios" 
                    runat="server" 
                    AllowPaging="True"
                    AutoGenerateColumns="False"
                    CssClass="custom-gridview"
                    GridLines="None"
                    PageSize="5"
                    DataKeyNames="CLAVE"
                    PagerStyle-CssClass="pager-style text-center py-3"
                    OnSelectedIndexChanging="gvUsuarios_SelectedIndexChanging"
                    OnRowEditing="gvUsuarios_RowEditing"
                    OnRowDeleting="gvUsuarios_RowDeleting"
                    OnPageIndexChanging="gvUsuarios_PageIndexChanging">

                    <Columns>

                        <%-- Seleccionar --%>
                        <asp:TemplateField HeaderText="Sel">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnSeleccionar" runat="server"
                                    ImageUrl="~/IMAGENES/select.jpg" Width="25" Height="25"
                                    CommandName="Select"
                                    CssClass="btn-accion-grid" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Eliminar --%>
                        <asp:TemplateField HeaderText="Eliminar">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEliminar" runat="server"
                                    ImageUrl="~/IMAGENES/logobasura.png" Width="25" Height="25"
                                    CommandName="Delete"
                                    OnClientClick="return confirm('¿Estás seguro de eliminar este usuario?');"
                                    CssClass="btn-accion-grid" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Editar --%>
                        <asp:TemplateField HeaderText="Editar">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEditar" runat="server"
                                    ImageUrl="~/IMAGENES/logowp.png" Width="25" Height="25"
                                    CommandName="Edit"
                                    CssClass="btn-accion-grid" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Datos --%>
                        <asp:BoundField DataField="CLAVE" HeaderText="Clave" />

                        <asp:ImageField DataImageUrlField="FOTO" HeaderText="Foto">
                            <ControlStyle CssClass="foto-usuario" />
                        </asp:ImageField>

                        <asp:BoundField DataField="USUARIO" HeaderText="Usuario" />
                        <asp:BoundField DataField="ROL" HeaderText="Rol" />
                        <asp:BoundField DataField="VIGENTE" HeaderText="Estatus" />

                    </Columns>

                    <EmptyDataTemplate>
                        <div class="text-center py-5">
                            <i class="fa fa-exclamation-circle fa-3x text-warning mb-3"></i>
                            <h4>No hay usuarios registrados</h4>
                            <p class="text-muted">Agrega nuevos usuarios desde el módulo correspondiente.</p>
                        </div>
                    </EmptyDataTemplate>

                </asp:GridView>

            </div>
        </div>
    </div>

</asp:Content>
