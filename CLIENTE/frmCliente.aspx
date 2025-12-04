<%@ Page Title="Inicio Cliente - TripGo" Language="C#" MasterPageFile="~/CLIENTE/mpCliente.Master" AutoEventWireup="true" CodeBehind="frmCliente.aspx.cs" Inherits="wssProyecto.CLIENTE.Formulario_web1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        
        .cliente-home {
            font-family: 'Poppins', system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            padding: 40px 0 70px 0;
            
            background: radial-gradient(circle at top left, #e3f2fd 0, #ffffff 45%, #e8f5ff 100%);
        }

        .cliente-home * {
            box-sizing: border-box;
        }

        
        .cliente-hero {
            max-width: 1100px;
            margin: 0 auto 40px auto;
            border-radius: 32px;
            padding: 40px 32px;
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 40%, #e3f2fd 100%);
            box-shadow: 0 24px 60px rgba(15, 23, 42, 0.12);
            display: grid;
            grid-template-columns: minmax(0, 1.4fr) minmax(0, 1fr);
            gap: 32px;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .cliente-hero::before {
            content: "";
            position: absolute;
            width: 380px;
            height: 380px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(13,110,253,0.16) 0, transparent 55%);
            top: -80px;
            right: -80px;
            pointer-events: none;
        }

        .cliente-hero-main {
            position: relative;
            z-index: 1;
        }

        .cliente-hero-kicker {
            font-size: 0.85rem;
            letter-spacing: 0.15em;
            text-transform: uppercase;
            color: #6c757d;
            margin-bottom: 10px;
        }

        .cliente-hero-title {
            font-size: 2.4rem;
            line-height: 1.1;
            font-weight: 800;
            color: #212529;
            margin-bottom: 14px;
        }

        .cliente-hero-title span {
            background: linear-gradient(135deg, #0d6efd, #20c997);
            -webkit-background-clip: text;
            color: transparent;
        }

        .cliente-hero-subtitle {
            font-size: 0.98rem;
            color: #495057;
            max-width: 32rem;
            margin-bottom: 20px;
        }

        .cliente-hero-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            align-items: center;
        }

        .cliente-btn-primary {
            border-radius: 999px;
            padding: 11px 26px;
            border: none;
            outline: none;
            cursor: pointer;
            background: linear-gradient(135deg, #0d6efd, #20c997);
            color: #ffffff;
            font-weight: 600;
            font-size: 0.95rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 16px 40px rgba(13, 110, 253, 0.45);
            text-decoration: none;
            transition: transform 0.18s ease, box-shadow 0.18s ease, filter 0.18s ease;
        }

        .cliente-btn-primary:hover {
            transform: translateY(-1px);
            filter: brightness(1.03);
            box-shadow: 0 20px 55px rgba(13, 110, 253, 0.55);
        }

        .cliente-btn-ghost {
            border-radius: 999px;
            padding: 10px 20px;
            border: 1px solid rgba(173, 181, 189, 0.8);
            background: rgba(255, 255, 255, 0.85);
            color: #212529;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            backdrop-filter: blur(8px);
            transition: background 0.18s ease, border-color 0.18s ease, transform 0.18s ease;
        }

        .cliente-btn-ghost:hover {
            background: #e9ecef;
            border-color: #adb5bd;
            transform: translateY(-1px);
        }

        .cliente-hero-meta {
            display: flex;
            gap: 22px;
            font-size: 0.78rem;
            color: #6c757d;
            margin-top: 16px;
            flex-wrap: wrap;
        }

        .cliente-hero-meta span strong {
            color: #212529;
        }

       
        .cliente-hero-panel {
            position: relative;
            z-index: 1;
            border-radius: 26px;
            background: #212529;
            color: #e9ecef;
            padding: 20px 18px;
            box-shadow: 0 18px 40px rgba(33, 37, 41, 0.85);
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .cliente-hero-panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 4px;
        }

        .cliente-hero-panel-title {
            font-size: 0.9rem;
            font-weight: 600;
        }

        .cliente-hero-dot {
            width: 8px;
            height: 8px;
            border-radius: 999px;
            background: #28a745;
            box-shadow: 0 0 0 6px rgba(40, 167, 69, 0.3);
        }

        .cliente-hero-panel-row {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            border-radius: 16px;
            padding: 10px 12px;
            background: linear-gradient(135deg, rgba(13,110,253,0.25), rgba(33,37,41,0.6));
        }

        .cliente-hero-panel-row span {
            font-size: 0.8rem;
            color: #ced4da;
        }

        .cliente-hero-panel-row strong {
            font-size: 1.4rem;
            color: #f8f9fa;
        }

        .cliente-hero-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            font-size: 0.7rem;
        }

        .cliente-badge {
            padding: 4px 10px;
            border-radius: 999px;
            background: rgba(108, 117, 125, 0.3);
            color: #f8f9fa;
        }

        
        .cliente-section {
            max-width: 1100px;
            margin: 0 auto 40px auto;
        }

        .cliente-section-header {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            margin-bottom: 16px;
            padding: 0 4px;
        }

        .cliente-section-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #212529;
        }

        .cliente-section-subtitle {
            font-size: 0.85rem;
            color: #6c757d;
        }

        .cliente-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 18px;
        }

        @media (max-width: 900px) {
            .cliente-hero {
                grid-template-columns: minmax(0, 1fr);
            }

            .cliente-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 640px) {
            .cliente-grid {
                grid-template-columns: minmax(0, 1fr);
            }

            .cliente-home {
                padding: 24px 0 50px 0;
            }
        }

        .cliente-card {
            border-radius: 22px;
            background: #ffffff;
            box-shadow: 0 12px 32px rgba(33, 37, 41, 0.12);
            padding: 18px 18px 20px 18px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
            position: relative;
            overflow: hidden;
        }

        .cliente-card::before {
            content: "";
            position: absolute;
            width: 90px;
            height: 90px;
            border-radius: 999px;
            background: radial-gradient(circle, rgba(13,110,253,0.15), transparent 70%);
            top: -40px;
            right: -40px;
            opacity: 0;
            transition: opacity 0.25s ease;
        }

        .cliente-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 45px rgba(33, 37, 41, 0.18);
            background: #f8f9fa;
        }

        .cliente-card:hover::before {
            opacity: 1;
        }

        .cliente-card-icon {
            width: 36px;
            height: 36px;
            border-radius: 14px;
            background: #e7f1ff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #0d6efd;
            margin-bottom: 6px;
            font-size: 1.1rem;
        }

        .cliente-card-title {
            font-size: 1rem;
            font-weight: 600;
            color: #212529;
        }

        .cliente-card-text {
            font-size: 0.86rem;
            color: #6c757d;
            flex: 1;
        }

        .cliente-card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 8px;
            font-size: 0.78rem;
            color: #adb5bd;
        }

        .cliente-card-link {
            font-size: 0.8rem;
            font-weight: 600;
            color: #0d6efd;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .cliente-card-link:hover {
            text-decoration: underline;
        }

       
        .cliente-steps {
            max-width: 1100px;
            margin: 0 auto 40px auto;
            border-radius: 26px;
            background: #212529;
            padding: 24px 22px 24px 22px;
            color: #e9ecef;
            display: grid;
            grid-template-columns: minmax(0, 1.3fr) minmax(0, 1fr);
            gap: 20px;
        }

        @media (max-width: 900px) {
            .cliente-steps {
                grid-template-columns: minmax(0, 1fr);
            }
        }

        .cliente-steps-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .cliente-steps-text {
            font-size: 0.88rem;
            color: #adb5bd;
            margin-bottom: 12px;
        }

        .cliente-step-list {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .cliente-step-item {
            display: grid;
            grid-template-columns: auto minmax(0, 1fr);
            gap: 12px;
            align-items: flex-start;
            padding: 10px 0;
        }

        .cliente-step-badge {
            width: 26px;
            height: 26px;
            border-radius: 999px;
            border: 1px solid rgba(173,181,189,0.8);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            color: #f8f9fa;
        }

        .cliente-step-content-title {
            font-size: 0.9rem;
            font-weight: 600;
        }

        .cliente-step-content-text {
            font-size: 0.8rem;
            color: #ced4da;
        }

        .cliente-steps-side {
            border-radius: 20px;
            background: radial-gradient(circle at top left, rgba(13,110,253,0.35), transparent 65%);
            padding: 18px 16px;
            font-size: 0.8rem;
        }

        .cliente-steps-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 0.74rem;
            padding: 4px 10px;
            border-radius: 999px;
            background: rgba(0,0,0,0.45);
            margin-bottom: 12px;
        }

        .cliente-steps-metric {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            margin-bottom: 6px;
        }

        .cliente-steps-metric span {
            color: #dbe4ff;
            font-size: 0.8rem;
        }

        .cliente-steps-metric strong {
            font-size: 1.2rem;
            color: #f8f9fa;
        }

        
        .cliente-cta {
            max-width: 900px;
            margin: 0 auto;
            border-radius: 26px;
            padding: 22px 20px;
            background: linear-gradient(135deg, #e9f2ff, #e6fffa);
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }

        .cliente-cta-text {
            font-size: 0.9rem;
            color: #343a40;
        }

        .cliente-cta-text span {
            font-weight: 600;
            color: #212529;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="cliente-home">

       
        <section class="cliente-hero">
            <div class="cliente-hero-main">
                <div class="cliente-hero-kicker">Tu espacio TripGo</div>
                
                <h1 class="cliente-hero-title">
                    Hola, <span><asp:Label ID="lblNombreCliente" runat="server" Text="Cliente"></asp:Label></span>
                </h1>
                <p class="cliente-hero-subtitle">
                    Desde aquí puedes ver tus reservaciones, revisar detalles de tus viajes, 
                    descubrir nuevos destinos y mantener tu información siempre actualizada.
                </p>

                <div class="cliente-hero-actions">
                    <a href="frmCliMisCompras.aspx" class="cliente-btn-primary">
                        Ver mis reservaciones
                        <i class="fa fa-arrow-right"></i>
                    </a>
                    <a href="frmCliCarrito.aspx" class="cliente-btn-ghost">
                        Explorar nuestros destinos
                    </a>
                </div>

                <div class="cliente-hero-meta">
                    <span><strong>Viajes organizados,</strong> en un solo lugar.</span>
                    <span>Accede 24/7 a tus compras y comprobantes.</span>
                </div>
            </div>

           <aside class="cliente-hero-panel">
    <div class="cliente-hero-panel-header">
        <div>
            <div class="cliente-hero-panel-title">Resumen rápido</div>
            <small style="font-size:0.75rem;color:#adb5bd;">Información general de tu actividad</small>
        </div>
        <div class="cliente-hero-dot"></div>
    </div>

    <div class="cliente-hero-panel-row">
        <span>Reservas activas</span>
        <strong>
            <asp:Label ID="lblReservasActivas" runat="server" Text="0"></asp:Label>
        </strong>
    </div>
    <div class="cliente-hero-panel-row">
        <span>Último destino</span>
        <strong>
            <asp:Label ID="lblUltimoViaje" runat="server" Text="--"></asp:Label>
        </strong>
    </div>

    <div class="cliente-hero-badges">
        <span class="cliente-badge"><i class="fa fa-check-circle"></i>&nbsp;Confirmaciones</span>
        <span class="cliente-badge"><i class="fa fa-lock"></i>&nbsp;Seguridad</span>
        <span class="cliente-badge"><i class="fa fa-bell"></i>&nbsp;Alertas</span>
    </div>
</aside>
        </section>

        <!-- ACCESOS RÁPIDOS / TARJETAS -->
        <section class="cliente-section">
            <div class="cliente-section-header">
                <div class="cliente-section-title">Accesos rápidos</div>
                <div class="cliente-section-subtitle">
                    Entra directo a lo que más utilizas dentro de tu cuenta.
                </div>
            </div>

            <div class="cliente-grid">
                <article class="cliente-card">
                    <div class="cliente-card-icon">
                        <i class="fa fa-suitcase-rolling"></i>
                    </div>
                    <h3 class="cliente-card-title">Mis reservaciones</h3>
                    <p class="cliente-card-text">
                        Consulta tus viajes próximos, revisa itinerarios, descargas comprobantes
                        y administra posibles cambios o cancelaciones.
                    </p>
                    <div class="cliente-card-footer">
                        <span>Actualizado en tiempo real</span>
                        <a href="frmCliMisCompras.aspx" class="cliente-card-link">
                            Ir al historial <i class="fa fa-chevron-right" style="font-size:0.7rem;"></i>
                        </a>
                    </div>
                </article>

                <article class="cliente-card">
                    <div class="cliente-card-icon" style="background:#e0f7ff;color:#0ea5e9;">
                        <i class="fa fa-location-dot"></i>
                    </div>
                    <h3 class="cliente-card-title">Descubrir destinos</h3>
                    <p class="cliente-card-text">
                        Explora nuevas ciudades, playas y experiencias únicas con nuestros paquetes 
                        recomendados para ti.
                    </p>
                    <div class="cliente-card-footer">
                        <span>Inspiración de viaje</span>
                        <a href="frmCliCarrito.aspx" class="cliente-card-link">
                            Ver servicios <i class="fa fa-chevron-right" style="font-size:0.7rem;"></i>
                        </a>
                    </div>
                </article>

                <article class="cliente-card">
                    <div class="cliente-card-icon" style="background:#fff3cd;color:#fd7e14;">
                        <i class="fa fa-user"></i>
                    </div>
                    <h3 class="cliente-card-title">Mis datos</h3>
                    <p class="cliente-card-text">
                        Actualiza tu información personal, datos de contacto y preferencias 
                        para tener una experiencia más personalizada.
                    </p>
                    <div class="cliente-card-footer">
                        <span>Control total de tu cuenta</span>
                        <a href="frmCliMisDatos.aspx" class="cliente-card-link">
                            Editar perfil <i class="fa fa-chevron-right" style="font-size:0.7rem;"></i>
                        </a>
                    </div>
                </article>
            </div>
        </section>

        <!-- SECCIÓN DE PASOS / AYUDA RÁPIDA -->
        <section class="cliente-steps">
            <div>
                <div class="cliente-steps-title">¿Cómo aprovechar tu portal?</div>
                <p class="cliente-steps-text">
                    Sigue estos pasos sencillos para que toda tu experiencia de viaje esté organizada 
                    y tengas todo a la mano cuando lo necesites.
                </p>
                <ul class="cliente-step-list">
                    <li class="cliente-step-item">
                        <div class="cliente-step-badge">1</div>
                        <div>
                            <div class="cliente-step-content-title">Revisa tus reservaciones</div>
                            <div class="cliente-step-content-text">
                                Entra a <strong>“Mis reservaciones”</strong> para ver fechas, pasajeros y montos pagados. 
                                Desde ahí podrás descargar comprobantes o ver más detalles.
                            </div>
                        </div>
                    </li>
                    <li class="cliente-step-item">
                        <div class="cliente-step-badge">2</div>
                        <div>
                            <div class="cliente-step-content-title">Mantén tus datos al día</div>
                            <div class="cliente-step-content-text">
                                Actualiza correo y teléfono para recibir confirmaciones y avisos importantes 
                                sobre cambios de vuelo, horarios o recordatorios de viaje.
                            </div>
                        </div>
                    </li>
                    <li class="cliente-step-item">
                        <div class="cliente-step-badge">3</div>
                        <div>
                            <div class="cliente-step-content-title">Explora nuevas ofertas</div>
                            <div class="cliente-step-content-text">
                                Regresa seguido a la sección de <strong>servicios</strong> para ver nuevas promociones, 
                                destinos agregados y paquetes especiales.
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            <aside class="cliente-steps-side">
                <div class="cliente-steps-tag">
                    <i class="fa fa-circle-info"></i> Ayuda rápida
                </div>
                <p style="margin-bottom:12px;">
                    ¿Tienes alguna duda con una compra o necesitas modificar una reserva?
                    Escríbenos o llama a soporte indicando tu <strong>clave de reserva</strong>.
                </p>

                <div class="cliente-steps-metric">
                    <span>Tiempo promedio de respuesta</span>
                    <strong>≤ 24 h</strong>
                </div>
                <div class="cliente-steps-metric">
                    <span>Soporte disponible</span>
                    <strong>Lun - Vie</strong>
                </div>

                <p style="margin-top:10px;">
                    Si detectas algún cargo que no reconoces o un dato incorrecto en tu perfil, 
                    contáctanos de inmediato para ayudarte a corregirlo.
                </p>
            </aside>
        </section>

        <!-- CTA FINAL -->
        <section class="cliente-cta">
            <div class="cliente-cta-text">
                <span>Tip:</span> guarda este portal en tus favoritos para entrar
                rápidamente cuando tengas un nuevo viaje con TripGo.
            </div>
            <div>
                <a href="frmCliCarrito.aspx" class="cliente-btn-ghost">
                    Ver opciones de viaje
                </a>
            </div>
        </section>

    </div>

</asp:Content>
