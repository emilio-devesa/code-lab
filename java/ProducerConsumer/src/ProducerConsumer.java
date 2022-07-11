/**
 * Una clase que modela un programa que debe producir y consumir información sin
 * caer en interbloqueos
 *
 * @author Emilio Devesa
 * @version 0.1
 */
public class ProducerConsumer {

    /**
     * Punto de entrada al código de ejecución del programa.
     *
     * @param args El String que representa los argumentos con los que el
     *             programa se puede lanzar desde consola
     */
    public static void main(String[] args) {
        InfoBuffer infoBuffer = new InfoBuffer();
        Producer producer = new Producer(infoBuffer);
        Consumer consumer = new Consumer(infoBuffer);
        new Thread(producer).start();
        new Thread(consumer).start();
    }

}

/**
 * Una clase que modela una espacio en memoria que actúa como buffer, donde
 * almacenamos un dato de tipo int que debe ser accedido de forma concurrente
 * por hilos que producen y consumen esta información
 *
 * @author Emilio Devesa
 * @version 0.1
 */
class InfoBuffer {

    // Variable de control que permite producir información (incialmente activada)
    private boolean isWritable = true;

    // Dato int que almacenaremos
    private int value;

    /**
     * Un método que almacena información en el buffer si la variable de control
     * permite la escritura. En caso contrario, la ejecución se mantiene a la
     * espera.
     *
     * @param _value El int que queremos almacenar
     */
    public synchronized void put(int _value) {
        while (!isWritable) {
            try {
                wait();
            } catch (InterruptedException ie) {
                System.out.println(ie.getLocalizedMessage());
            }
        }
        value = _value;
        isWritable = !isWritable;
        // Introducimos un pequeño tiempo de espera que haga más legible la salida por consola
        try {
            Thread.sleep(200);
        } catch (InterruptedException ie) {
            System.out.println(ie.getLocalizedMessage());
        }
        notify();
    }

    /**
     * Un método que recupera información del buffer si la variable de control
     * permite la lectura. En caso contrario, la ejecución se mantiene a la
     * espera.
     *
     * @return El int que habíamos almacenado
     */
    public synchronized int get() {
        while (isWritable) {
            try {
                wait();
            } catch (InterruptedException ie) {
                System.out.println(ie.getLocalizedMessage());
            }
        }
        isWritable = !isWritable;
        // Introducimos un pequeño tiempo de espera que haga más legible la salida por consola
        try {
            Thread.sleep(200);
        } catch (InterruptedException ie) {
            System.out.println(ie.getLocalizedMessage());
        }
        notify();
        return value;
    }

}

/**
 * Una clase que modela el hilo productor de información que almacenaremos
 *
 * @author Emilio Devesa
 * @version 0.1
 */
class Producer implements Runnable {

    private InfoBuffer infoBuffer = null;

    /**
     * Constructor que recibe por parámetro el buffer donde almacenaremos la
     * información producida
     *
     * @param _infoBuffer El buffer de información en el que escribir datos de
     *                    tipo int
     */
    public Producer(InfoBuffer _infoBuffer) {
        this.infoBuffer = _infoBuffer;
    }

    /**
     * Método de lanzamiento del hilo
     */
    public void run() {
        int valueToWrite = 0;
        for (int i = 0; i < 10; i++) {
            valueToWrite = 100 * i;
            this.infoBuffer.put(valueToWrite);
            System.out.println("Producer " + i + " writes: " + valueToWrite);
        }
    }

}

/**
 * Una clase que modela el hilo consumidor de información almacenada
 *
 * @author Emilio Devesa
 * @version 0.1
 */
class Consumer implements Runnable {

    private InfoBuffer infoBuffer = null;

    /**
     * Constructor que recibe por parámetro el buffer desde el que leeremos la
     * información a consumir
     *
     * @param _infoBuffer El buffer de información en el que leer datos de tipo
     *                    int
     */
    public Consumer(InfoBuffer _infoBuffer) {
        this.infoBuffer = _infoBuffer;
    }

    /**
     * Método de lanzamiento del hilo
     */
    public void run() {
        int readValue = 0;
        for (int i = 0; i < 10; i++) {
            readValue = infoBuffer.get();
            System.out.println("Consumer " + i + " reads: " + readValue);
        }
    }

}
