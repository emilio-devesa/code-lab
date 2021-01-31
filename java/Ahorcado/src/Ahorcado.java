import java.util.InputMismatchException;
import java.util.Scanner;
import java.util.Random;

/**
 * Sencilla implementación del juego del ahorcado en Java.
 * <a href="https://emiliodevesa.wordpress.com/2021/01/31/java-el-ahorcado/">Blog
 * post</a>
 *
 * @author Emilio Devesa (http://emiliodevesa.wordpress.com)
 * @version 0.1
 */
public class Ahorcado {

    /**
     * Vector de palabras secretas disponibles para jugar
     */
    public static final String[] vPalabrasSecretas
            = {"cámara", "teclado", "monitor", "mesa", "pizarra", "profesor", "proyector", "abrigo", "teléfono", "terminal",
                "pantalla", "ratón", "ordenador", "silla", "encerado", "alumno", "aula", "mochila", "invitado", "editor"};
    /**
     * Vector de índices de palabra con las que ya hemos jugado para evitar
     * repeticiones
     */
    public static boolean[] vIndices = new boolean[vPalabrasSecretas.length];

    /**
     * Máximo de intentos fallidos permitidos en cada partida
     */
    public static final int maxIntentos = 5;

    /**
     * Contadores de partidas
     */
    public static int victorias = 0, derrotas = 0;

    /**
     * Devuelve una palabra aleatoria del vector de palabras secretas con la que
     * aun no se haya jugado
     *
     * @return Un string con una palabra
     */
    public static String nuevaPalabra() {
        if ((victorias + derrotas) % vPalabrasSecretas.length == 0) {
            for (int i = 0; i < vPalabrasSecretas.length; i++) {
                vIndices[i] = false;
            }
        }
        int i = 0;
        do {
            i = new Random().nextInt(vPalabrasSecretas.length);
        } while (vIndices[i] == true);
        vIndices[i] = true;
        return vPalabrasSecretas[i];
    }

    /**
     * Lee un caracter por teclado, comprueba que es una letra y la devuelve en
     * minúscula
     *
     * @return Un char que contiene una letra minúscula
     * @param in Un objeto de la clase Scanner para leer la entrada de teclado
     */
    public static char leerLetra(Scanner in) {
        char l = ' ';
        do {
            try {
                System.out.print("Introduzca una letra: ");
                l = in.nextLine().toLowerCase().charAt(0);
            } catch (InputMismatchException ime) {
                System.out.println("Opción no válida. \n");
            }
        } while (!Character.isLetter(l));
        System.out.println();
        return l;
    }

    /**
     * Muestra el estado actual del juego sustituyendo las letras ocultas por
     * '_'
     *
     * @param palabra La palabra con la que estamos jugando
     * @param fallos Los fallos cometidos
     */
    public static void mostrarEstadoPartida(char[] palabra, char[] fallos) {
        System.out.print("Palabra: \t");
        for (int i = 0; i < palabra.length; i++) {
            if ((int) palabra[i] == 0) {
                System.out.print("_ ");
            } else {
                System.out.print(palabra[i] + " ");
            }
        }
        System.out.print("\nFallos: \t");
        for (int i = 0; i < fallos.length; i++) {
            if ((int) fallos[i] == 0) {
                System.out.print("_ ");
            } else {
                System.out.print(fallos[i] + " ");
            }
        }
        System.out.println();
    }

    /**
     * La partida devuelve TRUE si el jugador ha obtenido una victoria, FALSE si
     * ha sido derrotado
     *
     * @return TRUE en caso de victoria, FALSE en caso de derrota
     * @param in Un objeto de la clase Scanner para leer la entrada de teclado
     */
    public static boolean partida(Scanner in) {
        final String palabraSecreta = nuevaPalabra();         // La palabra que hay que adivinar
        char[] vPalabra = new char[palabraSecreta.length()]; // Las palabra que se muestra al jugador
        char[] vLetras = new char[maxIntentos];               // Las letras que ya se han introducido
        int fallos = 0;
        char letra;
        boolean fin = false, letraCorrecta;
        // Bucle de jugadas
        do {
            letraCorrecta = false;
            mostrarEstadoPartida(vPalabra, vLetras);
            System.out.println("Intentos restantes: " + (maxIntentos - fallos));
            letra = leerLetra(in);
            for (int i = 0; i < palabraSecreta.length(); i++) {
                // Si la palabra secreta contiene la letra y no ha sido revelada antes, se revela
                // Si no, se asume como un fallo
                if (palabraSecreta.charAt(i) == letra && vPalabra[i] != letra) {
                    vPalabra[i] = letra;  // La hacemos visible
                    letraCorrecta = true; // Y cuenta como acierto
                }
            }
            if (letraCorrecta) {
                // Comprobamos si hemos acabado 
                fin = palabraSecreta.equals(String.copyValueOf(vPalabra));
            } else {
                vLetras[fallos] = letra;
                fallos++;
            }
        } while (!fin && fallos < maxIntentos);
        mostrarEstadoPartida(vPalabra, vLetras);
        if (fin) {
            System.out.println("VICTORIA!");
        } else {
            System.out.println("DERROTA!");
        }
        System.out.println(" La palabra secreta era: " + palabraSecreta + "\n");
        return fin;
    }

    /**
     * Punto de entrada del programa
     *
     * @param args Argumentos introducidos en la consola al invocar el programa
     */
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int opcion = 0;
        do {
            System.out.println("MENU");
            System.out.println("1. Jugar partida");
            System.out.println("2. Ver estadísticas");
            System.out.println("0. Salir");
            try {
                System.out.print("Seleccionar opcion (1-2) o 0 para salir: ");
                opcion = input.nextInt();
            } catch (InputMismatchException ime) {
                opcion = 100;
            }
            input.nextLine();
            switch (opcion) {
                case 1:
                    if (partida(input)) {							// TRUE si victoria 
                        victorias++;
                    } else {
                        derrotas++;
                    }
                    break;
                case 2:
                    System.out.println("Victorias: " + victorias);
                    System.out.println("Derrotas: " + derrotas + "\n");
                    break;
                case 0:
                    System.out.println("Fin de programa \n");
                    break;
                default:
                    System.out.println("Opción no válida \n");
                    break;
            }
        } while (opcion != 0);
        input.close();
    }

}
