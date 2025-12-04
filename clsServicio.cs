using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace wssProyecto
{
    public class clsServicio
    {
        // ============================
        // 1) Atributos de la clase
        // ============================
        int id;
        int categoria;
        int destino;
        int proveedor;
        string codigo;
        string nombre;
        string descripcion;
        float costo;
        int disponibilidad;
        string imagen;
        int estatus;

        // ============================
        // 2) Propiedades
        // ============================
        public int Id { get => id; set => id = value; }
        public int Categoria { get => categoria; set => categoria = value; }
        public int Destino { get => destino; set => destino = value; }
        public int Proveedor { get => proveedor; set => proveedor = value; }
        public string Codigo { get => codigo; set => codigo = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public float Costo { get => costo; set => costo = value; }
        public int Disponibilidad { get => disponibilidad; set => disponibilidad = value; }
        public string Imagen { get => imagen; set => imagen = value; }
        public int Estatus { get => estatus; set => estatus = value; }

        // ============================
        // 3) Objetos MySQL
        // ============================
        public MySqlConnection cnn;
        public MySqlCommand cmd;
        public MySqlDataReader dr;
        public MySqlDataAdapter da;
        public DataSet ds;

        // ============================
        // 4) Constructor
        // ============================
        public clsServicio()
        {
            id = 0;
            categoria = 0;
            destino = 0;
            proveedor = 0;
            codigo = "";
            nombre = "";
            descripcion = "";
            costo = 0;
            disponibilidad = 0;
            imagen = "";
            estatus = 0;
        }

        // ============================
        // 5) Destructor
        // ============================
        ~clsServicio()
        {
            System.GC.Collect();
        }

        // ================================================================
        // 6) MÉTODO: Listar servicios
        // ================================================================
        public DataSet listarServicios(string con, int op, int idServ)
        {
            da = new MySqlDataAdapter("CALL tspListarServicios('" + op + "','" + idServ + "');", con);
            ds = new DataSet();
            da.Fill(ds, "servicios");
            return ds;
        }

        // ================================================================
        // 7) MÉTODO: Buscar servicio por ID
        // ================================================================
        public void buscarServicio(string cadConexion, int clave)
        {
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;

            cmd = new MySqlCommand();
            cmd.CommandText = "CALL tspServicioObtener('" + clave + "');";
            cmd.Connection = cnn;

            cnn.Open();
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                this.Id = clave;

                this.Categoria = dr["CAT_Clave"] != DBNull.Value ? Convert.ToInt32(dr["CAT_Clave"]) : 0;
                this.Destino = dr["DES_Id"] != DBNull.Value ? Convert.ToInt32(dr["DES_Id"]) : 0;
                this.Proveedor = dr["PRO_Id"] != DBNull.Value ? Convert.ToInt32(dr["PRO_Id"]) : 0;

                this.Codigo = dr["SER_Codigo"].ToString();
                this.Nombre = dr["SER_Nombre"].ToString();
                this.Descripcion = dr["SER_Descripcion"].ToString();

                this.Costo = dr["SER_Costo"] != DBNull.Value
                    ? float.Parse(dr["SER_Costo"].ToString())
                    : 0;

                this.Disponibilidad = dr["SER_Disponibilidad"] != DBNull.Value
                    ? Convert.ToInt32(dr["SER_Disponibilidad"])
                    : 0;

                this.Imagen = dr["SER_Imagen"] != DBNull.Value ? dr["SER_Imagen"].ToString() : "";
                this.Estatus = dr["SER_Estatus"] != DBNull.Value ? Convert.ToInt32(dr["SER_Estatus"]) : 0;
            }


            dr.Close();
            cnn.Close();
        }

        // ================================================================
        // 8) MÉTODO: Registrar servicio
        // ================================================================
        public int registrarServicio(
    string cadConexion, int categoria, int destino, int proveedor,
    string codigo, string nombre, string descripcion, float costo,
    int disponibilidad, string imagen, int estatus)
        {
            int resultado = 0;

            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;

            cmd = new MySqlCommand();

            cmd.CommandText =
                "CALL tspServicioInsertar('" +
                categoria + "','" +
                destino + "','" +
                proveedor + "','" +
                codigo + "','" +
                nombre + "','" +
                descripcion + "','" +
                costo + "','" +
                disponibilidad + "','" +
                imagen + "','" +
                estatus + "');";

            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                resultado = int.Parse(dr.GetValue(0).ToString());
            }

            dr.Close();
            cnn.Close();

            return resultado;
        }

        public int modificarServicio(
            string cadConexion, int id, int categoria, int destino, int proveedor,
            string codigo, string nombre, string descripcion, float costo,
            int disponibilidad, string imagen, int estatus)
        {
            int resultado = 0;

            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;

            cmd = new MySqlCommand();
            cmd.CommandText =
                "CALL tspServicioActualizar('" +
                id + "','" +
                categoria + "','" +
                destino + "','" +
                proveedor + "','" +
                codigo + "','" +
                nombre + "','" +
                descripcion + "','" +
                costo + "','" +
                disponibilidad + "','" +
                imagen + "','" +
                estatus + "');";

            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                resultado = int.Parse(dr.GetValue(0).ToString());
            }

            dr.Close();
            cnn.Close();

            return resultado;
        }

        // ================================================================
        // 10) MÉTODO: Eliminar servicio
        // ================================================================
        public int eliminarServicio(string cadConexion, int clave)
        {
            int resultado = 0;

            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;

            cmd = new MySqlCommand();
            cmd.CommandText = "CALL tspServicioEliminar(@p_SER_Id);";
            cmd.Parameters.AddWithValue("@p_SER_Id", clave);
            cmd.Connection = cnn;

            try
            {
                cnn.Open();
                dr = cmd.ExecuteReader();

                // Leer el resultado (FilasAfectadas)
                if (dr.Read())
                {
                    resultado = Convert.ToInt32(dr["FilasAfectadas"]);
                }

                dr.Close();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar servicio: " + ex.Message);
            }
            finally
            {
                if (cnn.State == System.Data.ConnectionState.Open)
                    cnn.Close();
            }

            return resultado;
        }
    }
}
