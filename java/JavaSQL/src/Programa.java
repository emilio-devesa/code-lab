import java.util.ArrayList;

/**
 *
 * @author Emilio Devesa
 * @version 0.1
 */
public class Programa {

    public static void main(String[] args) {
        BDMgr bdm = new BDMgr();
        ArrayList<Libro> libros;
        System.out.println();

        System.out.println("Mostrar todos los libros");
        libros = bdm.getLibros();
        for (Libro l : libros) {
            System.out.println(l.toString());
        }
        System.out.println();

        System.out.println("Mostrar un libro con ISBN 9788441529373");
        libros = bdm.getLibrosConISBN("9788441529373");
        for (Libro l : libros) {
            System.out.println(l.toString());
        }
        System.out.println();

        System.out.println("Vender ese libro");
        libros = bdm.getLibrosConISBN("9788441529373");
        for (Libro l : libros) {
            bdm.venderLibro(l);
        }
        System.out.println();

        System.out.println("Mostrar todos los libros");
        libros = bdm.getLibros();
        for (Libro l : libros) {
            System.out.println(l.toString());
        }
        System.out.println();
    }

}
