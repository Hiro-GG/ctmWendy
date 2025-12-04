using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
//se usa para el arraylist
using System.Collections;
//1.agregar las librerias que permitan manejar instrucciones de MYSQL
//maneja cualquier origen de datos 
using System.Data;
//ejecutar las instrucciones de mysql como sp
using MySql.Data.MySqlClient;
using System.Runtime.Remoting;

namespace wssProyecto
{
    public class clsCarrito
    {
        //permite administrar la cadena de conexion de la bd
        public MySqlConnection cnn;
        //ejecuta un comando de mysql
        public MySqlCommand cmd;
        //recibe varios registros que van a un solo control o una variable
        public MySqlDataAdapter da;
        //recibe varios registros que pueden ir a diferentes controles 
        public MySqlDataReader dr;
        //recibe el resultado de muchos registros sin tipearse es decir sin formato
        public DataSet ds;

        ~clsCarrito()
        {
            System.GC.Collect();
        }
        //LISTA LOS PRODUCTOS QUE SE PUEDEN COMPRAR
        public DataSet listarProductos(string cadConexion)
        {
            da = new MySqlDataAdapter("call tspServiciosDisponibles();", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "Productos");
            return ds;
        }

        public DataSet listarVentasCliente(string cadConexion, int cliente)
        {
            //se hace una copia del adapter para ejecutar el sp
            da = new MySqlDataAdapter("call tspMostrarReservasCliente('" + cliente + "');", cadConexion);
            //guardara los registros que devuelve el procedimiento
            ds = new DataSet();
            da.Fill(ds, "ReservasRealizadas");
            return ds;
        }
        //insertar nueva venta
        public string insertarVenta(string cadConexion, int cveCliente, float total)
        {
            string resultado = "0";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call tspRegistroNuevaReserva('" + cveCliente + "','" + total + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                resultado = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultado;
        }


        public DataSet buscarProducto(String cadConexion, int clave)
        {
            da = new MySqlDataAdapter("call tspBuscarServicio('" + clave + "');", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "ServicioEncontrado");
            return ds;

        }
        public string insertarDetalleReserva(string cadConexion, int cveVenta, int cveProd, int cantidad, double subtotal)
        {
            string resultadoConsulta = "";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call tspRegistrarDetalleReserva('" + cveVenta + "','" + cveProd + "','" + cantidad + "','" + subtotal + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            resultadoConsulta = "0";
            while (dr.Read())
            {
                resultadoConsulta = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultadoConsulta;
        }

        public DataSet listarDetalleReserva(string cadConexion, int cveVenta)
        {
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.Connection = cnn;
            cmd.CommandText = "call tspDetalleReservaActual('" + cveVenta + "');";
            da = new MySqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds, "ReservaActual");
            return ds;
        }

        public string eliminarServicioReserva(string cadConexion, int cveVenta, int cveProd, int cantidad)
        {
            string resultadoConsulta = "";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call tspEliminarServicioReserva('" + cveVenta + "','"
                + cveProd + "','" + cantidad + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            resultadoConsulta = "0";
            while (dr.Read())
            {
                resultadoConsulta = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultadoConsulta;
        }

        public string confirmarReserva(string cadConexion, int cveVenta, float total)
        {
            string resultadoConsulta = "";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call tspConfirmarReserva('" + cveVenta + "','" + total + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            resultadoConsulta = "0";
            while (dr.Read())
            {
                resultadoConsulta = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultadoConsulta;
        }

        public DataSet listarVentas(string cadConexion)
        {
            //se hace una copia del adapter para ejecutar el sp
            da = new MySqlDataAdapter("call tspListarVentas();", cadConexion);

            //guardará los registros que devuelve el procedimiento
            ds = new DataSet();

            //el nombre de la tabla interna del dataset
            da.Fill(ds, "VentasRealizadas");

            return ds;
        }
        // LISTAR TOP 10 SERVICIOS MÁS VENDIDOS
        public DataSet listarTopMasVendidos(string cadConexion)
        {
            // Ejecuta el SP de MySQL
            da = new MySqlDataAdapter("call tspTop10ServiciosMasVendidos();", cadConexion);

            // Guardará los registros que devuelve el procedimiento
            ds = new DataSet();

            // Nombre de la tabla interna del DataSet
            da.Fill(ds, "TopMasVendidos");

            return ds;
        }

        // LISTAR TOP 10 SERVICIOS MENOS VENDIDOS
        public DataSet listarTopMenosVendidos(string cadConexion)
        {
            // Ejecuta el SP de MySQL
            da = new MySqlDataAdapter("call tspTop10ServiciosMenosVendidos();", cadConexion);

            // Guardará los registros que devuelve el procedimiento
            ds = new DataSet();

            // Nombre de la tabla interna del DataSet
            da.Fill(ds, "TopMenosVendidos");

            return ds;
        }
        public DataSet listarVentasServiciosTotales(string cadConexion)
        {
            da = new MySqlDataAdapter("call tspServiciosVentasTotales();", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "VentasServicios");
            return ds;
        }

        public DataSet listarServiciosCliente(string cadConexion)
        {
            MySqlDataAdapter da = new MySqlDataAdapter("CALL tspServiciosDisponiblesCliente();", cadConexion);
            DataSet ds = new DataSet();
            da.Fill(ds, "Servicios");
            return ds;
        }

        public string cancelarReserva(string cadConexion, int cveVenta)
        {
            string resultadoConsulta = "";
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call tspCancelarReserva('" + cveVenta + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();
            resultadoConsulta = "0";
            while (dr.Read())
            {
                resultadoConsulta = dr.GetValue(0).ToString();
            }
            dr.Close();
            cnn.Close();
            return resultadoConsulta;
        }
        // Método para obtener el resumen del cliente (Reservas activas y último viaje)
        public DataSet obtenerResumenCliente(string cadConexion, int cveUsuario)
        {
           
            da = new MySqlDataAdapter("call tspResumenCliente('" + cveUsuario + "');", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "Resumen");
            return ds;
        }
        
        // Método para obtener las métricas del panel de Administrador
        public DataSet obtenerResumenAdmin(string cadConexion)
        {
            
            da = new MySqlDataAdapter("call tspResumenAdministrador();", cadConexion);
            ds = new DataSet();
            da.Fill(ds, "ResumenAdmin");
            return ds;
        }


    }
}