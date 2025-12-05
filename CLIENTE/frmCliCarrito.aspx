<%@ Page Title="Mi Carrito" Language="C#" MasterPageFile="~/CLIENTE/mpCliente.Master"
    AutoEventWireup="true" CodeBehind="frmCliCarrito.aspx.cs"
    Inherits="wssProyecto.CLIENTE.Formulario_web12" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        /* Layout general */
        .carrito-header {
            background: linear-gradient(135deg, #0d47a1, #1976d2);
            color: #fff;
            padding: 20px 0 16px 0;
            margin-bottom: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .carrito-header h1 {
            font-size: 1.9rem;
            margin-bottom: 4px;
        }

        .carrito-header p {
            margin: 0;
            font-size: 0.95rem;
            opacity: 0.9;
        }

        .btn-nueva-compra {
            border-radius: 999px;
            padding: 10px 22px;
            font-weight: 600;
            border: none;
            background: linear-gradient(135deg, #ff9800, #ff7043);
            color: #fff !important;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.25);
            transition: transform .15s ease, box-shadow .15s ease, filter .15s ease;
        }

        .btn-nueva-compra:hover {
            filter: brightness(1.05);
            transform: translateY(-1px);
            box-shadow: 0 10px 24px rgba(0, 0, 0, 0.3);
        }

        .busqueda-box {
            background: #ffffff;
            border-radius: 14px;
            padding: 10px 14px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
            margin-bottom: 14px;
        }

        .busqueda-box label {
            font-size: 0.8rem;
            font-weight: 600;
            color: #455a64;
            margin-bottom: 2px;
        }

        .busqueda-box .form-control,
        .busqueda-box .form-select {
            font-size: 0.85rem;
        }

        /* Tarjetas de servicios */

        .servicio-card {
            border-radius: 16px;
            overflow: hidden;
            background: #ffffff;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.10);
            margin-bottom: 16px;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .servicio-img-wrapper {
            height: 150px;
            overflow: hidden;
        }

        .servicio-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .servicio-body {
            padding: 10px 12px 6px 12px;
        }

        .servicio-titulo {
            font-size: 0.95rem;
            font-weight: 600;
            color: #263238;
            margin-bottom: 2px;
        }

        .servicio-destino {
            font-size: 0.78rem;
            color: #607d8b;
            margin-bottom: 4px;
        }

        .servicio-descripcion {
            font-size: 0.80rem;
            color: #546e7a;
            min-height: 34px;
            margin-bottom: 4px;
        }

        .servicio-footer {
            padding: 6px 12px 10px 12px;
            border-top: 1px dashed #eceff1;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 4px;
        }

        .servicio-precio {
            font-size: 0.95rem;
            font-weight: 700;
            color: #0d47a1;
        }

        .servicio-cupos {
            font-size: 0.76rem;
            color: #78909c;
        }

        .btn-detalle {
            border-radius: 999px;
            font-size: 0.75rem;
            padding: 4px 10px;
            border: 1px solid #ff9800;
            background-color: rgba(255, 152, 0, 0.08);
            color: #e65100 !important;
            font-weight: 600;
            white-space: nowrap;
        }

        .btn-detalle:hover {
            background-color: #ffb74d;
            color: #4e342e !important;
        }

        .btn-agregar {
            border-radius: 999px;
            font-size: 0.78rem;
            padding: 5px 12px;
            border: none;
            background: linear-gradient(135deg, #43a047, #2e7d32);
            color: #fff !important;
            font-weight: 600;
            white-space: nowrap;
            box-shadow: 0 3px 10px rgba(46, 125, 50, 0.4);
        }

        .btn-agregar:hover {
            filter: brightness(1.05);
        }

        .cantidad-select {
            width: 70px;
        }

        /* Paginación */

        .paginacion-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 6px;
        }

        .paginacion-container span {
            font-size: 0.85rem;
            color: #546e7a;
        }

        .btn-paginacion {
            font-size: 0.8rem;
            padding: 4px 10px;
            border-radius: 999px;
        }

        /* Barra de orden (resumen) */

        .order-summary-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 20px 18px 16px 18px;
            box-shadow: 0 10px 28px rgba(0, 0, 0, 0.18);
            min-height: 360px;
            font-size: 0.95rem;
        }

        .order-summary-title {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 4px;
            color: #263238;
        }

        .order-summary-subtitle {
            font-size: 0.8rem;
            color: #78909c;
            margin-bottom: 10px;
        }

        .carrito-item {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 0;
            border-bottom: 1px dashed #eceff1;
        }

        .carrito-item:last-child {
            border-bottom: none;
        }

        .carrito-img {
            width: 46px;
            height: 46px;
            border-radius: 10px;
            overflow: hidden;
            flex-shrink: 0;
        }

        .carrito-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .carrito-info {
            flex: 1;
        }

        .carrito-nombre {
            font-size: 0.8rem;
            font-weight: 600;
            color: #263238;
        }

        .carrito-detalle {
            font-size: 0.75rem;
            color: #78909c;
        }

        .carrito-precio {
            font-size: 0.85rem;
            font-weight: 700;
            color: #0d47a1;
            text-align: right;
        }

        .btn-eliminar-linea {
            font-size: 0.7rem;
            border-radius: 999px;
            padding: 3px 8px;
        }

        .order-totals {
            margin-top: 8px;
            font-size: 0.9rem;
        }

        .order-totals-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 3px;
        }

        .order-total-destacado {
            font-size: 1.05rem;
            font-weight: 700;
            color: #1b5e20;
        }

        .order-tip {
            font-size: 0.78rem;
            margin-top: 4px;
        }

        .order-dates-title {
            font-size: 0.82rem;
            font-weight: 600;
            color: #37474f;
        }

        .date-label {
            font-size: 0.75rem;
            margin-bottom: 1px;
        }

        .order-actions {
            margin-top: 10px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .order-actions .btn {
            font-size: 0.85rem;
            border-radius: 999px;
            padding: 7px 10px;
            font-weight: 600;
        }

        .mensaje-info {
            font-size: 0.85rem;
            color: #455a64;
            background: #e3f2fd;
            border-radius: 12px;
            padding: 8px 10px;
            margin-top: 6px;
        }

        .lbl-total-texto {
            font-weight: 600;
            color: #263238;
        }

        .txt-total-monto {
            border: none;
            background: transparent;
            text-align: right;
            width: 80px;
            font-weight: 700;
            color: #1b5e20;
        }

        .txt-total-monto:focus {
            outline: none;
            box-shadow: none;
        }

        .pnl-sin-compra {
            background: #fff8e1;
            border-radius: 16px;
            padding: 16px 14px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            font-size: 0.9rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="carrito-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <div>
                    <h1>Mi carrito de viaje</h1>
                    <p>
                        <asp:Label ID="lblVenta" runat="server" Text="[Pendiente de generarse una venta]"></asp:Label><br />
                        <small>
                            Sesión: <asp:Label ID="lblSesion" runat="server"></asp:Label>
                        </small>
                    </p>
                </div>

                <asp:Button ID="btnNuevaCompra" runat="server"
                    Text="Iniciar nueva compra"
                    CssClass="btn btn-nueva-compra"
                    OnClick="btnNuevaCompra_Click" />
            </div>
        </div>
    </div>

    <div class="container pb-4">

        <!-- Mensajes generales -->
        <asp:Label ID="lblMensajeGeneral" runat="server" EnableViewState="false"
            CssClass="text-danger" Visible="false"></asp:Label>

        <!-- Panel cuando NO hay venta activa -->
        <asp:Panel ID="pnlSinCompra" runat="server" CssClass="pnl-sin-compra" Visible="false">
            <b>No tienes una compra activa.</b><br />
            Para comenzar, haz clic en <b>“Iniciar nueva compra”</b> en la parte superior
            y luego selecciona los servicios que desees (vuelos, hoteles y tours).
        </asp:Panel>

        <!-- Panel cuando SÍ hay venta activa -->
        <asp:Panel ID="pnlContenidoCompra" runat="server" Visible="false">
            <div class="row">
                <!-- Columna izquierda: servicios -->
                <div class="col-lg-7 mb-3">
                    <!-- Barra de búsqueda -->
                    <asp:Panel ID="pnlBusqueda" runat="server" CssClass="busqueda-box" Visible="false">
                        <div class="row g-2 align-items-end">
                            <div class="col-md-5">
                                <label>Destino o servicio</label>
                                <asp:TextBox ID="txtBuscarDestino" runat="server"
                                    CssClass="form-control form-control-sm"
                                    placeholder="Ej. Cancún, tour, vuelo..."></asp:TextBox>
                            </div>
                            <div class="col-md-3">
                                <label>Categoría</label>
                                <asp:DropDownList ID="ddlCategoria" runat="server"
                                    CssClass="form-select form-select-sm">
                                    <asp:ListItem Text="Todos" Value="Todos" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Vuelos" Value="Vuelos"></asp:ListItem>
                                    <asp:ListItem Text="Hoteles" Value="Hoteles"></asp:ListItem>
                                    <asp:ListItem Text="Tours" Value="Tours"></asp:ListItem>
                                    <asp:ListItem Text="Actividades" Value="Actividades"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-4 d-flex justify-content-end gap-1">
                                <asp:Button ID="btnBuscar" runat="server" Text="Buscar"
                                    CssClass="btn btn-primary btn-sm me-1"
                                    OnClick="btnBuscar_Click" />
                                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar"
                                    CssClass="btn btn-outline-secondary btn-sm"
                                    OnClick="btnLimpiar_Click" />
                            </div>
                        </div>
                    </asp:Panel>

                    <!-- Lista de servicios -->
                    <asp:Label ID="lblProductos" runat="server" Text="Servicios disponibles"
                        CssClass="fw-semibold mb-1 d-block"></asp:Label>

                    <div class="row row-cols-1 row-cols-md-2 g-2">
                        <asp:Repeater ID="rptServicios" runat="server" OnItemCommand="rptServicios_ItemCommand">
                            <ItemTemplate>
                                <div class="col">
                                    <div class="servicio-card">
                                        <div class="servicio-img-wrapper">
                                            <img src="<%# Eval("Imagen") %>" alt="Servicio" />
                                        </div>
                                        <div class="servicio-body">
                                            <div class="servicio-titulo"><%# Eval("Servicio") %></div>
                                            <div class="servicio-destino">
                                                <%# Eval("Categoria") %> · <%# Eval("Destino") %>
                                            </div>
                                            <div class="servicio-descripcion">
                                                <%# Eval("Descripcion") %>
                                            </div>
                                        </div>
                                        <div class="servicio-footer">
                                            <div>
                                                <div class="servicio-precio">
                                                    $<%# String.Format("{0:N2}", Eval("Precio")) %>
                                                </div>
                                                <div class="servicio-cupos">
                                                    Cupos: <%# Eval("Cupos") %>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center gap-1">
                                                <asp:DropDownList ID="ddlCantidad" runat="server"
                                                    CssClass="form-select form-select-sm cantidad-select">
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                </asp:DropDownList>

                                                <asp:LinkButton ID="btnVerDetalle" runat="server"
                                                    CssClass="btn btn-detalle"
                                                    CommandName="VerDetalle"
                                                    CommandArgument='<%# Eval("Clave") %>'>
                                                    Ver detalle
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnAgregar" runat="server"
                                                    CssClass="btn btn-agregar"
                                                    CommandName="Agregar"
                                                    CommandArgument='<%# Eval("Clave") %>'>
                                                    +
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Paginación -->
                    <div class="paginacion-container">
                        <asp:Button ID="btnAnterior" runat="server" Text="Anterior"
                            CssClass="btn btn-outline-secondary btn-paginacion"
                            OnClick="btnAnterior_Click" />
                        <span>
                            Página
                            <asp:Label ID="lblPaginaActual" runat="server" Text="1"></asp:Label>
                            de
                            <asp:Label ID="lblTotalPaginas" runat="server" Text="1"></asp:Label>
                        </span>
                        <asp:Button ID="btnSiguiente" runat="server" Text="Siguiente"
                            CssClass="btn btn-outline-secondary btn-paginacion"
                            OnClick="btnSiguiente_Click" />
                    </div>
                </div>

                <!-- Columna derecha: resumen de compra -->
                <div class="col-lg-5">
                    <div class="order-summary-card">
                        <div class="order-summary-title">Resumen de tu orden</div>
                        <div class="order-summary-subtitle">
                            Revisa tus servicios antes de confirmar la compra.
                        </div>

                        <!-- Carrito vacío -->
                        <asp:Panel ID="pnlCarritoVacio" runat="server">
                            <div class="mensaje-info">
                                Aún no agregas servicios a tu carrito. Selecciona alguno en la lista de la izquierda.
                            </div>
                        </asp:Panel>

                        <!-- Lista de servicios en carrito -->
                        <asp:Repeater ID="rptCarrito" runat="server" OnItemCommand="rptCarrito_ItemCommand">
                            <ItemTemplate>
                                <div class="carrito-item">
                                    <div class="carrito-img">
                                        <img src="<%# Eval("Imagen") %>" alt="Servicio" />
                                    </div>
                                    <div class="carrito-info">
                                        <div class="carrito-nombre"><%# Eval("Servicio") %></div>
                                        <div class="carrito-detalle">
                                            Cantidad: <%# Eval("CantidadReservada") %> ·
                                            $<%# String.Format("{0:N2}", Eval("PrecioUnitario")) %> c/u
                                        </div>
                                    </div>
                                    <div class="carrito-precio">
                                        $<%# String.Format("{0:N2}", Eval("Total")) %><br />
                                        <asp:LinkButton ID="btnEliminarLinea" runat="server"
                                            CssClass="btn btn-outline-danger btn-eliminar-linea"
                                            CommandName="Eliminar"
                                            CommandArgument='<%# Eval("ClaveReserva") + "|" + Eval("ClaveServicio") + "|" + Eval("CantidadReservada") %>'>
                                            Quitar
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <hr />

                        <!-- Totales -->
                        <div class="order-totals">
                            <div class="order-totals-row">
                                <span>Subtotal</span>
                                <asp:Label ID="lblSubtotal" runat="server" Text="Subtotal: $0.00"></asp:Label>
                            </div>
                            <div class="order-totals-row">
                                <span>IVA</span>
                                <asp:Label ID="lblIva" runat="server" Text="I.V.A (16%) : $0.00"></asp:Label>
                            </div>

                            <asp:Label ID="lblAvisoPaquete" runat="server" CssClass="order-tip" Visible="false"></asp:Label>
                            <asp:Label ID="lblDescuento" runat="server"
                                CssClass="order-tip text-success fw-semibold" Visible="false"></asp:Label>

                            <div class="order-totals-row mt-1">
                                <span class="lbl-total-texto">
                                    <asp:Label ID="lblTotal" runat="server" Text="Total Venta: $"></asp:Label>
                                </span>
                                <asp:TextBox ID="txtTotal" runat="server" ReadOnly="true"
                                    CssClass="txt-total-monto" Text="0.00"></asp:TextBox>
                            </div>
                        </div>

                        <hr />

                        <!-- Fechas por categoría -->
                        <div class="order-dates">
                            <div class="order-dates-title mb-1">Fechas de tu viaje</div>

                            <!-- Fechas vuelo -->
                            <asp:Panel ID="pnlFechasVuelo" runat="server" Visible="false">
                                <div class="mb-1">
                                    <span class="date-label">Vuelo · Fecha de salida</span>
                                    <asp:TextBox ID="txtVueloIda" runat="server"
                                        CssClass="form-control form-control-sm"
                                        TextMode="Date"></asp:TextBox>
                                </div>
                                <div class="mb-2">
                                    <span class="date-label">Vuelo · Fecha de regreso (opcional)</span>
                                    <asp:TextBox ID="txtVueloRegreso" runat="server"
                                        CssClass="form-control form-control-sm"
                                        TextMode="Date"></asp:TextBox>
                                </div>
                            </asp:Panel>

                            <!-- Fechas hotel: aquí se recalcula total según noches -->
                            <asp:Panel ID="pnlFechasHotel" runat="server" Visible="false">
                                <div class="mb-1">
                                    <span class="date-label">Hotel · Check-in</span>
                                    <asp:TextBox ID="txtHotelCheckIn" runat="server"
                                        CssClass="form-control form-control-sm"
                                        TextMode="Date" AutoPostBack="true"
                                        OnTextChanged="FechasHotel_TextChanged"></asp:TextBox>
                                </div>
                                <div class="mb-2">
                                    <span class="date-label">Hotel · Check-out</span>
                                    <asp:TextBox ID="txtHotelCheckOut" runat="server"
                                        CssClass="form-control form-control-sm"
                                        TextMode="Date" AutoPostBack="true"
                                        OnTextChanged="FechasHotel_TextChanged"></asp:TextBox>
                                </div>
                            </asp:Panel>

                            <!-- Fecha tour -->
                            <asp:Panel ID="pnlFechasTour" runat="server" Visible="false">
                                <div class="mb-1">
                                    <span class="date-label">Tour / Actividad · Fecha</span>
                                    <asp:TextBox ID="txtFechaTour" runat="server"
                                        CssClass="form-control form-control-sm"
                                        TextMode="Date"></asp:TextBox>
                                </div>
                            </asp:Panel>
                        </div>

                        <!-- Botones de acción -->
                        <div class="order-actions">
                            <asp:Button ID="btnConfirmarCompra" runat="server"
                                Text="Confirmar compra"
                                CssClass="btn btn-success w-100"
                                OnClick="btnConfirmarCompra_Click" />

                            <asp:Button ID="btnCancelar" runat="server"
                                Text="Cancelar compra"
                                CssClass="btn btn-outline-danger w-100"
                                OnClick="btnCancelar_Click" />
                        </div>

                        <div class="mensaje-info mt-2">
                            Tip: si reservas <b>Vuelo + Hotel + Tour</b> en la misma compra, se aplica un
                            <b>20% de descuento</b> automático al total.
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
