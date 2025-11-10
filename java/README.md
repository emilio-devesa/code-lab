# Java

Para poner en contexto el enfoque orientado a "objetos", probablemente lo más interesante sea entender qué son eso de los objetos y para qué se usan; y lo cierto es que la explicación es mucho más sencilla de lo que uno se espera. Pensemos por un momento en un lápiz. Las acciones que se pueden realizar con él serán: escribir, parar, afilar, borrar. En la programación orientada a objetos, **estas acciones serán los métodos** y **se aglutinarán bajo su marco común: la clase lapiz.** ¿Quiere esto decir que nuestro programa dispone de un lapiz? Aún no. Habrá que crear una **instancia (objeto) de la clase lápiz.** En un símil con el ya conocido Pascal, podemos entender que: 
```
Clases = Tipos de dato abstractos (TADs)
Objetos (instancias) = Variables
Métodos = Funciones y procedimientos caracteristicos de una clase
```

Además, la programación orientada a objetos conlleva dos características:  
- Herencia: Si de una clase genérica creamos una clase hija (por ejemplo, de la clase Lista creamos una clase hija llamada ListaOrdenada), ésta hereda las propiedades de aquella.
- Polimorfismo: Una subclase puede actuar como superclase (es decir, puede haber objetos de la clase ListaOrdenada) pero además hereda caracteristicas de las clases superiores que haya (por el principio de herencia). Por lo tanto, llego a que un objeto que sea de la clase ListaOrdenada, tambien será compatible con los objetos de la clase Lista.

**Mecánica Bottom-Up**  
En la programación tradicional, un programa se piensa en su totalidad y luego se descienden niveles de abstracción para programar las partes que lo componen por separado, centrándonos en una de ellas, volviendo a una visión general, bajando de nuevo a desarrollar otra... Esto se conoce como la metodología "_Top-down_" (típica metodología de programación imperativa). La metodología "_bottom-up_" sin embargo construye el programa desde la base hacia un panorama general, siguiendo estos pasos: 
1. Identificar las estructuras de datos del programa y las interacciones de los datos
2. Crear las funciones que producen las salidas adecuadas
3. El programa queda compuesto por una serie de objetos con un estado interno propio y que interactúan intercambiando mensajes. Hay más información sobre esto en la Wikipedia: http://es.wikipedia.org/wiki/Top-down_y_Bottom-up

Me gustaría recomendaros a todos el siguiente libro, que me está siendo de gran ayuda:  
_Introducción a la programación con JAVA Un enfoque orientado a objetos  
David Arnow y Gerald Weiss Adison Wesley, Pearson Educación  
ISBN: 978 84 7829 033 8_


**JDK**  
Se puede descargar el kit de desarrollo desde https://www.oracle.com/es/java/technologies/downloads/  
Yo emplearé la versión comprimida en formato tar.gz y se instala mediante esta serie de comandos:

```
$ tar xzvf Descargas/jdk-22_linux-x64_bin.tar.gz
$ mv jdk-22.0.1/ /home/user/jdk
```

Esto colocará todos los archivos en un directorio llamado "jdk" dentro de mi carpeta personal. Ahora debo agregar esa ruta a la variable PATH para que el sistema pueda encontrar los ejecutables automáticamente:

```
$ nano .bashrc 
```

Al final de este fichero debes incluir las siguientes líneas:

```
# PATH DE JAVA AGREGADA MANUALMENTE
export JAVA_HOME=$HOME/jdk
export PATH=$JAVA_HOME/bin:$PATH
```

Y tras guardarlo, puedes recargar las rutas rápidamente y comprobar la instalación con:

```
$ source .bashrc 
$ which java
$ java --version
$ which javac
$ javac --version
```

Que deberán responderte la ruta y las versiones correspondientes a la máquina de Java y al compilador.


**Primeros pasos**  
Un primer programa que podemos escribir es un típico HolaMundo para comprobar que todo está bien. El archivo contiene:
```
class HolaMundo {
    public static void main (String[] args){
        System.out.println("Hola Mundo");
    }
}
```

Este archivo debe llamarse como la clase que contiene y con extension .java: **HolaMundo.java**. Aunque tambien cabe resaltar que no es programacion orientada a objetos estrictamente. Lo compilamos con la orden habitual:  
```
$ javac HolaMundo.java
```
Se genera el archivo .class correspondiente y lo ejecutamos con nuestra máquina de java sin escribir la extensión: 
```
$ java HolaMundo
```
Esto mostrará el mensaje "Hola Mundo" en consola. Podemos hacer una versión propiamente orientada a objetos asi:
```
class HolaMundoOO {
    public static void imprimeHola (){
        System.out.println("Hola Mundo");
    }
}

public class HolaMundo {
    public static void main (String[] args){
        // Creamos un objeto miHola
        HolaMundoOO miHola = new HolaMundoOO;
        // Invocamos el metodo imprimeHola
        miHola.imprimeHola();
    }
}
```
De esta forma tenemos una clase **HolaMundoOO** que es la que proporciona un método "**imprimeHola**" que actúa sobre un objeto HolaMundoOO imprimiendo un mensaje "**Hola Mundo**", mientras que en la clase pública **HolaMundo**, el método "**main**" convoca a crea un objeto de esa clase y convoca ese método para el objeto "**miHola**".

Por cierto, los comentarios de código en Java comienzan con:
- **//** para comentarios de una línea.
- **/\*** para comentarios de varias líneas que se cierran al terminar con **\*/**

Lo interesante no será tanto la sintaxis del lenguaje (similar a la de C, por ejemplo) sino la forma de afrontar los proyectos pensando en la orientación a objetos. 

**Sentencias básicas**  
Basicamente una sentencia en Java tiene que cumplir la condición de concluir con un punto y coma. Un ejemplo habitual puede ser usar un método para mostrar en pantalla:
```
System.out.println ("Hola mundo");
```

**Selectores:**  
El condicional _if_ está practicamente presente en cualquier lenguaje de programación. En java sigue una estructura muy simple:
```
if (--condicion--) {
    sentencias si TRUE;
} else {
    sentencias si FALSE;
}
```

Por otro lado tenemos el selector _switch_ que equivale a un viejo conocido como es "case". En este caso requiere de un poco más de escritura:
```
switch (--variable a evaluar--) {
    case --estadoA--: sentenciaA; break;   
    case --estadoB--: sentenciaB; break;
    default: sentenciaDefault; break;
}
```
En este caso, lo importante es poner la variable a evaluar entre paréntesis, usar el "break" para separar los casos y terminar con un caso "default" (en Pascal, otherwise) que será el que se ejecute si la variable no satisface ningún estado anterior. Es bastante simple, aunque es cierto que se parece menos a su homónimo en Pascal.

**Iteradores:**  
En Java, los principales bucles se construyen con _while_ y el _for_, siendo _for_ un poco más flexible (y también menos seguro, por lo tanto) que en Pascal.

Para _while_ supondremos que antes se ha declarado una variable contador inicializada a cero:
```
int contador = 0;
while (contador < 10) {
    SentenciasRepetidas;
    contador++;
}
``` 
Conviene tener en cuenta que hay que avanzar el contador manualmente.

Existe una versión de este bucle muy similar al _repeat_ en la que la condición es comprobada tras ejecutar el código, pero sigue siendo un bucle _while_ formulado de otra manera. Sirve para asegurarse de que el código se ejecuta siempre a menos 1 vez y se usa la palabra _do_:
```
do {
    SentenciasRepetidas;
    contador++;
} while (contador < 10);
```

_for_ funciona de la siguiente manera:
```
for (int contador = 0; contador < 10; contador++) {
    SentenciasRepetidas;
}
```
En este caso no es necesario tener una variable "cont" previamente. La declaramos con el bucle, y solo tendrá sentido (y existirá) mientras se esté ejecutando el bucle; en este caso tiene valor inicial cero. Por supuesto tenemos que establecer el valor de parada, en este caso 10; y el tipo de avance, en este caso avanzando de 1 en 1.

Podemos hacer un "For" regresivo, que comience en 10 y descienda a 0 simplemente cambiando un par de detalles:
```
for (int contador = 10; contador > 0; contador--) {
    SentenciasRepetidas;
}
```
Solo debemos fijarnos en que en este caso el contador debe ser disminuido en 1 en cada paso.


**Recuperar parámetros al invocar el programa**  
Supongamos que desde la terminal quiero invocar a un programa que calcule el producto de dos números directamente escritos junto al nombre del programa, por ejemplo:
```
$ java Multiplicar 20 12
```
Lo interesante sería crear un programa que recuperase esos dos números y escribiese en pantalla su producto. Primero creamos la estructura básica del programa:
```
class Multiplicar {
    public static void main (String[] args){
    }
}
```
Donde es obvio que habrá que multiplicar unos números enteros x e y: 
```
class Multiplicar {
    public static void main (String[] args){
        System.out.println (x*y);
    }
}
```
Fijémonos por un momento en la firma del método main. La parte `(String[] args)` es la referida a recuperar el array de strings argumento de este método. El array de strings es lo que sigue al nombre del programa cuando lo invocamos (pudiendo ser uno o varios strings) asi que tan solo debemos establecer nuestros enteros x e y de acuerdo con sus posiciones en la linea de comandos.
```
class Multiplicar {
    public static void main (String[] args){
        int x = args[0];
        int y = args[1];
        System.out.println (x*y);
    }
}
```
Como vemos, el valor de x será el del primer numero que hayamos escrito y el de y, el segundo (recordemos que la numeración en los arrays empieza en cero). Sin embargo hay un pequeño problema a la hora de compilar, y es que los argumentos que sean numeros enteros (y en general, tipos de datos primitivos) deben ser envueltos. En nuestro caso, envolveremos los "int" en "Integer" con el método "parseInt":
```
class Multiplicar {
    public static void main (String[] args){
        Integer x = Integer.parseInt(args[0]);
        Integer y = Integer.parseInt(args[1]);
        System.out.println (x*y);
    }
}
```
Compilamos con:
```
$ javac Multiplicar.java
```
Y ejecutamos, por ejemplo para multiplicar 20 por 12, con:
```
$ java Multiplicar 20 12
```
Si no ponemos parámetros, el programa arrojará un error en tiempo de ejecución. Tratar los parámetros cómo un array de strings (donde cada string es un parámetro) no es algo único de Java. En C ocurre algo muy similar, prácticamente idéntico.

Un ejemplo más o menos similar que lee un nombre y muestra un saludo:
```
public class LeeNombreArgumento{
    public static void main (String[] args){
        String nombre = args[0];
        System.out.println ("Hola "+nombre);
    }
}
```

**Leer datos durante la ejecución del programa**  
Esta es la entrada de datos más común que podemos encontrar, y su realización es un poco más laboriosa de lo que uno se espera de un lenguaje de alto nivel como Java. En primer lugar, debemos entender que Java trata la entrada de datos como un flujo contenido en "System.in". Para capturar este flujo, podemos utilizar un objeto "Scanner" que convierta el flujo de datos en un flujo de caracteres. En una línea, todo esto queda:

```
Scanner input = new Scanner(System.in);
```
Ahora, siempre que queramos leer un dato, importaremos la clase _Scanner_ desde el paquete _java.util_ y utilizaremos el objeto _input_, con lo cual, un programa que quiera mostrar un saludo será algo como lo siguiente:

```
import java.util.Scanner;

public class Saluda{
    public static void main (String [] args){
        Scanner input = new Scanner(System.in);
        System.out.print("Nombre: ");
        String nombre = input.nextLine();
        System.out.println("Hola " + nombre);
        input.close();
    }
}
```
Por último, es necesario cerrar el flujo del objeto _input_ antes de terminar la ejecución.

**Sobrecarga**  
Imaginemos una clase "Monedero" que modele un monedero que contiene un saldo. Cuando creamos un monedero, puede que se cree vacío o con una cantidad determinada que nosotros le pasemos:
```
// Clase que modela un monedero
class Monedero {
    // Atributos
    private int saldo = 0;

    // Constructores

    // Asigna un saldo inicial al monedero
    public Monedero (int x){
        this.saldo = x;
    }

    // Asigna el saldo inicial por defecto
    public Monedero (){}

}
```

Cuando invoquemos al constructor de monedero tendremos dos posibilidades, invocarlo con o sin parámetro, y automáticamente el lenguaje se encargará de utilizar un método u otro según corresponda. En definitiva: 
```
Monedero miMonedero = new Monedero (1000);
```
Creará el objeto miMonedero que contendrá un valor de 1000.
```
Monedero tuMonedero = new Monedero ();
```
Creará un segundo objeto, tuMonedero, y este utilizará el valor por defecto, que por defecto es 0 (que es como se inicializó el atributo `saldo` de la clase).

La conclusión es que:
_La sobrecarga permite dar nombres iguales a métodos que reciben distintos parámetros y que, aplicados a un mismo objeto, producirían efectos diferentes. El método a usar se decide automáticamente según el número de parámetros con el que se invoque._

**Polimorfismo**  
Entonces... ¿Que es eso del polimorfismo? En la sobrecarga un método u otro se invocaba atendiendo a sus parámetros, lo que resultaba en un "polimorfismo aparente", ya que no era totalmente automática la decisión de que método usar. El programador debía llamarlo con el número correcto de parámetros para el método que quisiese usar. Cuando queríamos crear un monedero con un saldo inicial, llamábamos al constructor pasándole el parámetro del saldo; y no indicábamos ningún parámetro para referirnos al otro constructor. Así el lenguaje sabía a qué nos referíamos a pesar de que se llamasen igual.

El "polimorfismo puro" va un paso más allá. Se pretende que en diferentes clases pueda haber métodos con el mismo nombre y parámetros y que se decida, según el objeto sobre el que se invoque el método, si utilizar uno u otro. Si tenemos una clase Persona y una clase Perro, puede ser útil un método "mostrarDatos". En más detalle:
```
public void mostrarDatos (){
    // cuerpo del método
}
```

¿Como podríamos diferenciar un método de otro? Deben aplicarse a objetos de distinta clase e incluso están implementados de forma diferente:
```
// Clase que modela una persona
class Persona {
    // Atributos
    private String nombre = "";
    private int edad = 0;

    ...

    // Métodos
    public void mostrarDatos (){
        System.out.println ("Nombre: "+this.nombre);
        System.out.println ("Edad: "+this.edad);
    }
}
```

Y...

```
// Clase que modela un perro
class Perro {
    // Atributos
    private String nombre = "";
    private String raza = "";

    ...

    // Métodos
    public void mostrarDatos (){
        System.out.println ("Nombre: "+this.nombre);
        System.out.println ("Raza: "+this.raza);
    }
}
```

En este caso, el polimorfismo puro decidirá, según de qué objeto se trate, qué método emplear. Incluso aunque no sea conocido de antemano. Por ejemplo, ambas clases pueden ser subclases de "Mamifero". Si un usuario nos reclama mostrar los datos de un objeto de clase "Mamífero", se comprobará a qué subtipo pertenece para tomar un método u otro, por ejemplo en el codigo siguiente (el método estático "preguntarMamifero" devuelve un objeto de una subclase de "Mamifero"):

```
Mamifero m = Mamifero.preguntarMamifero();
m.mostrarDatos();
```

Podemos concluir que realmente:
_El polimorfismo (o polimorfismo puro), es la capacidad del lenguaje de decidir de forma dinámica a qué método recurrir si hay varios con igual cabecera, no atendiendo a sus parámetros sino al objeto sobre el que es invocado; pudiendo dar una implementación diferente para cada clase de objetos de forma transparente al resto del programa._

**Identidad e Igualdad**  
En cualquier lenguaje que permita manejar punteros vamos a necesitar distinguir la diferencia entre Identidad e Igualdad.
Si lo piensas, se pueden dar las siguientes situaciones:

1. Si las variables a y b apuntan al mismo objeto cualquier cambio que hiciese a través de un identificador lo podría ver también a través del otro. Es decir, que son objetos **identicos** (la comparación con `==` y con `equals()` sería `TRUE`)
2. Si a y b apuntan a dos objetos distintos que contienen lo mismo entonces son **iguales** (la comparación con `==` sería `FALSE` pero la operación `equals()` sería `TRUE`)
3. Si a y b apuntan a dos objetos distintos que contienen cosas distintas entonces obviamente ni son idénticos ni iguales y ambas comparaciones serían `FALSE`.


**Las clases inmutables**  
En Java se pueden definir clases de objetos como inmutables. Es decir, objetos sobre los que no se pueden realizar cambios; y que si necesitamos alterar, generaran un objeto nuevo que refleje sus nuevos atributos. Por ejemplo, si yo tengo el `String a` que contiene la palabra "hola" y quiero añadir una exclamación al final, puedo hacer: `a + "!";` Pero esto me devuelve un objeto diferente, por lo que la forma correcta es: `String b = a + "!"`
Sin embargo, como ya sabemos que String es inmutable, el lenguaje es suficientemente inteligente como para que el operador `\==` compare el contenido, por lo que arroja siempre el mismo resultado que `equals()`.
