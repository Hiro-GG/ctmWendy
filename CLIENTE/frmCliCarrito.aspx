<%@ Page Title="Mis Compras y Reservas" Language="C#" MasterPageFile="~/CLIENTE/mpCliente.Master" AutoEventWireup="true" CodeBehind="frmCliCarrito.aspx.cs" Inherits="wssProyecto.CLIENTE.Formulario_web12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <!-- Estilos personalizados para la tabla y el encabezado -->
    <style>
        .services-header {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('/PLANTILLA/img/carousel-1.jpg');
            background-position: center;
            background-size: cover;
            padding: 120px 0 80px 0; 
            margin-bottom: 50px;
            margin-top: -90px;
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
            color: #333;
        }
        
        .custom-gridview tr:hover td {
            background-color: #f8f9fa !important;
            transition: all 0.3s ease;
        }
        
        .pager-style table {
            margin: 0 auto;
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
            display: inline-block;
        }
        
        .pager-style a:hover {
            background-color: #e67209;
            transform: translateY(-1px);
        }
        
        .pager-style span {
            background-color: #333;
        }

        .btn-custom-orange {
            background-color: #FE810B;
            border-color: #FE810B;
            color: white;
            transition: background-color 0.3s;
        }

        .btn-custom-orange:hover {
            background-color: #e67209;
            border-color: #e67209;
            color: white;
        }

        /* Estilos para la sección de productos disponibles */
        .section-title {
            background: linear-gradient(135deg, #FE810B 0%, #e67209 100%);
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            margin: 40px 0 25px 0;
            box-shadow: 0 4px 15px rgba(254, 129, 11, 0.3);
            font-size: 22px;
            font-weight: 600;
            text-align: center;
        }

        /* Estilos para botones de acción */
        .btn-verde {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
        }

        .btn-verde:hover {
            background-color: #218838;
            border-color: #1e7e34;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(40, 167, 69, 0.4);
        }

        .btn-naranja {
            background-color: #FE810B;
            border-color: #FE810B;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(254, 129, 11, 0.3);
            margin-right: 10px;
        }

        .btn-naranja:hover {
            background-color: #e67209;
            border-color: #d66508;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(254, 129, 11, 0.4);
        }

        .btn-rojo {
            background-color: #dc3545;
            border-color: #dc3545;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(220, 53, 69, 0.3);
        }

        .btn-rojo:hover {
            background-color: #c82333;
            border-color: #bd2130;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(220, 53, 69, 0.4);
        }

        /* Contenedor de botones */
        .contenedor-botones {
            text-align: center;
            margin: 30px 0;
        }

        /* Sección del carrito */
        .seccion-carrito {
            margin-top: 50px;
        }

        /* Resumen de compra */
        .resumen-compra {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 10px;
            padding: 25px;
            margin: 30px 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .label-resumen {
            display: block;
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin: 10px 0;
            padding: 8px 0;
        }

        .label-resumen:last-of-type {
            color: #FE810B;
            font-size: 22px;
            border-top: 2px solid #FE810B;
            padding-top: 15px;
            margin-top: 15px;
        }

        .resumen-compra .form-control {
            font-size: 20px;
            font-weight: bold;
            color: #FE810B;
            border: 2px solid #FE810B;
            background-color: #fff;
            text-align: right;
            margin-top: 10px;
        }

        /* Botones del carrito */
        .botones-carrito {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 30px;
            margin-bottom: 50px;
        }

        /* Estilos responsivos */
        @media (max-width: 768px) {
            .section-title {
                font-size: 18px;
                padding: 12px 20px;
            }

            .custom-gridview th {
                font-size: 14px !important;
                padding: 12px !important;
            }

            .custom-gridview td {
                padding: 15px 10px !important;
                font-size: 14px;
            }

            .botones-carrito {
                flex-direction: column;
            }

            .btn-verde, .btn-naranja, .btn-rojo {
                width: 100%;
                margin-right: 0;
            }
            .search-card {
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.08);
    margin-bottom: 35px;
    border-top: 4px solid #FE810B; /* Línea naranja superior elegante */
    transition: transform 0.3s ease;
}

.search-card:hover {
    transform: translateY(-3px); 
}

/* Estilo de los inputs (cajas de texto) */
.custom-search-input {
    height: 50px !important;
    border: 2px solid #eee !important;
    border-radius: 8px !important;
    padding-left: 20px;
    font-size: 15px;
    color: #555;
    transition: all 0.3s ease;
}

.custom-search-input:focus {
    border-color: #FFC067 !important; 
    box-shadow: 0 0 0 4px rgb(242, 158, 13, 0.10) !important;
    background-color: #fffbf8;
}


.custom-dropdown {
    height: 50px !important;
    background-color: #f8f9fa;
    border: 2px solid #eee !important;
    border-radius: 8px 0 0 8px !important; 
    font-weight: 600;
    color: #444;
    cursor: pointer;
}

.custom-dropdown:focus {
    border-color: #FE810B !important;
}

/* Botón Buscar */
.btn-search-action {
    background: linear-gradient(135deg, #FE810B 0%, #e67209 100%);
    color: white;
    border: none;
    padding: 0 30px;
    font-weight: bold;
    letter-spacing: 1px;
    border-radius: 0 8px 8px 0 !important; 
}

.btn-search-action:hover {
    background: #d66508;
    box-shadow: 0 4px 10px rgba(254, 129, 11, 0.4);
}

/* Botón Limpiar */
.btn-clean-action {
    background-color: #6c757d;
    color: white;
    border-radius: 8px !important;
    margin-left: 10px;
    padding: 0 20px;
    border: none;
    font-weight: 500;
}

.btn-clean-action:hover {
    background-color: #5a6268;
    transform: translateY(-2px);
}
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="services-header">
        <div class="container text-center">
            <h1 class="display-4 text-white mb-3 animated slideInDown" style="font-weight: 700;">
                <i class="fa fa-shopping-basket mr-3"></i> Mis Compras y Reservas
            </h1>
            <p class="text-white-50 mb-0" style="font-size: 18px;">
                Revisa el historial y estado de tus transacciones
            </p>
        </div>
    </div>
    
    <div class="container pb-5">
        
        <div class="row justify-content-center mb-5">
            <div class="col-lg-12">
                <div class="wow fadeInUp card shadow border-0 p-4 p-md-5" data-wow-delay="0.1s" style="border-radius: 15px;">
                    
                    <h2 class="text-primary mb-4 border-bottom pb-2">
                        <i class="fa fa-user-circle mr-2"></i>
                        <asp:Label ID="lblSesion" runat="server" Text="Datos de la Sesión"></asp:Label>
                    </h2>

                    <asp:Label ID="lblReservas" runat="server" Text="Historial de Reservas" Font-Bold="true" CssClass="d-block mb-3 text-muted"></asp:Label>
                    
                    <div class="table-responsive mb-4">
                        <asp:GridView 
                            ID="gvReservasAnteriores" 
                            runat="server" 
                            AutoGenerateColumns="False" 
                            OnPageIndexChanging="gvReservasAnteriores_PageIndexChanging" 
                            PageSize="5"
                            AllowPaging="True"
                            CssClass="custom-gridview"
                            GridLines="None"
                            PagerStyle-CssClass="pager-style text-center py-3">
                            <Columns>
                                <asp:BoundField DataField="ClaveReserva" HeaderText="Clave Compra" />
                                <asp:BoundField DataField="FechaReserva" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField DataField="Total" HeaderText="Costo" />
                                <asp:BoundField DataField="Estatus" HeaderText="Estatus" />
                            </Columns>
                            <HeaderStyle />
                            <PagerStyle CssClass="pager-style text-center py-3" />
                        </asp:GridView>
                    </div>
                    
                    <div class="py-3">
                        <asp:Label ID="lblVenta" runat="server" CssClass="text-success font-weight-bold"></asp:Label>
                    </div>
                    
                    <div class="d-flex flex-column flex-md-row justify-content-start mt-3">
                        <asp:Button ID="btnGenerarReserva" runat="server" Text="Generar nueva reserva" OnClick="btnGenerarReserva_Click" CssClass="btn btn-custom-orange py-2 px-4 mr-md-2 mb-2 mb-md-0" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar reserva" CssClass="btn btn-outline-danger py-2 px-4" OnClick="btnCancelar_Click" />
                    </div>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlBusqueda" runat="server" Visible="False" CssClass="row justify-content-center animate__animated animate__fadeIn">
            <div class="col-lg-10">
                <div class="search-card">
                    <h5 class="mb-3 text-muted" style="font-weight: 600;"><i class="fa fa-search mr-2 text-warning"></i>Encuentra tu próximo destino</h5>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="custom-dropdown form-control" Width="140px">
                                <asp:ListItem Text="Todos" Value="Todos"></asp:ListItem>
                                <asp:ListItem Text="Vuelos" Value="Vuelos"></asp:ListItem>
                                <asp:ListItem Text="Hoteles" Value="Hoteles"></asp:ListItem>
                                <asp:ListItem Text="Tours" Value="Tours"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <asp:TextBox ID="txtBuscarDestino" runat="server" CssClass="form-control custom-search-input" placeholder="Escribe un destino (ej. Cancún, CDMX)..."></asp:TextBox>
                        
                        <div class="input-group-append">
                            <asp:Button ID="btnBuscar" runat="server" Text="BUSCAR" CssClass="btn btn-search-action" OnClick="btnBuscar_Click" />
                        </div>
                    </div>
                    <div class="mt-2 text-right">
                        <asp:Button ID="btnLimpiar" runat="server" Text="Ver Todos" CssClass="btn btn-sm btn-link text-muted" OnClick="btnLimpiar_Click" style="text-decoration:none;" />
                    </div>
                </div>
            </div>
        </asp:Panel>

        <div class="row justify-content-center">
            <div class="col-lg-12">
                
                <div class="section-title">
                    <i class="fa fa-shopping-cart mr-2"></i>
                    <asp:Label ID="lblProductos" runat="server" Text="Productos disponibles para comprar" Visible="False"></asp:Label>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvServicios" 
                        runat="server" 
                        CssClass="custom-gridview" 
                        AutoGenerateColumns="False"  
                        PageSize="7" 
                        AllowPaging="True"
                        GridLines="None"
                        PagerStyle-CssClass="pager-style text-center py-3"
                        Visible="False" OnSelectedIndexChanging="gvServicios_SelectedIndexChanging1" OnPageIndexChanging="gvServicios_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="Seleccionar"> 
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSeleccionado" runat="server" EnableViewState="true" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cantidad"> 
                                <ItemTemplate>
                                    <asp:DropDownList ID="dwlCantidad" runat="server" CssClass="form-control form-control-sm">
                                        <asp:ListItem>1</asp:ListItem>
                                        <asp:ListItem>2</asp:ListItem>
                                        <asp:ListItem>3</asp:ListItem>
                                        <asp:ListItem>4</asp:ListItem>
                                        <asp:ListItem>5</asp:ListItem>
                                        <asp:ListItem>6</asp:ListItem>
                                        <asp:ListItem>7</asp:ListItem>
                                        <asp:ListItem>8</asp:ListItem>
                                        <asp:ListItem>9</asp:ListItem>
                                        <asp:ListItem>10</asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField SelectText="Ver" ShowCancelButton="False" ShowSelectButton="True" HeaderText="Detalles" ButtonType="Button" /> 
                            <asp:BoundField DataField="Clave" HeaderText="Clave" />
                            <asp:BoundField DataField="Servicio" HeaderText="Servicio" /> 
                            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                            <asp:BoundField DataField="Cupos" HeaderText="Disponibilidad" />
                            <asp:BoundField DataField="Precio" HeaderText="Precio ($)"  /> 
                        </Columns>
                        <PagerStyle CssClass="pager-style text-center py-3" />
                    </asp:GridView>
                </div>

                <div class="contenedor-botones">
                    <asp:Button ID="btnAñadir" runat="server" Text="AÑADIR PRODUCTOS AL CARRITO" CssClass="btn-verde" Visible="False" OnClick="btnAñadir_Click" />
                </div>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="seccion-carrito">
                    <div class="section-title">
                        <i class="fa fa-shopping-bag mr-2"></i>
                        <asp:Label ID="lblCarrito" runat="server" Text="Mi carrito actual de compras" Visible="False"></asp:Label>
                    </div>
                    
                    <div class="alert alert-info shadow-sm" role="alert">
                        <asp:Label ID="lblAvisoPaquete" runat="server" Visible="false" Font-Bold="True"></asp:Label>
                    </div>

                    <div class="table-responsive">
                        <asp:GridView ID="gvServicosCarrito" 
                            runat="server" 
                            CssClass="custom-gridview" 
                            AutoGenerateColumns="False" 
                            GridLines="None"
                            Visible="False" 
                            OnSelectedIndexChanging="gvServicosCarrito_SelectedIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Seleccionar">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" EnableViewState="true" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ClaveReserva" HeaderText="Clave Compra" />
                                <asp:BoundField DataField="ClaveServicio" HeaderText="Clave Servicio" />
                                <asp:BoundField DataField="Servicio" HeaderText="Servicios" />
                                <asp:BoundField DataField="CantidadReservada" HeaderText="Cantidad" />
                                <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio $"  />
                                <asp:BoundField DataField="Total" HeaderText="Total Unidades"  />
                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="resumen-compra">
                        <asp:Label ID="lblSubtotal" runat="server" Text="Subtotal: $" CssClass="label-resumen" Visible="False"></asp:Label>
                        <asp:Label ID="lblIva" runat="server" Text="I.V.A (16%): $" CssClass="label-resumen" Visible="False"></asp:Label>
                        <asp:Label ID="lblDescuento" runat="server" Text="" ForeColor="Green" Font-Bold="True" Visible="false"></asp:Label>
                        <asp:Label ID="lblTotal" runat="server" Text="Total Venta: $" CssClass="label-resumen" Visible="False"></asp:Label>
                        <asp:TextBox ID="txtTotal" runat="server" ReadOnly="True" CssClass="form-control" Visible="False"></asp:TextBox>
                    </div>

                    <div class="botones-carrito">
                        <asp:Button ID="btnEliminarProd" runat="server" Text="Eliminar Producto" CssClass="btn-naranja" Visible="False" OnClick="btnEliminarProd_Click" />
                        <asp:Button ID="btnConfirmarCompra" runat="server" Text="Confirmar Compra" CssClass="btn-verde" Visible="False" OnClick="btnConfirmarCompra_Click" />
                        <asp:Button ID="btnCerrarCarrito" runat="server" Text="Cerrar Carrito" CssClass="btn-rojo" Visible="False" OnClick="btnCerrarCarrito_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>