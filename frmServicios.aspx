<%@ Page Title="" Language="C#" MasterPageFile="~/mpPrincipal.Master" AutoEventWireup="true" CodeBehind="frmServicios.aspx.cs" Inherits="wssProyecto.Formulario_web12" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        /* ==================== HERO / HEADER ==================== */
        .services-header {
            position: relative;
            background:
                linear-gradient(120deg,
                    rgba(254, 129, 11, 0.95) 0%,
                    rgba(230, 110, 5, 0.90) 38%,
                    rgba(90, 45, 10, 0.75) 100%),
                url('img/carousel-1.jpg');
            background-position: center;
            background-size: cover;
            padding: 90px 0 110px;
            margin-bottom: 0;
            border-radius: 0 0 32px 32px;
            box-shadow: 0 18px 45px rgba(0, 0, 0, 0.25);
            color: #fff;
        }

        .services-header-inner {
            text-align: center;
        }

        .services-header-pill {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.16);
            border: 1px solid rgba(255, 255, 255, 0.35);
            font-size: 0.8rem;
            letter-spacing: 0.18em;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .services-header-title {
            font-weight: 800;
            font-size: 2.6rem;
            letter-spacing: 0.03em;
            text-shadow: 0 4px 16px rgba(0, 0, 0, 0.45);
            margin-bottom: 8px;
            color: #ffffff; /* blanco fijo */
        }

        .services-header-title i {
            margin-right: 0.5rem;
            color: #ffffff; /* icono blanco */
        }

        .services-header-subtitle {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.9);
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.4);
        }

        .services-header::after {
            content: "";
            position: absolute;
            left: 10%;
            right: 10%;
            bottom: -12px;
            height: 24px;
            background: radial-gradient(circle at 50% 0,
                        rgba(255, 255, 255, 0.65) 0,
                        rgba(255, 255, 255, 0) 70%);
            opacity: 0.8;
            pointer-events: none;
        }

        /* ==================== BARRA DE BÚSQUEDA ==================== */

        .search-wrapper {
            margin-top: -70px; /* hace que “flote” sobre el header */
            margin-bottom: 30px;
            position: relative;
            z-index: 5;
        }

        .search-card {
            border-radius: 18px;
            border: none;
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.18);
        }

        .search-title {
            font-weight: 600;
            font-size: 1rem;
            color: #333;
            margin-bottom: 0.25rem;
        }

        .search-subtitle {
            font-size: 0.85rem;
            color: #888;
        }

        .search-label {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: .06em;
            font-weight: 600;
            color: #888;
            margin-bottom: 0.25rem;
        }

        .search-input,
        .search-select {
            border-radius: 999px;
            padding-left: 40px;
            border: 1px solid #e0e0e0;
            height: 42px;
            font-size: 0.9rem;
        }

        .search-input:focus,
        .search-select:focus {
            box-shadow: 0 0 0 0.1rem rgba(254, 129, 11, 0.3);
            border-color: #FE810B;
            outline: none;
        }

        .search-icon-wrapper,
        .search-select-wrapper {
            position: relative;
        }

        .search-icon-wrapper i,
        .search-select-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #bbb;
            font-size: 0.9rem;
        }

        .search-select {
            padding-left: 40px;
        }

        .btn-service {
            background-color: #FE810B;
            border-color: #FE810B;
            font-weight: 500;
            color: #fff;
        }

        .btn-service:hover {
            background-color: #e67209;
            border-color: #e67209;
            color: #fff;
        }

        .btn-search-main {
            border-radius: 999px;
            padding: 0.55rem 1.6rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: .4rem;
        }

        .btn-search-main i {
            font-size: 0.9rem;
        }

        .btn-search-clear {
            border-radius: 999px;
            padding: 0.55rem 1.4rem;
            font-size: 0.85rem;
        }

        @media (max-width: 767.98px) {
            .services-header {
                padding: 70px 0 100px;
            }

            .services-header-title {
                font-size: 2rem;
            }

            .search-wrapper {
                margin-top: -60px;
            }

            .btn-search-main,
            .btn-search-clear {
                width: 100%;
                justify-content: center;
                margin-bottom: .4rem;
            }
        }

        /* ==================== CARDS DE SERVICIOS ==================== */

        .service-card {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0,0,0,0.08);
            border: none;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            background-color: #ffffff;
        }

        .service-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }

        .service-card img {
            height: 180px;
            width: 100%;
            object-fit: cover;
        }

        .service-category-badge {
            background-color: #FE810B;
            color: #fff;
            font-size: 0.75rem;
            padding: 5px 10px;
            border-radius: 999px;
        }

        .service-destination-badge {
            background-color: #343a40;
            color: #fff;
            font-size: 0.75rem;
            padding: 5px 10px;
            border-radius: 999px;
        }

        .service-price {
            color: #FE810B;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .service-cupos {
            font-size: 0.85rem;
            color: #6c757d;
        }

        .service-description {
            font-size: 0.9rem;
            color: #555;
        }

        .service-title {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header Section -->
    <div class="services-header">
        <div class="container">
            <div class="services-header-inner">
                <div class="services-header-pill">
                    <i class="fa fa-globe-americas me-1"></i> EXPLORA SERVICIOS
                </div>
                <h1 class="services-header-title">
                    <i class="fa fa-suitcase"></i> Servicios Disponibles
                </h1>
                <p class="services-header-subtitle">
                    Descubre nuestros mejores paquetes turísticos y arma tu próximo viaje a tu medida.
                </p>
            </div>
        </div>
    </div>

    <div class="container pb-5">
        <!-- Barra de búsqueda / filtros (flotando bajo el header) -->
        <div class="search-wrapper">
            <asp:Panel ID="pnlBusqueda" runat="server">
                <div class="card search-card">
                    <div class="card-body">
                        <div class="row g-3 align-items-center">
                            <!-- Título / subtítulo -->
                            <div class="col-12 mb-2">
                                <span class="search-title">
                                    Encuentra tu próximo viaje
                                </span><br />
                                <span class="search-subtitle">
                                    Filtra por destino, servicio o categoría para ver las mejores opciones.
                                </span>
                            </div>

                            <!-- Campo de texto -->
                            <div class="col-12 col-md-5">
                                <div class="search-label">Destino o servicio</div>
                                <div class="search-icon-wrapper">
                                    <i class="fa fa-search"></i>
                                    <asp:TextBox ID="txtBuscar" runat="server"
                                        CssClass="form-control search-input"
                                        placeholder="Ej. Cancún, Tour Teotihuacán, Vuelo CDMX..."></asp:TextBox>
                                </div>
                            </div>

                            <!-- Categoría -->
                            <div class="col-12 col-md-3">
                                <div class="search-label">Categoría</div>
                                <div class="search-select-wrapper">
                                    <i class="fa fa-tags"></i>
                                    <asp:DropDownList ID="ddlCategoria" runat="server"
                                        CssClass="form-select search-select">
                                        <asp:ListItem Text="Todos" Value="Todos" />
                                        <asp:ListItem Text="Vuelos" Value="Vuelos" />
                                        <asp:ListItem Text="Hoteles" Value="Hoteles" />
                                        <asp:ListItem Text="Tours" Value="Tours" />
                                        <asp:ListItem Text="Actividades" Value="Actividades" />
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- Botones -->
                            <div class="col-12 col-md-4 d-flex flex-column flex-md-row align-items-md-end justify-content-md-end">
                                <asp:Button ID="btnBuscar" runat="server"
                                    Text="Buscar"
                                    CssClass="btn btn-service btn-search-main me-md-2 mb-2 mb-md-0"
                                    OnClick="btnBuscar_Click" />
                                <asp:Button ID="btnLimpiar" runat="server"
                                    Text="Limpiar filtros"
                                    CssClass="btn btn-outline-secondary btn-search-clear"
                                    OnClick="btnLimpiar_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>

        <!-- Mensaje cuando no hay servicios -->
        <asp:Panel ID="pnlSinServicios" runat="server" Visible="false">
            <div class="text-center py-5">
                <i class="fa fa-exclamation-circle fa-3x text-warning mb-3"></i>
                <h4>No hay servicios disponibles</h4>
                <p class="text-muted">Intenta cambiar los filtros o vuelve pronto para ver nuestras ofertas.</p>
            </div>
        </asp:Panel>

        <!-- Repeater de servicios -->
        <asp:Repeater ID="rptServicios" runat="server">
            <HeaderTemplate>
                <div class="row mt-3">
            </HeaderTemplate>

            <ItemTemplate>
                <div class="col-12 col-md-6 col-lg-4 mb-4 d-flex">
                    <div class="card service-card w-100">
                        <!-- Imagen -->
                        <img src='<%# Eval("Imagen") %>' alt='<%# Eval("Servicio") %>' />

                        <div class="card-body d-flex flex-column">
                            <!-- Categoría y destino -->
                            <div class="mb-2">
                                <span class="service-category-badge me-2">
                                    <%# Eval("Categoria") %>
                                </span>
                                <span class="service-destination-badge">
                                    <%# Eval("Destino") %>
                                </span>
                            </div>

                            <!-- Título -->
                            <h5 class="service-title mb-2">
                                <%# Eval("Servicio") %>
                            </h5>

                            <!-- Descripción -->
                            <p class="service-description mb-3">
                                <%# Eval("Descripcion") %>
                            </p>

                            <!-- Precio y cupos -->
                            <div class="mt-auto">
                                <div class="service-price mb-1">
                                    $ <%# String.Format("{0:N2}", Eval("Precio")) %> MXN
                                </div>
                                <div class="service-cupos">
                                    Cupos disponibles: <%# Eval("Cupos") %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>

            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <!-- Paginador -->
        <asp:Panel ID="pnlPager" runat="server" CssClass="text-center mt-4" Visible="false">
            <asp:LinkButton ID="lnkAnterior" runat="server"
                CssClass="btn btn-service btn-sm me-2"
                OnClick="lnkAnterior_Click">
                &laquo; Anterior
            </asp:LinkButton>

            <asp:Label ID="lblPagina" runat="server" CssClass="mx-2"></asp:Label>

            <asp:LinkButton ID="lnkSiguiente" runat="server"
                CssClass="btn btn-service btn-sm ms-2"
                OnClick="lnkSiguiente_Click">
                Siguiente &raquo;
            </asp:LinkButton>
        </asp:Panel>
    </div>
</asp:Content>
