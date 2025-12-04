<%@ Page Title="" Language="C#" MasterPageFile="~/mpPrincipal.Master" AutoEventWireup="true" CodeBehind="frmRegistro.aspx.cs" Inherits="wssProyecto.Formulario_web15" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <!-- Fuentes modernas -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 50%, #a5d6a7 100%);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
        }

        /* Contenedor Principal con efecto de cristal */
        .perfil-container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 30px;
            box-shadow: 0 30px 80px rgba(27, 94, 32, 0.15);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.8);
        }

        /* Header del perfil con diseño ondulado */
        .perfil-header {
            background: linear-gradient(135deg, #2e7d32 0%, #43a047 50%, #66bb6a 100%);
            padding: 50px;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .perfil-header::before {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 100px;
            background: rgba(255, 255, 255, 0.95);
            clip-path: ellipse(70% 100% at 50% 100%);
            z-index: 1;
        }

        .perfil-header::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
            z-index: 1;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .titulo-principal {
            font-size: 3em;
            font-weight: 900;
            margin: 0;
            display: block;
            position: relative;
            z-index: 2;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.5), 0 2px 5px rgba(0, 0, 0, 0.3);
            color: #ffffff;
            letter-spacing: 2px;
            -webkit-text-stroke: 1px rgba(255, 255, 255, 0.3);
            text-transform: uppercase;
        }

        .subtitulo-header {
            position: relative;
            z-index: 2;
            margin-top: 10px;
            font-size: 0.95em;
            color: #e8f5e9;
        }

        /* Contenido del formulario */
        .perfil-content {
            padding: 60px 50px 50px;
        }

        /* Secciones con tarjetas */
        .seccion {
            margin-bottom: 40px;
            padding: 35px;
            background: linear-gradient(135deg, #f1f8e9 0%, #ffffff 100%);
            border-radius: 20px;
            border-left: 5px solid #43a047;
            box-shadow: 0 10px 30px rgba(67, 160, 71, 0.08);
            transition: all 0.3s ease;
        }

        .seccion:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(67, 160, 71, 0.15);
        }

        .seccion:last-of-type {
            margin-bottom: 0;
        }

        .subtitulo {
            font-size: 1.3em;
            color: #2e7d32;
            font-weight: 700;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .subtitulo::before {
            content: '';
            width: 8px;
            height: 8px;
            background: linear-gradient(135deg, #43a047, #66bb6a);
            border-radius: 50%;
            box-shadow: 0 0 15px rgba(67, 160, 71, 0.6);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.3); opacity: 0.7; }
        }

        /* Grid de campos */
        .fila-campos {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 25px;
        }

        .grupo-campo {
            display: flex;
            flex-direction: column;
            position: relative;
        }
        
        .grupo-campo.largo {
            grid-column: 1 / -1;
        }

        /* Etiquetas modernas */
        .etiqueta {
            font-weight: 600;
            color: #1b5e20;
            margin-bottom: 10px;
            font-size: 0.9em;
            letter-spacing: 0.3px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .etiqueta::before {
            content: '●';
            color: #66bb6a;
            font-size: 0.6em;
        }

        /* Campos de texto con efecto moderno */
        .campo-texto {
            padding: 16px 20px;
            border: 2px solid #c8e6c9;
            border-radius: 15px;
            font-size: 0.95em;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            background: #ffffff;
            font-family: 'Poppins', sans-serif;
            color: #1b5e20;
            position: relative;
        }

        .campo-texto::placeholder {
            color: #81c784;
        }

        .campo-texto:hover {
            border-color: #81c784;
            background: #f9fdf9;
        }

        .campo-texto:focus {
            border-color: #43a047;
            background: #ffffff;
            outline: none;
            box-shadow: 0 0 0 4px rgba(67, 160, 71, 0.15), 0 5px 15px rgba(67, 160, 71, 0.1);
            transform: translateY(-2px);
        }

        .campo-texto[readonly] {
            background: linear-gradient(135deg, #e8f5e9, #f1f8e9);
            color: #558b2f;
            cursor: not-allowed;
            border-color: #a5d6a7;
        }

        /* Sección de Foto con diseño circular mejorado */
        .grupo-foto {
            display: flex;
            align-items: center;
            gap: 40px;
            padding: 40px;
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
            border-radius: 25px;
            margin-top: 20px;
            position: relative;
            overflow: hidden;
        }

        .grupo-foto::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(67, 160, 71, 0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .img-perfil {
            width: 200px;  
            height: 200px; 
            border-radius: 50%;
            object-fit: cover;
            border: 6px solid #ffffff;
            box-shadow: 0 15px 40px rgba(46, 125, 50, 0.3);
            transition: all 0.5s ease;
            position: relative;
            z-index: 1;
        }

        .img-perfil:hover {
            transform: scale(1.08) rotate(5deg);
            box-shadow: 0 20px 50px rgba(46, 125, 50, 0.4);
            border-color: #66bb6a;
        }

        .foto-controls {
            flex: 1;
            position: relative;
            z-index: 1;
        }

        /* FileUpload personalizado con diseño verde */
        .campo-archivo {
            display: none;
        }

        .etiqueta-archivo {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 15px 35px;
            background: linear-gradient(135deg, #2e7d32 0%, #43a047 100%);
            color: white;
            border-radius: 15px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.95em;
            transition: all 0.4s ease;
            box-shadow: 0 8px 20px rgba(46, 125, 50, 0.3);
            position: relative;
            overflow: hidden;
        }

        .etiqueta-archivo::before {
            content: '📁';
            font-size: 1.2em;
        }

        .etiqueta-archivo::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .etiqueta-archivo:hover::after {
            width: 300px;
            height: 300px;
        }

        .etiqueta-archivo:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(46, 125, 50, 0.4);
        }

        .etiqueta-archivo:active {
            transform: translateY(0);
        }

        /* Botones de Acción modernos */
        .seccion-botones {
            margin-top: 50px;
            padding-top: 35px;
            border-top: 2px solid #c8e6c9;
            display: flex;
            justify-content: flex-end;
            gap: 20px;
        }

        .boton-accion {
            padding: 18px 45px;
            background: linear-gradient(135deg, #2e7d32 0%, #43a047 50%, #66bb6a 100%);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 1.05em;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 10px 25px rgba(46, 125, 50, 0.3);
            font-family: 'Poppins', sans-serif;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            position: relative;
            overflow: hidden;
        }

        .boton-accion::before {
            content: '✓';
            position: absolute;
            left: -30px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.5em;
            transition: left 0.4s ease;
        }

        .boton-accion:hover::before {
            left: 15px;
        }

        .boton-accion:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(46, 125, 50, 0.4);
            padding-left: 55px;
        }

        .boton-accion:active {
            transform: translateY(0);
        }

        .boton-secundario {
            background: transparent;
            color: #2e7d32;
            border: 2px solid #a5d6a7;
            box-shadow: none;
        }

        .boton-secundario::before {
            content: '';
        }

        .boton-secundario:hover {
            padding-left: 45px;
        }

        /* Grid especial para dirección */
        .grid-direccion-1 {
            display: grid;
            grid-template-columns: 1fr 140px;
            gap: 25px;
            margin-bottom: 25px;
        }

        .grid-direccion-2 {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-bottom: 25px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .perfil-container {
                margin: 20px;
                border-radius: 20px;
            }

            .perfil-header {
                padding: 35px 25px;
            }

            .perfil-content {
                padding: 40px 25px 30px;
            }

            .titulo-principal {
                font-size: 2em;
            }

            .seccion {
                padding: 25px 20px;
            }

            .fila-campos {
           

 grid-template-columns: 1fr;
            }

            .grid-direccion-1,
            .grid-direccion-2 {
                grid-template-columns: 1fr;
            }

            .grupo-foto {
                flex-direction: column;
                text-align: center;
                padding: 30px 20px;
            }

            .img-perfil {
                width: 150px;
                height: 150px;
            }
        }

        /* Animación de entrada */
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .seccion {
            animation: slideInUp 0.6s ease-out backwards;
        }

        .seccion:nth-child(1) { animation-delay: 0.1s; }
        .seccion:nth-child(2) { animation-delay: 0.2s; }
        .seccion:nth-child(3) { animation-delay: 0.3s; }
        .seccion:nth-child(4) { animation-delay: 0.4s; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="perfil-container">
        <!-- Header -->
        <div class="perfil-header">
            <asp:Label ID="lblMiPerfil" runat="server" Text="Crear Cuenta" CssClass="titulo-principal"></asp:Label>
            <div class="subtitulo-header">
                Regístrate para reservar viajes, guardar favoritos y recibir ofertas personalizadas.
            </div>
        </div>

        <!-- Contenido -->
        <div class="perfil-content">
            
            <!-- Sección: Datos Personales -->
            <div class="seccion">
                <asp:Label ID="lblDatosPersonales" runat="server" Text="Datos Personales" CssClass="subtitulo"></asp:Label>
                
                <div class="fila-campos">
                    <div class="grupo-campo">
                        <asp:Label ID="lblRol" runat="server" Text="Rol del cliente" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtRol" runat="server" placeHolder="CLIENTE" CssClass="campo-texto" ReadOnly="True"></asp:TextBox>
                    </div>
                    <div class="grupo-campo">
                        <asp:Label ID="lblNombre" runat="server" Text="Nombre(s)" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtNombre" runat="server" placeHolder="Tu nombre" CssClass="campo-texto"></asp:TextBox>
                    </div>
                </div>
                
                <div class="fila-campos">
                    <div class="grupo-campo">
                        <asp:Label ID="lblApPa" runat="server" Text="Apellido Paterno" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtApPa" runat="server" placeHolder="Apellido Paterno" CssClass="campo-texto"></asp:TextBox>
                    </div>
                    <div class="grupo-campo">
                        <asp:Label ID="lblApMa" runat="server" Text="Apellido Materno" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtApMa" runat="server" placeHolder="Apellido Materno" CssClass="campo-texto"></asp:TextBox>
                    </div>
                </div>

                <div class="fila-campos">
                    <div class="grupo-campo">
                        <asp:Label ID="lblEmail" runat="server" Text="Email" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" placeHolder="correo@ejemplo.com" CssClass="campo-texto"></asp:TextBox>
                    </div>
                    <div class="grupo-campo">
                        <asp:Label ID="lblRfc" runat="server" Text="RFC" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtRfc" runat="server" placeHolder="IUR96F0505001" CssClass="campo-texto"></asp:TextBox>
                    </div>
                </div>
                
                <div class="fila-campos">
                    <div class="grupo-campo">
                        <asp:Label ID="lblTelefono" runat="server" Text="Teléfono Particular" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtTel" runat="server" placeHolder="771 22 08135" CssClass="campo-texto"></asp:TextBox>
                    </div>
                    <div class="grupo-campo">
                        <asp:Label ID="lblCelular" runat="server" Text="Número de Celular" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtCel" runat="server" placeHolder="771 220 8135" CssClass="campo-texto"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Sección: Dirección -->
            <div class="seccion">
                <asp:Label ID="lblDir" runat="server" Text="Dirección" CssClass="subtitulo"></asp:Label>
                
                <div class="grid-direccion-1">
                    <div class="grupo-campo">
                        <asp:Label ID="lblCalle" runat="server" Text="Calle" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtCalle" runat="server" placeHolder="Nombre de la calle" CssClass="campo-texto"></asp:TextBox>
                    </div>
                    <div class="grupo-campo">
                        <asp:Label ID="lblNum" runat="server" Text="Número" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtNum" runat="server" placeHolder="Núm." CssClass="campo-texto"></asp:TextBox>
                    </div>
                </div>

                <div class="fila-campos">
                    <div class="grupo-campo">
                        <asp:Label ID="lblColonia" runat="server" Text="Colonia" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtCol" runat="server" placeHolder="Colonia" CssClass="campo-texto"></asp:TextBox>
                    </div>
                    <div class="grupo-campo">
                        <asp:Label ID="lblCp" runat="server" Text="Código Postal" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtColo" runat="server" placeHolder="C.P." CssClass="campo-texto"></asp:TextBox>
                    </div>
                </div>
                
                <div class="grid-direccion-2">
                    <div class="grupo-campo">
                        <asp:Label ID="lblEstado" runat="server" Text="Estado" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtEstado" runat="server" placeHolder="Estado" CssClass="campo-texto"></asp:TextBox>
                    </div>
                    <div class="grupo-campo">
                        <asp:Label ID="lblMunicipio" runat="server" Text="Municipio" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtMuni" runat="server" placeHolder="Municipio" CssClass="campo-texto"></asp:TextBox>
                    </div>
                    <div class="grupo-campo">
                        <asp:Label ID="lblCiudad" runat="server" Text="Ciudad" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtCiudad" runat="server" placeHolder="Ciudad" CssClass="campo-texto"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Sección: Fotografía -->
            <div class="seccion">
                <asp:Label ID="lblFotoSection" runat="server" Text="Fotografía de Perfil" CssClass="subtitulo"></asp:Label>
                <div class="grupo-foto">
                    <asp:ImageButton ID="imgbFoto" runat="server" CssClass="img-perfil" ImageUrl="~/IMAGENES/userDefault.jpg" OnClick="imgbFoto_Click" />
                    
                    <div class="foto-controls">
                        <asp:Label ID="lblFoto" runat="server" Text="Seleccionar nueva foto (opcional)" CssClass="etiqueta" Style="display:block; margin-bottom: 15px;"></asp:Label>
                        
                        <!-- Label vinculado al FileUpload usando id fijo (ClientIDMode Static) -->
                        <label for="examinar" class="etiqueta-archivo">
                            Elegir Archivo
                        </label>
                        
                        <asp:FileUpload ID="examinar" runat="server" CssClass="campo-archivo" ClientIDMode="Static" />
                        <asp:Label ID="hddRutaFisica" runat="server" Text="" Style="display:block; margin-top: 15px; font-size: 0.85em; color: #558b2f;"></asp:Label>
                    </div>
                </div>
            </div>

            <!-- Sección: Credenciales -->
            <div class="seccion">
                <asp:Label ID="lblAccesoSection" runat="server" Text="Credenciales de Acceso" CssClass="subtitulo"></asp:Label>
                
                <div class="fila-campos">
                    <div class="grupo-campo largo">
                        <asp:Label ID="lblUsuarioAcceso" runat="server" Text="Nombre de Usuario" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtUsuarioAcceso" runat="server" placeHolder="Elige tu nombre de usuario" CssClass="campo-texto"></asp:TextBox>
                    </div>
                </div>
                
                <div class="fila-campos">
                    <div class="grupo-campo">
                        <asp:Label ID="lblContraseña" runat="server" Text="Contraseña" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtContraseña" runat="server" placeHolder="Contraseña de acceso" CssClass="campo-texto" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="grupo-campo">
                        <asp:Label ID="lblConfiContra" runat="server" Text="Confirmar Contraseña" CssClass="etiqueta"></asp:Label>
                        <asp:TextBox ID="txtConfiContra" runat="server" placeHolder="Confirmar contraseña de acceso" CssClass="campo-texto" TextMode="Password"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Botones -->
            <div class="seccion-botones">
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="boton-accion boton-secundario" CausesValidation="false" OnClick="btnCancelar_Click" />
                <asp:Button ID="btnRegistrar" runat="server" Text="Registrarme" CssClass="boton-accion" OnClick="btnRegistrar_Click" />
            </div>
            
        </div>
    </div>
</asp:Content>
