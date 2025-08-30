/**
 * Cómo acceder a sistemas de BBDD MySQL desde un programa en Java
 * <a href="https://emiliodevesa.wordpress.com/2012/11/16/tutorial-mysql/">Blog
 * post</a>
 *
 * @author Emilio Devesa (http://emiliodevesa.wordpress.com)
 * @version 0.1
 */
public class Libro {

    private final String isbn;
    private final String titulo;
    private final String autor;
    private final double precio;
    private final int stock;

    /**
     * Constructor que recibe los valores por parámetro
     *
     * @param i String con el codigo ISBN del libro
     * @param t String con el título del libro
     * @param a String con el autor del libro
     * @param p Double con el precio del libro
     * @param s int con el stock del libro
     */
    public Libro(String i, String t, String a, double p, int s) {
        isbn = i;
        titulo = t;
        autor = a;
        precio = p;
        stock = s;
    }

    /**
     * Devuelve el código ISBN del libro
     *
     * @return String con el código del libro
     */
    public String getIsbn() {
        return isbn;
    }

    /**
     * Devuelve el titulo del libro
     *
     * @return String con el título del libro
     */
    public String getTitulo() {
        return titulo;
    }

    /**
     * Devuelve el autor del libro
     *
     * @return String con el nombre del autor del libro
     */
    public String getAutor() {
        return autor;
    }

    /**
     * Devuelve el precio del libro
     *
     * @return double con el precio actual del libro
     */
    public double getPrecio() {
        return precio;
    }

    /**
     * Devuelve el stock actual
     *
     * @return int con el stock actual del libro
     */
    public int getStock() {
        return stock;
    }

    /**
     * Devuelve los datos del libro en un formato entendible por un humano
     *
     * @return String con los datos del libro actual
     */
    @Override
    public String toString() {
        return isbn + " || " + titulo + " || " + autor + " || " + precio + " || " + stock;
    }

}
