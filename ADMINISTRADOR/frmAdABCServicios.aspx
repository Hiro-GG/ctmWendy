<%@ Page Title="" Language="C#" MasterPageFile="~/ADMINISTRADOR/mpAdministrador.Master" AutoEventWireup="true" CodeBehind="frmAdABCServicios.aspx.cs" Inherits="wssProyecto.ADMINISTRADOR.Formulario_web16" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* ========== ESTILOS IDÉNTICOS A USUARIOS ========== */
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

        .perfil-container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 30px;
            box-shadow: 0 30px 80px rgba(27, 94, 32, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.8);
            overflow: visible;
        }

        .perfil-header {
            background: linear-gradient(135deg, #2e7d32 0%, #43a047 50%, #66bb6a 100%);
            padding: 50px;
            color: white;
            position: relative;
            overflow: hidden;
            border-radius: 30px 30px 0 0;
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

        .perfil-content {
            padding: 60px 50px 50px;
        }

        .seccion {
            margin-bottom: 40px;
            padding: 35px;
            background: linear-gradient(135deg, #f1f8e9 0%, #ffffff 100%);
            border-radius: 20px;
            border-left: 5px solid #43a047;
            box-shadow: 0 10px 30px rgba(67, 160, 71, 0.08);
            transition: all 0.3s ease;
            animation: slideInUp 0.6s ease-out backwards;
        }

        .seccion:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(67, 160, 71, 0.15);
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

        .campo-texto {
            padding: 16px 20px;
            border: 2px solid #c8e6c9;
            border-radius: 15px;
            font-size: 0.95em;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            background: #ffffff;
            font-family: 'Poppins', sans-serif;
            color: #1b5e20;
            width: 100%;
        }

        .campo-texto:focus {
            border-color: #43a047;
            outline: none;
            box-shadow: 0 0 0 4px rgba(67, 160, 71, 0.15), 0 5px 15px rgba(67, 160, 71, 0.1);
            transform: translateY(-2px);
        }

        .campo-texto[readonly] {
            background: linear-gradient(135deg, #e8f5e9, #f1f8e9);
            color: #558b2f;
            cursor: not-allowed;
        }

        .grupo-foto {
            display: flex;
            align-items: center;
            gap: 40px;
            padding: 40px;
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
            border-radius: 25px;
            position: relative;
            overflow: hidden;
            flex-wrap: wrap;
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

        .campo-archivo { display: none; }

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
            transition: all 0.4s ease;
            box-shadow: 0 8px 20px rgba(46, 125, 50, 0.3);
            position: relative;
            z-index: 1;
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

        .seccion-botones {
            margin-top: 50px;
            padding-top: 35px;
            border-top: 2px solid #c8e6c9;
            display: flex;
            justify-content: flex-end;
            gap: 20px;
            flex-wrap: wrap;
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
            text-transform: uppercase;
            position: relative;
            overflow: hidden;
            min-width: 160px;
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

        .boton-accion:hover::before { left: 15px; }

        .boton-accion:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(46, 125, 50, 0.4);
            padding-left: 55px;
        }

        @keyframes slideInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .seccion:nth-child(1) { animation-delay: 0.1s; }
        .seccion:nth-child(2) { animation-delay: 0.2s; }
        .seccion:nth-child(3) { animation-delay: 0.3s; }

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
                font-size: 1.8em;
            }

            .seccion {
                padding: 25px 20px;
            }

            .fila-campos {
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

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

    <div class="perfil-container">

        <div class="perfil-header">
            <span class="titulo-principal">Gestión de Servicios</span>
        </div>

        <div class="perfil-content">

            <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger" Style="display:block; margin-bottom: 20px; font-weight:600;"></asp:Label>
            <div class="seccion">
                <div class="subtitulo">Información General</div>

                <div class="fila-campos">
                    <div class="grupo-campo">
                        <label class="etiqueta">Código</label>
                        <asp:TextBox ID="txtCodigo" runat="server" CssClass="campo-texto" ReadOnly="true" placeholder="Autogenerado"></asp:TextBox>
                    </div>

                    <div class="grupo-campo largo">
                        <label class="etiqueta">Nombre del Servicio</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="campo-texto" placeholder="Ej. Transporte Privado"></asp:TextBox>
                    </div>
                </div>

                <div class="fila-campos">
                    <div class="grupo-campo">
                        <label class="etiqueta">Categoría</label>
                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="campo-texto"></asp:DropDownList>
                    </div>

                    <div class="grupo-campo">
                        <label class="etiqueta">Destino</label>
                        <asp:DropDownList ID="ddlDestino" runat="server" CssClass="campo-texto"></asp:DropDownList>
                    </div>
                </div>

                 <div class="fila-campos">
                    <div class="grupo-campo">
                        <label class="etiqueta">Proveedor</label>
                        <asp:DropDownList ID="ddlProveedor" runat="server" CssClass="campo-texto"></asp:DropDownList>
                    </div>

                     <div class="grupo-campo">
                        <label class="etiqueta">Costo ($)</label>
                        <asp:TextBox ID="txtCosto" runat="server" CssClass="campo-texto" placeholder="0.00"></asp:TextBox>
                    </div>
                </div>

                <div class="fila-campos">
                    <div class="grupo-campo">
                        <label class="etiqueta">Disponibilidad</label>
                        <asp:TextBox ID="txtDisponibilidad" runat="server" CssClass="campo-texto" placeholder="Cantidad"></asp:TextBox>
                    </div>

                    <!-- NUEVO: ESTATUS -->
                    <div class="grupo-campo">
                        <label class="etiqueta">Estatus</label>
                        <asp:DropDownList ID="ddlEstatus" runat="server" CssClass="campo-texto">
                            <asp:ListItem Text="Disponible" Value="1" />
                            <asp:ListItem Text="No disponible" Value="0" />
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="fila-campos">
                    <div class="grupo-campo largo">
                        <label class="etiqueta">Descripción Detallada</label>
                        <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="3" CssClass="campo-texto" placeholder="Detalles del servicio..."></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="seccion">
                <div class="subtitulo">Galería del Servicio</div>

                <div class="grupo-foto">
                    <asp:ImageButton ID="imgbFoto" runat="server" OnClick="imgbFoto_Click" CssClass="img-perfil" />
                    
                    <div class="foto-controls">
                        <asp:Label ID="lblFoto" runat="server" Text="Seleccionar nueva foto" CssClass="etiqueta" Style="display:block; margin-bottom: 15px;"></asp:Label>
                        
                        <label for="<%= examinar.ClientID %>" class="etiqueta-archivo">
                            Elegir Archivo
                        </label>
                        
                        <asp:FileUpload ID="examinar" runat="server" CssClass="campo-archivo" />
                        <asp:Label ID="hddRutaFisica" runat="server" Text="[]" Style="display:block; margin-top: 15px; font-size: 0.85em; color: #558b2f;"></asp:Label>
                    </div>
                </div>
            </div>

            <div class="seccion-botones">
                <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" CssClass="boton-accion" OnClick="btnNuevo_Click" />
                <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="boton-accion" OnClick="btnRegistrar_Click" />
                <asp:Button ID="btnModificar" runat="server" Text="Guardar Cambios" CssClass="boton-accion" OnClick="btnModificar_Click" />
                <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="boton-accion" OnClick="btnRegresar_Click" />
            </div>

        </div>
    </div>

</asp:Content>
