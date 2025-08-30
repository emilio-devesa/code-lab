import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Cómo acceder a sistemas de BBDD MySQL desde un programa en Java
 * <a href="https://emiliodevesa.wordpress.com/2012/11/16/tutorial-mysql/">Blog
 * post</a>
 *
 * @author Emilio Devesa (http://emiliodevesa.wordpress.com)
 * @version 0.1
 */
public class BDMgr {

    private static final String driver = "com.mysql.jdbc.Driver";
    private static final String dbhost = "localhost";
    private static final String dbport = "3306";
    private static final String dbname = "prueba";
    private static final String dbuser = "root";
    private static final String dbpass = "";
    private static Statement st;

    /**
     * Crea una conexión a la base de datos
     */
    public BDMgr() {
        String dbconnection = "jdbc:mysql://" + dbhost + ":" + dbport + "/" + dbname;
        try {
            Class.forName(driver);
            st = DriverManager.getConnection(dbconnection, dbuser, dbpass).createStatement();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(BDMgr.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Realiza una consulta a la BBDD y devuelve los resultados en una
     * estructura de datos
     *
     * @param q String con la consulta formulada
     * @return ResultSet Una estructura de datos iterable en donde se devuelve
     * el resultado de la consulta
     */
    private static ResultSet get(String q) {
        ResultSet rs = null;
        try {
            rs = st.executeQuery(q);
        } catch (SQLException ex) {
            Logger.getLogger(BDMgr.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    /**
     * Realiza una consulta que actualiza datos de la BBDD
     *
     * @param q String con la consulta formulada
     */
    private static void set(String q) {
        try {
            st.executeUpdate(q);
        } catch (SQLException ex) {
            Logger.getLogger(BDMgr.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Realiza una consulta que devuelve todos los libros de la BBDD
     *
     * @param q String con la consulta bien formulada
     * @return ArrayList<Libro> con todos los libros devueltos por la consulta
     */
    private ArrayList<Libro> getLibros(String q) {
        ArrayList<Libro> libros = new ArrayList();
        Libro unLibro;
        ResultSet rs = get(q);
        try {
            while (rs.next()) {
                unLibro = new Libro(rs.getString("isbn"), rs.getString("titulo"), rs.getString("autor"), rs.getDouble("precio"), rs.getInt("stock"));
                libros.add(unLibro);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BDMgr.class.getName()).log(Level.SEVERE, null, ex);
        }
        return libros;
    }

    /**
     * Obtener todos los libros de la BBDD
     *
     * @return ArrayList con todos los libros de la BBDD
     */
    public ArrayList<Libro> getLibros() {
        return getLibros("select * from libros;");
    }

    /**
     * Obtener todos los libros de la BBDD con un código ISBN dado
     *
     * @param isbn String con el código ISBN que identifica a cada libro
     * @return ArrayList con todos los libros devueltos por la consulta
     */
    public ArrayList<Libro> getLibrosConISBN(String isbn) {
        return getLibros("select * from libros where isbn=" + isbn + ";");
    }

    /**
     * Actualizar el stock al vender un libro
     *
     * @param l Libro vendido
     */
    public void venderLibro(Libro l) {
        int nuevoStock = l.getStock() - 1;
        String isbn = l.getIsbn();
        set("update libros set stock=" + nuevoStock + " where isbn=" + isbn + ";");
    }

}
