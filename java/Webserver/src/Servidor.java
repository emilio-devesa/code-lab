import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Un sencillo servidor web multihilo creado en java
 * <a href="https://emiliodevesa.wordpress.com/2013/06/05/un-servidor-web-sencillo-en-java/">Blog
 * post</a>
 *
 * @author Emilio Devesa (http://emiliodevesa.wordpress.com)
 * @version 0.1
 */
public class Servidor {

    static private final Integer PUERTO = 8000;
    static private final Integer TIMEOUT_CLIENTES = 30 * 1000; // segundos -> milisegundos

    /**
     * Punto de entrada al código de ejecución del programa.
     *
     * @param args El String que representa los argumentos con los que el
     *             programa se puede lanzar desde consola
     */
    public static void main(String[] args) {
        try {
            ServerSocket socketServidor = new ServerSocket(PUERTO);
            while (true) {
                Socket socketCliente = socketServidor.accept();
                HiloTrabajo hilo = new HiloTrabajo(socketCliente, TIMEOUT_CLIENTES);
                hilo.start();
            }
        } catch (IOException ex) {
            Logger.getLogger(Servidor.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Error: " + ex.getMessage());
            System.err.println();
        }
    }

}

/**
 * Una clase que modela el hilo con el que se procesa cada petición y su
 * correspondiente respuesta, así como el manejo de diferentes excepciones
 *
 * @author Emilio Devesa (http://emiliodevesa.wordpress.com)
 * @version 0.1
 */
class HiloTrabajo extends Thread {

    private final Socket socket;
    private final int timeout;
    BufferedReader input;
    DataOutputStream output;

    /**
     * Constructor de un hilo de proceso
     *
     * @param s Un objeto Socket que representa la conexión
     * @param t Un entero que representa el tiempo máximo de espera de una
     *          conexión al socket
     */
    public HiloTrabajo(Socket s, int t) {
        socket = s;
        timeout = t;
    }

    /**
     * Método que lanza la ejecución del hilo
     */
    @Override
    public void run() {
        try {
            socket.setSoTimeout(timeout);
            input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            output = new DataOutputStream(socket.getOutputStream());
            responder(input, output);
            input.close();
            output.close();
            socket.close();
        } catch (SocketTimeoutException ex) {
            Logger.getLogger(HiloTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Error: " + ex.getMessage());
            System.err.println("La conexión ha caducado (30 segundos sin recibir nada)");
            System.err.println();
        } catch (IOException ex) {
            Logger.getLogger(HiloTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Error: " + ex.getMessage());
            System.err.println();
        } finally {
            try {
                input.close();
                output.close();
                socket.close();
            } catch (IOException ex) {
                Logger.getLogger(HiloTrabajo.class.getName()).log(Level.SEVERE, null, ex);
                System.err.println("Error: " + ex.getMessage());
                System.err.println("No se puede cerrar la conexion.");
                System.err.println();
            }
        }
    }

    /**
     * Un método que prepara la respuesta que el servidor debe enviar al cliente
     *
     * @param input  Un stream en el que leer la petición del cliente
     * @param output Un stream en el que escribir la respuesta del servidor
     */
    private void responder(BufferedReader input, DataOutputStream output) {

        String peticion;
        int tipoPeticion = 0;
        /*
         * Tipo de peticion
         *
         * 0=No Aceptada 1=HEAD 2=GET
         *
         */

        String ruta;
        FileInputStream archivo;
        int tipoArchivo = 0;
        /*
         * Tipo MIME de archivo solicitado
         *
         * -1 = Error 0 = Desconocido 1 = .htm/.html 2 = .txt 3 = .gif 4 =
         * .jpg/.jpeg 5 = .zip
         *
         * Más información sobre MIME:
         * http://www.utoronto.ca/web/htmldocs/book/book-3ed/appb/mimetype.html
         * http://en.wikipedia.org/wiki/MIME
         *
         */

        try {
            // Recibimos las lineas de la peticion
            peticion = input.readLine(); // Ej: GET /index.html HTTP/1.1
            input.readLine(); // En blanco
        } catch (IOException ex) {
            Logger.getLogger(HiloTrabajo.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Error: " + ex.getMessage());
            System.err.println("No se pudo leer la peticion.");
            System.err.println();
            return; // No se debe seguir adelante
        }

        // Linea 1:
        // Comenzamos a distinguir el tipo de peticion. Si hubiese más tipos, se deben añadir a continuacion.
        String tmp = peticion.toUpperCase();
        if (tmp.startsWith("HEAD")) {
            tipoPeticion = 1;
        }
        if (tmp.startsWith("GET")) {
            tipoPeticion = 2;
        }
        // Si hubiese más tipos de peticiones, se añadirían aquí

        // En el caso de no reconocer el tipo de peticion, ya podemos enviar el error 501
        if (tipoPeticion == 0) {
            try {
                output.writeBytes(crearCabecera(501, -1));
                System.err.println("Se ha detectado un error 501");
                System.err.println();
            } catch (IOException ex) {
                Logger.getLogger(HiloTrabajo.class.getName()).log(Level.SEVERE, null, ex);
                System.err.println("Error: " + ex.getMessage());
                System.err.println("No se pudo enviar el mensaje de error 501");
                System.err.println();
            }
        } else {
            // Como la peticion no se ha rechazado, continuamos:
            // Linea 2: Etraemos la ruta del archivo solicitado
            int ini = 0, fin = 0;
            for (int pos = 0; pos < peticion.length(); pos++) {
                // Buscamos el ultimo espacio en blanco en la linea
                if (peticion.charAt(pos) == ' ' && ini != 0) {
                    fin = pos;
                    break;
                }
                // Buscamos el primer espacio en blanco en la linea
                if (peticion.charAt(pos) == ' ' && ini == 0) {
                    ini = pos;
                }
            }
            ruta = peticion.substring(ini + 1, fin);

            // Preparamos la escritura del fichero en el output
            try {
                archivo = new FileInputStream(ruta);
            } catch (FileNotFoundException ex) {
                // Si el fichero no existe, enviamos un error 404
                Logger.getLogger(HiloTrabajo.class.getName()).log(Level.SEVERE, null, ex);
                System.err.println("Error: " + ex.getMessage());
                System.err.println("Se ha detectado un error 404");
                System.err.println();
                try {
                    output.writeBytes(crearCabecera(404, -1));
                } catch (IOException ex2) {
                    // Quizás no ha sido posible enviar el error
                    Logger.getLogger(HiloTrabajo.class.getName()).log(Level.SEVERE, null, ex2);
                    System.err.println("Error: " + ex2.getMessage());
                    System.err.println("No se pudo enviar el mensaje de error 404");
                    System.err.println();
                }
                return; // No se debe seguir adelante
            }

            ruta = ruta.toLowerCase();
            if (ruta.endsWith(".htm") || ruta.endsWith(".html")) {
                tipoArchivo = 1;
            }
            if (ruta.endsWith(".txt")) {
                tipoArchivo = 2;
            }
            if (ruta.endsWith(".gif")) {
                tipoArchivo = 3;
            }
            if (ruta.endsWith(".jpg") || ruta.endsWith(".jpeg")) {
                tipoArchivo = 4;
            }
            if (ruta.endsWith(".zip")) {
                tipoArchivo = 5;
            }

            // Enviamos la cabecera
            try {
                output.writeBytes(crearCabecera(200, tipoArchivo));
            } catch (IOException ex) {
                // Quizás no ha sido posible enviar la cabecera
                Logger.getLogger(HiloTrabajo.class.getName()).log(Level.SEVERE, null, ex);
                System.err.println("Error: " + ex.getMessage());
                System.err.println("No se pudo enviar la cabecera de la respuesta correctamente");
                System.err.println();
                return; // No se debe seguir adelante
            }

            // Y si la peticion es GET, el contenido tambien
            if (tipoPeticion == 2) {
                try {
                    while (true) {
                        int b = archivo.read();
                        // Si llegamos al final del fichero, paramos el bucle
                        if (b == -1) {
                            break;
                        }
                        output.write(b);
                    }
                    archivo.close();
                } catch (IOException ex) {
                    // Quizás no ha sido posible enviar el contenido
                    Logger.getLogger(HiloTrabajo.class.getName()).log(Level.SEVERE, null, ex);
                    System.err.println("Error: " + ex.getMessage());
                    System.err.println("No se pudo enviar el contenido de la respuesta correctamente");
                    System.err.println();
                }
            }
        }
    }

    /**
     * Un método que crea la cabecera de la respuesta del servidor
     *
     * @param codigoRepuesta Un entero que es el código de respuesta
     * @param tipoArchivo    Un entero que representa el tipo de archivo que
     *                       enviaremos
     * @return Un String con la cabecera de la respuesta que enviaremos
     */
    private String crearCabecera(int codigoRepuesta, int tipoArchivo) {
        String s = "HTTP1.0 ";

        /*
         * Verificamos el codigo
         *
         * 200:OK 404:No Encontrado 501:No implementado
         *
         */
        switch (codigoRepuesta) {
            case 200 -> s = s + "200 OK";
            case 404 -> s = s + "404 Not Found";
            case 501 -> s = s + "501 Not Implemented";
        }
        s = s + "\r\n";
        s = s + "Connection: close\r\n";
        s = s + "Server: com.emiliodevesa.webserver (https://emiliodevesa.wordpress.com)\r\n";

        switch (tipoArchivo) {
            // El caso -1 no devuelve nada porque lo reservamos para errores
            case -1:
                break;
            // MIME conocidos
            case 1:
                s = s + "Content-Type: text/html\r\n";
                break;
            case 2:
                s = s + "Content-Type: text/plain\r\n";
                break;
            case 3:
                s = s + "Content-Type: image/gif\r\n";
                break;
            case 4:
                s = s + "Content-Type: text/jpeg\r\n";
                break;
            case 5:
                s = s + "Content-Type: application/zip\r\n";
                break;
            // En casos de formatos desconocidos... (es decir, el caso 0)
            case 0:
            default:
                s = s + "Content-Type: application/octet-stream\r\n";
                break;
        }
        s = s + "\r\n";
        return s;
    }

}
