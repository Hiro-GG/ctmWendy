using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
// se usa para el arraylist
using System.Collections;
//1. agregar las librerias que permiten manejar MYSQL
using System.Data;
//Manejar todos los registros de mysql
using MySql.Data;
//ejecutar las instrucciones de mysql como sp 
using MySql.Data.MySqlClient;
using System.Collections.Specialized;
using System.Drawing;

namespace wssProyecto
{
    public class clsUsuario
    {
        //2.Atributos de la clase
        string usuario;
        string contra;
        string nomUsuario;
        string rol;
        int clave;
        // atributos para mostrar datos del usuario
        string rolUsu;
        string nombreUsu;
        string ApeP;
        string ApeM;
        string UsuAcceso;
        string contrAcceso;
        string Foto;
        string Rfc;
        string calle;
        string numero;
        string colonia;
        string ciudad;
        string municipio;
        string estado;
        int codigoPostal;
        string telefono;
        string celular;
        string correo;

        //Propiedades
        public string Usuario { get => usuario; set => usuario = value; }
        public string Contra { get => contra; set => contra = value; }
        public string NomUsuario { get => nomUsuario; set => nomUsuario = value; }
        public string Rol { get => rol; set => rol = value; }
        public int Clave { get => clave; set => clave = value; }
        public string RolUsu { get => rolUsu; set => rolUsu = value; }
        public string NombreUsu { get => nombreUsu; set => nombreUsu = value; }
        public string ApeP1 { get => ApeP; set => ApeP = value; }
        public string ApeM1 { get => ApeM; set => ApeM = value; }
        public string UsuAcceso1 { get => UsuAcceso; set => UsuAcceso = value; }
        public string ContrAcceso { get => contrAcceso; set => contrAcceso = value; }
        public string Foto1 { get => Foto; set => Foto = value; }
        public string Rfc1 { get => Rfc; set => Rfc = value; }
        public string Calle { get => calle; set => calle = value; }
        public string Numero { get => numero; set => numero = value; }
        public string Colonia { get => colonia; set => colonia = value; }
        public string Ciudad { get => ciudad; set => ciudad = value; }
        public string Municipio { get => municipio; set => municipio = value; }
        public string Estado { get => estado; set => estado = value; }
        public int CodigoPostal { get => codigoPostal; set => codigoPostal = value; }
        public string Telefono { get => telefono; set => telefono = value; }
        public string Celular { get => celular; set => celular = value; }
        public string Correo { get => correo; set => correo = value; }

        //3.variables de la clase que permiten trabajar con los datos
        public MySqlConnection cnn;
        public MySqlCommand cmd;
        public MySqlDataAdapter da;
        public MySqlDataReader dr;
        public DataSet ds;

        //constructor
        public clsUsuario()
        {
            clave = 0;
            nomUsuario = "";
            rol = "";
            usuario = "";
            contra = "";

            nombreUsu = "";
            ApeM = "";
            ApeP = "";
            UsuAcceso = "";
            contrAcceso = "";
            Foto = "";
            Rfc = "";
            calle = "";
            numero = "";
            colonia = "";
            ciudad = "";
            municipio = "";
            estado = "";
            codigoPostal = 0;
            telefono = "";
            celular = "";
            correo = "";
        }

        ~clsUsuario()
        {
            System.GC.Collect();
        }

        // =========================
        //  VALIDAR ACCESO
        // =========================
        public void validarAcceso(string cadConexion)
        {
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call tspValidarAcceso('" + Usuario + "','" + Contra + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                clave = int.Parse(dr.GetValue(0).ToString());
                if (clave != 0)
                {
                    nomUsuario = dr.GetValue(1).ToString();
                    rol = dr.GetValue(2).ToString();
                }
            }

            dr.Close();
            cnn.Close();
        }

        // =========================
        //  LISTAR USUARIOS
        // =========================
        public DataSet listarUsuarios(string con, int OP, int clave)
        {
            da = new MySqlDataAdapter("call tspListarUsuarios('" + OP + "','" + clave + "');", con);
            ds = new DataSet();
            da.Fill(ds, "usuarios");
            return ds;
        }

        // =========================
        //  BUSCAR USUARIO
        // =========================
        public void buscarUsuario(String cadConexion, int claveBuscada)
        {
            this.Clave = 0;

            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call tspMostrarUsuario('" + claveBuscada + "');";
            cmd.Connection = cnn;
            cnn.Open();
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                // Primero leemos la clave que viene de la BD
                int claveBD = 0;

                if (dr["USU_Clave"] != DBNull.Value)
                    claveBD = int.Parse(dr["USU_Clave"].ToString());

                // Si el SP regresó solo "0 AS USU_Clave" (ELSE del SP),
                // no intentamos leer Rol ni los demás campos
                if (claveBD == 0)
                {
                    this.Clave = 0;
                    dr.Close();
                    cnn.Close();
                    return;
                }

                // A partir de aquí SÍ es un usuario válido (THEN del SP)
                this.Clave = claveBD;

                // Aquí sí existe la columna "Rol" porque viene del THEN
                this.Rol = dr["Rol"].ToString();
                this.NomUsuario = dr["USU_Nombre"].ToString();

                this.ApeP1 = dr["USU_ApellidoPaterno"].ToString();
                this.ApeM1 = dr["USU_ApellidoMaterno"].ToString();

                this.UsuAcceso1 = dr["USU_Usuario"].ToString();
                this.ContrAcceso = dr["USU_Contraseña"].ToString();
                this.Foto1 = dr["USU_Foto"].ToString();

                this.Rfc1 = dr["USU_RFC"].ToString();
                this.Calle = dr["USU_Calle"].ToString();
                this.Numero = dr["USU_Numero"].ToString();
                this.Colonia = dr["USU_Colonia"].ToString();
                this.Ciudad = dr["USU_Ciudad"].ToString();
                this.Municipio = dr["USU_Municipio"].ToString();
                this.Estado = dr["USU_Estado"].ToString();

                this.CodigoPostal = int.Parse(dr["USU_CodigoPostal"].ToString());
                this.Telefono = dr["USU_TelefonoCasa"].ToString();
                this.Celular = dr["USU_Celular"].ToString();
                this.Correo = dr["USU_Correo"].ToString();
            }

            dr.Close();
            cnn.Close();
        }


        // =========================
        //  MODIFICAR USUARIO (CON ROL)
        // =========================
        public int modificarUsuario(
            string cadConexion,
            int clave,
            int rol,
            string nom,
            string aPat,
            string aMat,
            string email,
            string tel,
            string cel,
            string rfc,
            string calle,
            string numero,
            string col,
            int codigo,
            string ciudad,
            string muni,
            string estado,
            string foto,
            string contra)
        {
            int resultado = 0;
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();

            cmd.CommandText = "CALL tspModificarUsuario("
                + clave + ","
                + rol + ",'"
                + nom + "','"
                + aPat + "','"
                + aMat + "','"
                + contra + "','"
                + foto + "','"
                + rfc + "','"
                + calle + "','"
                + numero + "','"
                + col + "','"
                + ciudad + "','"
                + muni + "','"
                + estado + "',"
                + codigo + ",'"
                + tel + "','"
                + cel + "','"
                + email + "');";

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

        // =========================
        //  REGISTRAR USUARIO (CORREGIDO)
        // =========================
        public int RegistrarUsuario(
            string cadConexion, int rol, string nom, string aPat, string aMat,
            string usuario, string pas, string foto, string rfc, string calle,
            string numero, string col, string ciudad, string muni, string edo,
            int codigop, string tel, string cel, string correo)
        {
            int resultado = -1;

            using (MySqlConnection cnn = new MySqlConnection(cadConexion))
            {
                using (MySqlCommand cmd = new MySqlCommand("tspRegistrarUsuario", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("p_ROL_Clave", rol);
                    cmd.Parameters.AddWithValue("p_USU_Nombre", nom);
                    cmd.Parameters.AddWithValue("p_USU_ApellidoPaterno", aPat);
                    cmd.Parameters.AddWithValue("p_USU_ApellidoMaterno", aMat);
                    cmd.Parameters.AddWithValue("p_USU_Usuario", usuario);
                    cmd.Parameters.AddWithValue("p_USU_Contraseña", pas);
                    cmd.Parameters.AddWithValue("p_USU_Foto", foto);
                    cmd.Parameters.AddWithValue("p_USU_RFC", rfc);
                    cmd.Parameters.AddWithValue("p_USU_Calle", calle);
                    cmd.Parameters.AddWithValue("p_USU_Numero", numero);
                    cmd.Parameters.AddWithValue("p_USU_Colonia", col);
                    cmd.Parameters.AddWithValue("p_USU_Ciudad", ciudad);
                    cmd.Parameters.AddWithValue("p_USU_Municipio", muni);
                    cmd.Parameters.AddWithValue("p_USU_Estado", edo);
                    cmd.Parameters.AddWithValue("p_USU_CodigoPostal", codigop);
                    cmd.Parameters.AddWithValue("p_USU_TelefonoCasa", tel);
                    cmd.Parameters.AddWithValue("p_USU_Celular", cel);
                    cmd.Parameters.AddWithValue("p_USU_Correo", correo);

                    cnn.Open();

                    using (MySqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            // Lee el valor que regresa el SP: 1, 2 o 3
                            // SELECT 1 AS Resultado;  etc.
                            resultado = Convert.ToInt32(dr["Resultado"]);
                        }
                    }
                }
            }

            return resultado;
        }

        // =========================
        //  ELIMINAR USUARIO
        // =========================
        public int eliminarUsuario(string cadConexion, int clave)
        {
            int resultado = 0;
            cnn = new MySqlConnection();
            cnn.ConnectionString = cadConexion;
            cmd = new MySqlCommand();
            cmd.CommandText = "call tspEliminarUsuario('" + clave + "');";
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

        // =========================
        //  LISTAR ROLES
        // =========================
        public DataSet listarRoles(string con)
        {
            da = new MySqlDataAdapter("call tspListarRoles();", con);
            ds = new DataSet();
            da.Fill(ds, "roles");
            return ds;
        }
    }
}
