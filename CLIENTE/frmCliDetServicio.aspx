<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmCliDetServicio.aspx.cs" Inherits="wssProyecto.CLIENTE.frmCliDetServicio" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Detalle del Servicio</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 0;
            margin: 0;
            overflow-x: hidden;
        }
        
        #form1 {
            width: 100%;
            height: 100vh;
            overflow-y: auto;
        }
        
        #dtvProducto {
            width: 100% !important;
            background: white;
            border: none !important;
            box-shadow: none;
            height: auto !important;
        }
        
        #dtvProducto tr {
            display: flex;
            flex-direction: column;
            border: none !important;
        }
        
        #dtvProducto td {
            border: none !important;
            padding: 0 !important;
        }
        
        /* Header estilo card compacto */
        #dtvProducto tr td:first-child {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 15px !important;
            font-weight: 600;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        /* Valor con diseño limpio */
        #dtvProducto tr td:last-child {
            padding: 10px 15px !important;
            background: #f8f9fa;
            color: #2d3748;
            font-size: 13px;
            line-height: 1.5;
            border-bottom: 1px solid #e2e8f0 !important;
        }
        
        /* Imagen con diseño especial */
        #dtvProducto tr:last-child {
            background: white;
            padding: 15px !important;
        }
        
        #dtvProducto tr:last-child td:first-child {
            background: #667eea;
            margin-bottom: 10px;
            border-radius: 6px;
        }
        
        #dtvProducto tr:last-child td:last-child {
            background: white;
            text-align: center;
            padding: 0 !important;
            border: none !important;
        }
        
        #dtvProducto img {
            width: 100% !important;
            max-width: 280px !important;
            height: auto !important;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        /* Estilos específicos para campos importantes */
        #dtvProducto tr:nth-child(2) td:last-child {
            font-size: 16px;
            font-weight: 700;
            color: #667eea;
            background: #f0f4ff;
        }
        
        /* Precio destacado */
        #dtvProducto tr:nth-child(6) td:last-child {
            font-size: 20px;
            font-weight: 700;
            color: #10b981;
            background: #f0fdf4;
        }
        
        /* Estatus con badge style */
        #dtvProducto tr:nth-child(8) td:last-child {
            font-weight: 600;
            background: #fef3c7;
            color: #92400e;
        }
        
        /* Scrollbar personalizado */
        #form1::-webkit-scrollbar {
            width: 6px;
        }
        
        #form1::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        
        #form1::-webkit-scrollbar-thumb {
            background: #667eea;
            border-radius: 3px;
        }
        
        #form1::-webkit-scrollbar-thumb:hover {
            background: #764ba2;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DetailsView ID="dtvProducto" runat="server" AutoGenerateRows="False">
                <Fields>
                    <asp:BoundField DataField="Clave" HeaderText="Clave" />
                    <asp:BoundField DataField="Servicio" HeaderText="Servicio" />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                    <asp:BoundField DataField="Categoria" HeaderText="Categoría" />
                    <asp:BoundField DataField="Disponibilidad" HeaderText="Disponibilidad" />
                    <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Estatus" HeaderText="Estatus" />
                    <asp:ImageField DataImageUrlField="Imagen" HeaderText="Imagen">
                        <ControlStyle />
                    </asp:ImageField>
                </Fields>
            </asp:DetailsView>
        </div>
    </form>
</body>
</html>