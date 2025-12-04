<%@ Page Title="" Language="C#" MasterPageFile="~/mpPrincipal.Master" AutoEventWireup="true" CodeBehind="frmPrincipal.aspx.cs" Inherits="wssProyecto.Formulario_web1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        /* Ajustes de imágenes para consistencia */
        /* Carrusel (ancho completo, alto fijo, recorte inteligente) */
        .carousel-inner img {
            width: 100%;
            height: 600px;
            object-fit: cover;
        }

        /* Captions del carrusel: fondo semitransparente para legibilidad */
        .carousel-caption {
            background: rgba(0,0,0,0.45);
            border-radius: 8px;
            padding: 20px;
        }

        /* Destinos destacados: tarjetas con imágenes uniformes */
        .destination-card img {
            width: 100%;
            height: 260px;
            object-fit: cover;
            border-radius: 10px 10px 0 0;
        }

        .destination-card .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }

        .destination-card .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.12);
        }

        /* Servicios: iconos y texto centrado */
        .service-icon {
            font-size: 42px;
            line-height: 1;
            display: inline-block;
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: rgba(13,110,253,0.08);
            color: #0d6efd;
            text-align: center;
            padding-top: 14px;
            margin-bottom: 18px;
        }

        /* Testimonios */
        .testimonial {
            background: #fff;
            padding: 28px;
            border-radius: 10px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.06);
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .carousel-inner img {
                height: 420px;
            }
            .destination-card img {
                height: 200px;
            }
        }

        @media (max-width: 576px) {
            .carousel-inner img {
                height: 260px;
            }
            .destination-card img {
                height: 160px;
            }
            .carousel-caption {
                font-size: 14px;
                padding: 12px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- About Start (tu contenido original) -->
    <div class="container-fluid py-5">
        <div class="container pt-5">
            <div class="row">
                <div class="col-lg-6" style="min-height: 500px;">
                    <div class="position-relative h-100">
                        <img class="position-absolute w-100 h-100" src="PLANTILLA/img/about.jpg" style="object-fit: cover;" alt="Sobre Trip & Go">
                    </div>
                </div>
                <div class="col-lg-6 pt-5 pb-lg-5">
                    <div class="about-text bg-white p-4 p-lg-5 my-lg-5">
                        <h6 class="text-primary text-uppercase" style="letter-spacing: 5px;"></h6>
                        <h1 class="mb-3">Ofrecemos los mejores servicios para viajes</h1>
                        <p>Trip&Go se proyecta como una organización dedicada a la comercialización de servicios turísticos en un modelo de comercio electrónico (e-commerce). Su misión consiste en ofrecer a los clientes una manera moderna, confiable y práctica de planificar y adquirir experiencias de viaje desde la comodidad de sus dispositivos, sin la necesidad de acudir físicamente a una agencia tradicional.</p>
                        <div class="row mb-4">
                            <div class="col-6">
                                <img class="img-fluid" src="PLANTILLA/img/about-1.jpg" alt="Imagen sobre nosotros 1">
                            </div>
                            <div class="col-6">
                                <img class="img-fluid" src="PLANTILLA/img/about-2.jpg" alt="Imagen sobre nosotros 2">
                            </div>
                        </div>
                        <a href="frmServicios.aspx" class="btn btn-primary mt-1">Explora ahora</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- About End -->
    <!-- Carrusel de Paquetes de Viaje -->
    <div class="container-fluid py-4 bg-light">
        <div class="container">
            <div id="paquetesCarousel" class="carousel slide carousel-fade" data-ride="carousel" data-interval="6000">
                <ol class="carousel-indicators">
                    <li data-target="#paquetesCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#paquetesCarousel" data-slide-to="1"></li>
                    <li data-target="#paquetesCarousel" data-slide-to="2"></li>
                </ol>

                <div class="carousel-inner">

                    <!-- Slide 1 -->
                    <div class="carousel-item active">
                        <img src="IMAGENES/paquete-cancun.jpg" class="d-block w-100" alt="Paquete Cancún">
                        <div class="carousel-caption d-none d-md-block text-left">
                            <h3 class="text-white">Conoce nuestros paquetes de viaje</h3>
                            <p>Paquetes seleccionados: vuelos + hotel + actividades. Promociones especiales para familias y parejas.</p>
                            <a href="frmServicios.aspx" class="btn btn-primary">Explora Paquetes</a>
                        </div>
                    </div>

                    <!-- Slide 2 -->
                    <div class="carousel-item">
                        <img src="IMAGENES/paquete-loscabos.jpg" class="d-block w-100" alt="Paquete Los Cabos">
                        <div class="carousel-caption d-none d-md-block text-left">
                            <h3 class="text-white">Escapadas a Los Cabos</h3>
                            <p>Vuela con aerolíneas nacionales y disfruta resorts con todo incluido.</p>
                            <a href="frmServicios.aspx" class="btn btn-primary">Ver Detalles</a>
                        </div>
                    </div>

                    <!-- Slide 3 -->
                    <div class="carousel-item">
                        <img src="IMAGENES/paquete-cdmx.jpg" class="d-block w-100" alt="Paquete Ciudad de México">
                        <div class="carousel-caption d-none d-md-block text-left">
                            <h3 class="text-white">Paquetes culturales a CDMX</h3>
                            <p>Vuelos + hotel céntrico + tour gastronómico y visitas guiadas.</p>
                            <a href="frmServicios.aspx" class="btn btn-primary">Reservar Ahora</a>
                        </div>
                    </div>

                </div>

                <!-- Controles -->
                <a class="carousel-control-prev" href="#paquetesCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon bg-primary rounded-circle p-3" aria-hidden="true"></span>
                    <span class="sr-only">Anterior</span>
                </a>
                <a class="carousel-control-next" href="#paquetesCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon bg-primary rounded-circle p-3" aria-hidden="true"></span>
                    <span class="sr-only">Siguiente</span>
                </a>
            </div>
        </div>
    </div>
    <!-- Fin Carrusel -->

    <!-- Destinos Destacados -->
    <div class="container my-5">
        <h2 class="text-center mb-4 text-primary">Destinos Destacados</h2>
        <div class="row g-4 destination-card">
            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <img src="IMAGENES/destino-cancun.jpg" class="card-img-top" alt="Cancún">
                    <div class="card-body text-center">
                        <h5 class="card-title">Cancún</h5>
                        <p class="card-text">Playas paradisíacas, resorts y excursiones a Isla Mujeres.</p>
                        <a href="frmServicios.aspx" class="btn btn-outline-primary btn-sm">Ver Paquete</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <img src="IMAGENES/destino-cdmx.jpg" class="card-img-top" alt="Ciudad de México">
                    <div class="card-body text-center">
                        <h5 class="card-title">Ciudad de México</h5>
                        <p class="card-text">Museos, gastronomía y turismo cultural en el corazón del país.</p>
                        <a href="frmServicios.aspx" class="btn btn-outline-primary btn-sm">Ver Paquete</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <img src="IMAGENES/destino-oaxaca.jpg" class="card-img-top" alt="Oaxaca">
                    <div class="card-body text-center">
                        <h5 class="card-title">Oaxaca</h5>
                        <p class="card-text">Tradición, gastronomía y patrimonio cultural.</p>
                        <a href="frmServicios.aspx" class="btn btn-outline-primary btn-sm">Ver Paquete</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card">
                    <img src="IMAGENES/destino-loscabos.jpg" class="card-img-top" alt="Los Cabos">
                    <div class="card-body text-center">
                        <h5 class="card-title">Los Cabos</h5>
                        <p class="card-text">Lujo en la playa y tours marítimos inolvidables.</p>
                        <a href="frmServicios.aspx" class="btn btn-outline-primary btn-sm">Ver Paquete</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Fin Destinos Destacados -->

    <!-- Servicios -->
    <section class="bg-light py-5">
        <div class="container text-center">
            <h2 class="mb-4">Nuestros Servicios</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="mb-3 service-icon"><i class="fa fa-plane"></i></div>
                    <h5>Vuelos y Paquetes</h5>
                    <p>Ofertas en vuelos nacionales e internacionales y paquetes completos a medida.</p>
                </div>
                <div class="col-md-4">
                    <div class="mb-3 service-icon"><i class="fa fa-hotel"></i></div>
                    <h5>Alojamiento</h5>
                    <p>Hoteles y resorts seleccionados con las mejores ubicaciones y atención.</p>
                </div>
                <div class="col-md-4">
                    <div class="mb-3 service-icon"><i class="fa fa-map"></i></div>
                    <h5>Tours Personalizados</h5>
                    <p>Itinerarios diseñados según tus intereses: cultura, aventura, descanso o gastronomía.</p>
                </div>
            </div>
        </div>
    </section>
    <!-- Fin Servicios -->

    <!-- Testimonios -->
    <div class="container my-5">
        <h2 class="text-center mb-4 text-primary">Lo Que Dicen Nuestros Viajeros</h2>
        <div class="row">
            <div class="col-md-4 mb-3">
                <div class="testimonial">
                    <p>"Excelente servicio y atención. Nuestro viaje a Cancún fue perfecto y sin contratiempos."</p>
                    <h6 class="text-primary mb-0">— Ana López, CDMX</h6>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="testimonial">
                    <p>"Reservamos en familia y todo llegó a tiempo. Muy recomendable la agencia."</p>
                    <h6 class="text-primary mb-0">— José Martínez, Guadalajara</h6>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="testimonial">
                    <p>"Grandes ofertas y atención personalizada. Volveremos a reservar con Trip & Go."</p>
                    <h6 class="text-primary mb-0">— Laura Ramírez, Monterrey</h6>
                </div>
            </div>
        </div>
    </div>
    <!-- Fin Testimonios -->

</asp:Content>
