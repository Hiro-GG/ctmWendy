<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAdministrador.Master" AutoEventWireup="true" CodeBehind="frmAdministrador.aspx.cs" Inherits="wssProyecto.ADMINISTRADOR.Formulario_web1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style type="text/css">
        :root {
            --primary: #FE810B;
            --bg-page: #f5f5f7;
            --card-bg: #ffffff;
            --text-main: #1d1d1f; /* Un negro un poco más suave */
            --text-soft: #86868b;
            --border-soft: #d2d2d7;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, html {
            /* Base de fuente aumentada para mejor lectura */
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            font-size: 16px; 
        }

        /* CONTENEDOR GENERAL */
        .admin-page {
            background: var(--bg-page);
            min-height: calc(100vh - 100px);
            padding: 50px 20px 80px 20px; /* Más padding vertical */
        }

        .admin-shell {
            max-width: 1200px; /* Ancho máximo aumentado para que quepan cosas más grandes */
            margin: 0 auto;
        }

        /* HEADER MASIVO */
        .admin-header {
            margin-bottom: 40px;
        }

        .admin-kicker {
            font-size: 14px; /* Aumentado */
            letter-spacing: .15em;
            text-transform: uppercase;
            font-weight: 600;
            color: var(--text-soft);
            margin-bottom: 10px;
        }

        .admin-title-row {
            display: flex;
            flex-wrap: wrap;
            align-items: flex-end; /* Alineado abajo para que el subtitulo acompañe mejor */
            gap: 15px;
        }

        .admin-title {
            font-size: 48px; /* Mucho más grande (antes 32px) */
            font-weight: 700;
            color: var(--text-main);
            line-height: 1.1;
            letter-spacing: -0.02em;
        }

        .admin-subtitle {
            font-size: 19px; /* Aumentado */
            color: var(--text-soft);
            margin-bottom: 6px;
            font-weight: 400;
        }

        .admin-user-chip {
            margin-top: 20px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 8px 16px; /* Chip más grande */
            border-radius: 999px;
            border: 1px solid var(--border-soft);
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(10px);
            font-size: 14px;
            color: var(--text-soft);
            font-weight: 500;
        }

        .admin-user-dot {
            width: 10px; /* Punto más visible */
            height: 10px;
            border-radius: 50%;
            background: #34c759;
            box-shadow: 0 0 0 2px rgba(52, 199, 89, 0.2);
        }

        .admin-user-name {
            font-weight: 600;
            color: var(--text-main);
        }

        /* TARJETA PRINCIPAL */
        .admin-main-card {
            background: var(--card-bg);
            border-radius: 32px; /* Más redondeado */
            padding: 35px; /* Más espacio interno */
            border: 1px solid #e5e5ea;
            box-shadow: 0 10px 40px rgba(0,0,0,0.04);
            margin-bottom: 30px;
        }

        .admin-main-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 30px;
        }

        .admin-main-heading {
            font-size: 24px; /* Aumentado (antes 18px) */
            font-weight: 600;
            color: var(--text-main);
        }

        .admin-main-desc {
            font-size: 16px; /* Aumentado (antes 13px) */
            color: var(--text-soft);
            margin-top: 6px;
            max-width: 600px;
        }

        .admin-main-pill {
            align-self: flex-start;
            padding: 6px 14px;
            border-radius: 8px;
            background-color: #f2f2f7;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-soft);
        }

        /* GRID DE MÉTRICAS (BIG NUMBERS) */
        .admin-metrics {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 20px;
        }

        .metric-card {
            padding: 20px;
            border-radius: 24px;
            border: 1px solid #e5e5ea;
            background: #fbfbfd;
            transition: transform 0.2s ease;
        }
        
        .metric-card:hover {
            transform: translateY(-2px);
            background: #fff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        }

        .metric-label {
            font-size: 13px; /* Aumentado */
            text-transform: uppercase;
            letter-spacing: .05em;
            color: var(--text-soft);
            margin-bottom: 8px;
            font-weight: 600;
        }

        .metric-value {
            font-size: 36px; /* MUCHO MÁS GRANDE (antes 20px) */
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 4px;
            letter-spacing: -0.03em;
        }

        .metric-note {
            font-size: 14px;
            color: var(--text-soft);
        }

        .metric-pill {
            display: inline-block;
            margin-top: 8px;
            font-size: 12px;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 6px;
            background: rgba(254,129,11,0.1);
            color: var(--primary);
        }

        /* SEGUNDA FILA */
        .admin-secondary-grid {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 24px;
            margin-top: 24px;
        }

        .card-simple {
            background: var(--card-bg);
            border-radius: 32px;
            padding: 30px;
            border: 1px solid #e5e5ea;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }

        .card-simple-title {
            font-size: 20px; /* Aumentado */
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 8px;
        }

        .card-simple-sub {
            font-size: 15px;
            color: var(--text-soft);
            margin-bottom: 20px;
        }

        /* LISTAS */
        .list-clean {
            list-style: none;
        }

        .list-item {
            padding: 16px 0; /* Más aire entre items */
            border-bottom: 1px solid #f0f0f5;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 15px; /* Texto más grande */
            color: var(--text-main);
        }

        .list-item:last-child {
            border-bottom: none;
        }

        .list-label {
            color: var(--text-soft);
        }

        .list-strong {
            font-weight: 600;
            font-size: 16px;
        }

        /* TAGS */
        .tag-soft {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 14px;
            border-radius: 12px; /* Más cuadrado estilo iOS */
            background-color: #f2f2f7;
            font-size: 13px;
            font-weight: 500;
            color: var(--text-main);
        }

        .tag-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--primary);
        }

        /* ACCESOS RÁPIDOS */
        .admin-quick {
            margin-top: 20px;
            margin-bottom: 30px;
        }

        .admin-quick-title {
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: .1em;
            color: var(--text-soft);
            margin-bottom: 15px;
            font-weight: 600;
            margin-left: 10px;
        }

        .admin-quick-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
        }

        .quick-card {
            background: var(--card-bg);
            border-radius: 24px;
            padding: 25px;
            border: 1px solid #e5e5ea;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            text-decoration: none;
            color: inherit;
            display: block;
            position: relative;
            overflow: hidden;
        }

        .quick-card:hover {
            box-shadow: 0 15px 30px rgba(0,0,0,0.08);
            transform: translateY(-5px);
            border-color: var(--primary);
        }

        .quick-title {
            font-size: 18px; /* Aumentado */
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 6px;
        }

        .quick-sub {
            font-size: 14px;
            color: var(--text-soft);
            line-height: 1.4;
        }

        /* FOOTER */
        .admin-footer-soft {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #e5e5ea;
            font-size: 13px;
            color: var(--text-soft);
            text-align: center;
        }

        /* RESPONSIVE */
        @media (max-width: 1000px) {
            .admin-metrics {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
            .admin-secondary-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 650px) {
            .admin-page { padding: 30px 15px; }
            .admin-title { font-size: 36px; }
            .admin-metrics { grid-template-columns: 1fr; }
            .admin-quick-grid { grid-template-columns: 1fr; }
            .metric-value { font-size: 32px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-page">
        <div class="admin-shell">

            <div class="admin-header">
                <div class="admin-kicker">Panel de Control</div>

                <div class="admin-title-row">
                    <h1 class="admin-title">TRIP&GO</h1>
                    <p class="admin-subtitle">Administración General</p>
                </div>

                <div class="admin-user-chip">
                    <span class="admin-user-dot"></span>
                    <span class="admin-user-name">
                        <asp:Label ID="lblSesion" runat="server" Text="Administrador"></asp:Label>
                    </span>
                    <span style="opacity:0.6; font-weight:400;">— En línea</span>
                </div>
            </div>

            <div class="admin-main-card">
                <div class="admin-main-top">
                    <div>
                        <div class="admin-main-heading">Estado del Negocio</div>
                        <div class="admin-main-desc">
                            Visualización en tiempo real del rendimiento de <strong>TRIP&GO</strong>.
                        </div>
                    </div>
                    <div class="admin-main-pill">
                        <i class="fa fa-clock-o"></i> Hoy · <script>document.write(new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }));</script>
                    </div>
                </div>

                <div class="admin-metrics">
                    <div class="metric-card">
                        <div class="metric-label">Viajes Confirmados</div>
                        <div class="metric-value">
                            <asp:Label ID="lblTotalViajes" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="metric-note">Histórico total</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-label">Clientes Activos</div>
                        <div class="metric-value">
                            <asp:Label ID="lblTotalClientes" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="metric-note">Base de datos</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-label">Reservas Hoy</div>
                        <div class="metric-value">
                            <asp:Label ID="lblReservasHoy" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="metric-pill">+ Nuevas solicitudes</span>
                    </div>

                    <div class="metric-card">
                        <div class="metric-label">Ingresos Mes</div>
                        <div class="metric-value" style="color: #28a745;">
                            <asp:Label ID="lblIngresosMes" runat="server" Text="$0.00"></asp:Label>
                        </div>
                        <div class="metric-note">Total facturado</div>
                    </div>
                </div>

                <div class="admin-secondary-grid">
                    <div class="card-simple">
                        <div class="card-simple-title">Actividad Reciente</div>
                        <div class="card-simple-sub">Movimientos en la plataforma TRIP&GO.</div>

                        <ul class="list-clean">
                            <li class="list-item">
                                <span class="list-label">Última reserva confirmada</span>
                                <span class="list-strong">Destino: Oaxaca</span>
                            </li>
                            <li class="list-item">
                                <span class="list-label">Nuevo cliente registrado</span>
                                <span class="list-strong">Hace 15 min</span>
                            </li>
                            <li class="list-item">
                                <span class="list-label">Servicio más visto hoy</span>
                                <span class="list-strong">Tour Teotihuacán</span>
                            </li>
                            <li class="list-item">
                                <span class="list-label">Facturas pendientes</span>
                                <span class="list-strong" style="color:#FE810B;">2 por emitir</span>
                            </li>
                        </ul>
                    </div>

                    <div class="card-simple">
                        <div class="card-simple-title">Insights</div>
                        <div class="card-simple-sub">Datos clave para la toma de decisiones.</div>

                        <ul class="list-clean">
                            <li class="list-item">
                                <span class="list-label">Satisfacción</span>
                                <span class="list-strong">4.8 ★</span>
                            </li>
                            <li class="list-item">
                                <span class="list-label">Destinos Top</span>
                                <span class="list-strong">GDL, MTY</span>
                            </li>
                        </ul>

                        <div style="margin-top:25px; display:flex; gap:10px; flex-wrap:wrap;">
                            <span class="tag-soft">
                                <span class="tag-dot"></span> Usuarios
                            </span>
                            <span class="tag-soft">
                                <span class="tag-dot"></span> Servicios
                            </span>
                            <span class="tag-soft">
                                <span class="tag-dot"></span> Ventas
                            </span>
                        </div>
                    </div>
                </div>

            </div>

            <div class="admin-quick">
                <div class="admin-quick-title">Accesos Directos</div>

                <div class="admin-quick-grid">
                    <asp:HyperLink ID="lnkUsuarios" runat="server" NavigateUrl="~/ADMINISTRADOR/frmUadmin.aspx" CssClass="quick-card">
                        <div class="quick-title">Gestión de Usuarios</div>
                        <div class="quick-sub">Administra cuentas, roles y permisos de acceso.</div>
                    </asp:HyperLink>

                    <asp:HyperLink ID="lnkServicios" runat="server" NavigateUrl="~/ADMINISTRADOR/frmAdminProd.aspx" CssClass="quick-card">
                        <div class="quick-title">Catálogo de Servicios</div>
                        <div class="quick-sub">Agrega o edita vuelos, hoteles y tours.</div>
                    </asp:HyperLink>

                    <asp:HyperLink ID="lnkVentas" runat="server" NavigateUrl="~/ADMINISTRADOR/frmAdVentas.aspx" CssClass="quick-card">
                        <div class="quick-title">Reporte de Ventas</div>
                        <div class="quick-sub">Consulta el historial de transacciones.</div>
                    </asp:HyperLink>
                </div>
            </div>

            <div class="admin-footer-soft">
                &copy; 2025 <strong>TRIP&GO</strong> · Panel de Administración · v1.2
            </div>

        </div>
    </div>
</asp:Content>