<%@ Page Title="Contacto - TripGo" Language="C#" MasterPageFile="~/mpPrincipal.Master" AutoEventWireup="true" CodeBehind="frmContacto.aspx.cs" Inherits="wssProyecto.Formulario_web13" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        /* 🔹 Estilos SOLO para esta página (nada global como body, h1, etc.) */

        .contact-page-wrapper {
            padding-top: 40px;
            padding-bottom: 60px;
        }

        /* Encabezado tipo "hero" pero propio de esta página */
        .contact-hero {
            position: relative;
            padding: 60px 15px;
            border-radius: 30px;
            background: linear-gradient(135deg, rgba(46, 125, 50, 0.95), rgba(67, 160, 71, 0.9));
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.25);
            overflow: hidden;
            margin-bottom: 40px;
        }

        .contact-hero::before {
            content: "";
            position: absolute;
            top: -40%;
            right: -10%;
            width: 260px;
            height: 260px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 50%;
        }

        .contact-hero::after {
            content: "";
            position: absolute;
            bottom: -30%;
            left: -15%;
            width: 320px;
            height: 320px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
        }

        .contact-hero-content {
            position: relative;
            z-index: 2;
        }

        .contact-hero-title {
            font-size: 3rem;
            font-weight: 800;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
        }

        .contact-hero-subtitle {
            color: #e8f5e9;
            font-size: 1.1rem;
            max-width: 550px;
            margin: 0 auto;
        }

        /* Tarjeta de contacto */
        .contact-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 35px 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
            border: 1px solid #e0f2f1;
        }

        .contact-card-title {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #2e7d32;
        }

        .contact-info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 15px;
            font-size: 1rem;
        }

        .contact-info-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            background: #e8f5e9;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            flex-shrink: 0;
            color: #2e7d32;
            font-size: 1.1rem;
        }

        .contact-info-text {
            flex: 1;
        }

        .contact-info-text strong {
            display: block;
            font-weight: 600;
            color: #1b5e20;
        }

        .contact-info-text span {
            color: #555;
        }

        .contact-footer-note {
            margin-top: 20px;
            font-size: 0.95rem;
            color: #666;
        }

        .contact-created-by {
            margin-top: 10px;
            font-size: 0.9rem;
            color: #777;
        }

        .contact-created-by strong {
            color: #2e7d32;
        }

        @media (max-width: 767.98px) {
            .contact-hero-title {
                font-size: 2.1rem;
            }

            .contact-card {
                padding: 25px 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container contact-page-wrapper">
        <!-- HERO / ENCABEZADO -->
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="contact-hero text-center">
                    <div class="contact-hero-content">
                        <h1 class="contact-hero-title">
                            <i class="fa fa-headset mr-2"></i> Contáctanos
                        </h1>
                        <p class="contact-hero-subtitle">
                            ¿Tienes dudas sobre tus reservas, paquetes o destinos? 
                            El equipo de Trip&Go está listo para ayudarte a planear tu siguiente aventura.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- TARJETA DE INFORMACIÓN -->
        <div class="row justify-content-center">
            <div class="col-lg-7 col-md-9">
                <div class="contact-card">
                    <h3 class="contact-card-title">
                        <i class="fa fa-info-circle mr-2 text-success"></i> Información de contacto
                    </h3>

                    <div class="contact-info">
                        <div class="contact-info-item">
                            <div class="contact-info-icon">
                                <i class="fa fa-envelope"></i>
                            </div>
                            <div class="contact-info-text">
                                <strong>Email</strong>
                                <span>serviciocliente@tripgo.com</span>
                            </div>
                        </div>

                        <div class="contact-info-item">
                            <div class="contact-info-icon">
                                <i class="fa fa-phone-alt"></i>
                            </div>
                            <div class="contact-info-text">
                                <strong>Teléfono</strong>
                                <span>771 220 8135</span>
                            </div>
                        </div>

                        <div class="contact-info-item">
                            <div class="contact-info-icon">
                                <i class="fa fa-map-marker-alt"></i>
                            </div>
                            <div class="contact-info-text">
                                <strong>Dirección</strong>
                                <span>Ex Hacienda San Javier, Tolcayuca 1009, 43860 Tolcayuca, Hgo.</span>
                            </div>
                        </div>

                        <div class="contact-info-item">
                            <div class="contact-info-icon">
                                <i class="fa fa-clock"></i>
                            </div>
                            <div class="contact-info-text">
                                <strong>Horario de atención</strong>
                                <span>Lunes a Viernes, 9:00 AM - 6:00 PM</span>
                            </div>
                        </div>
                    </div>

                    <p class="contact-footer-note">
                        En <strong>Trip&Go</strong> nos apasiona diseñar experiencias de viaje memorables. 
                        Escríbenos o llámanos y con gusto te asesoramos para elegir el destino, 
                        hotel o paquete que mejor se adapte a ti.
                    </p>

                    <p class="contact-created-by">
                        <i class="fa fa-code mr-1"></i>
                        <strong>Creado por:</strong> Montaño Hernández Edgar y Ruiz Cortes Sebastian
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
