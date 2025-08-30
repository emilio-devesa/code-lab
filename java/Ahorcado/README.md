## Ahorcado

Implementación en Java del juego del ahorcado:

_Queremos desarrollar un programa que ejecute el juego del ahorcado. En cada partida presenta la palabra secreta escrita con "\_" y se van revelando las letras que el usuario acierta. Se permite cometer hasta 5 fallos como máximo. Las letras que no formen parte de la palabra secreta cuentan como fallos; y si se introduce una letra correcta que ya había sido revelada con anterioridad, también. La partida solo termina si el usuario acierta la palabra o si se han cometido el número máximo de fallos._ 

Además, he introducido tres elementos extra: 
- Un menú con tres opciones: jugar partida, ver estadísticas y salir. El programa se ejecuta hasta que el usuario selecciona la última opción. 
- Las estadísticas de partidas ganadas y partidas perdidas. 
- El programa cuenta con un conjunto de palabras para jugar. Se escogerán de forma aleatoria pero tratando de evitar que se produzcan repeticiones en la medida de lo posible. 
Vamos allá!

**El programa principal**  
Vamos a empezar creando la clase Ahorcado y dos variables que serán el numero de victorias y el de derrotas. En el método main() es donde creo el bucle que muestra el menú, lee la opción que introduce el usuario y la ejecuta. Para leer texto por teclado estoy empleando la clase Scanner, que pertenece al paquete java.util y que he importado al principio. Es muy cómodo hacerlo de esta manera porque me devuelve el primer número entero que el usuario teclea. Hay la posibilidad de que el usuario introduzca algo que no sea un número, por lo que debo encerrar la lectura de la variable opción entre try-catch. No es mi forma favorita de manejar excepciones pero es un caso muy sencillo y se puede hacer aquí directamente. La excepción que debemos controlar es que los tipos no coincidan, o lo que es lo mismo, InputMismatchException, que también pertenece al paquete java.util y debo importar al principio. Si el try-catch no detecta ninguna excepción, se lee el número que introduce el usuario. Si la detecta pone un número cualquiera, en mi caso el 100. Es importante que una vez leída la opción (o controlada la excepción), vaciemos el resto del buffer de entrada, simplemente leyendo hasta el final de línea con el método input.nextLine();. 

![](images/main-2-e1612094415514.png) 

En la sentencia switch(opcion) es donde esa opción se transforma en realidad. Si el usuario ha introducido el número 1, arrancará el método partida(). Debo pasarle el objeto input de la clase Scanner para poder leer las letras que vaya introduciendo, y esperaré a que el método retorne FALSE si el usuario ha perdido o TRUE si ha adivinado la palabra. Dependiendo de ese valor, aumento un contador u otro. La opción 2 simplemente muestra el valor de éstos y la 0 anuncia el final del programa. La opción default informa de que la opción introducida no es válida. Se llega a este punto tanto si el usuario mete un número incorrecto (p. ej el 5) o cualquier carácter que provoque la excepción que controlaba el try-catch, ya que la variable opción valdría 100. Por último, cuando el programa termina, invocamos input.close() para cerrar el buffer de entrada.

**Las palabras**  
Durante las partidas vamos a necesitar unas cuantas palabras con las que jugar. Yo he decidido almacenar unas cuantas en un array de Strings al que llamo vPalabrasSecretas. La variable maxIntentos, marcada como final para evitar que se cambie accidentalmente durante el juego, establece el numero máximo de intentos fallidos que tiene un jugador para adivinar la palabra secreta. Si se quiere hacer más fácil el juego, se aumenta este número y listo, no es preciso ningún otro cambio.

![](images/attr-3-e1612104410186.png) 

También tengo otro array de índices para controlar la repetición de las palabras. La idea es muy sencilla: el tamaño de vIndices es el mismo que el de Strings; si ya he jugado con una palabra, el valor del índice correlativo lo marco como TRUE. Si un índice tiene valor FALSE entonces es que la palabra correlativa en vPalabrasSecretas aun no ha sido seleccionada para jugar. Por ejemplo: Si juego con la palabra vPalabrasSecretas\[0\] ("cámara"), pongo TRUE en vIndices\[0\]. Si después, juego con la palabra "terminal" (que está en la posición 9), pongo vIndices\[9\] a TRUE. ¿Podría esto resolverse con un único array bidimensional? Sí, perfectamente; pero lo he hecho así para no enrevesarlo mucho. Si se quiere apostar por esa solución, no se requieren grandes cambios.

Con esto definido, voy a crear un método que devuelva una palabra secreta nueva y si es posible con la que no se haya jugado hasta el momento. La forma de hacerlo es calcular el módulo de partidas ya jugadas entre el número de palabras disponibles para jugar. Cuando el juego empieza (0 % vPalabrasSecretas.length = 0) o cuando ya se ha jugado con todas, pondremos todos los valores de vPalabrasJugadas a FALSE. Después, se pide un numero entero aleatorio (Random().nextInt()) que va de 0 hasta el número de palabras que hay en el vector. Esto se repite todas las veces que sea necesario mientras el índice correspondiente sea TRUE (es decir, mientras las palabras en ese índice ya hayan salido) hasta que encuentre un índice que vale FALSE (una palabra con la que aún no se ha jugado). Cuando hemos encontrado ese índice, se sale del bucle. Lo marcamos como TRUE y devolvemos la palabra en esa posición. 

![](images/nuevapalabra-3-e1612104522263.png) 

La clase Random debe ser importada, también forma parte del paquete java.util.

**Otras operaciones**  
Dentro del método partida hay dos secuencias de instrucciones que, sin ser complejas, nos conviene programar en métodos aparte. Así facilitamos la limpieza y la comprensión del código del método partida() cuando lleguemos a él. La primera operación, por obvia, es leerLetra(). Debe recibir el input en los parámetros parámetros de la llamada y devolver un único carácter. Por supuesto, controlaremos las excepciones correspondientes, tal y como hicimos al leer las opciones del menú principal.

![](images/leerletra-e1612112145312.png) 

Como la clase Scanner no proporciona un método para leer el primer carácter, lo que hacemos es leer toda una línea (nextLine()), convertirla a minúsculas (toLowerCase()), y de ahí tomar el carácter en la posición 0 (charAt()); En la clase Character tenemos un método llamado isLetter() que comprueba si un carácter dado es una letra, y no terminaremos el bucle de pedir letras mientras no obtengamos una.

El siguiente método que he escrito es el que mostrarEstadoPartida(). Básicamente lo que hace es escribir en pantalla tantos "\_" como caracteres componen la palabra secreta, o la letra si ésta ya ha sido revelada por el jugador. A continuación, escribe las letras que no forman parte de la palabra o las que ya se revelaron previamente, porque contarán como fallos, y tantos "\_" como intentos restantes de los que disponga. Tanto la palabra como las letras son arrays de char, lo que nos evita tener que andar construyendo nuevas cadenas a partir de subcadenas en cada sustitución. 

![](images/mostrarestadopartida-e1612113077675.png)

**La partida**  
Y finalmente, vamos al método partida(), que es el que desarrolla el juego. Para empezar, debo recordar que devuelve TRUE si el usuario gana la partida y FALSE si pierde. Podría hacerlo también como int porque hay juegos donde existe la posibilidad de empate, o por si quiero programar que el jugador pueda abandonar una partida sin que se contabilice como victoria o derrota. El método debe recibir el argumento Scanner desde main(), para poder pasárselo a su vez al método leerLetra().

![](images/partida-e1612114113963.png) 

He estructurado el método en cuatro bloques que son: 1. Preparación de las variables Solicito la palabra secreta al método nuevaPalabra(), creo un array de char palabra\[\] con la misma longitud para almacenar la letras que el jugador acierta y otro con el tamaño maxIntentos para las letras falladas vLetras\[\]. 2. Muestro el estado de la partida y los intentos restantes, y leo una letra. Si esa letra forma parte de palabraSecreta y no de palabra\[\] entonces la revelo. 3. Siempre que se haya acertado una letra, se compara palabraSecreta con palabra\[\] (podemos convertir el contenido del array a String con el método String.copyValueOf()). Si son iguales, la palabra ha sido revelada y ponemos fin a TRUE. Si no se ha acertado la letra, la apuntamos en vLetras y aumentamos el contador de fallos. 4. El último bloque verifica si la partida ha terminado porque la variable fin era TRUE, lo que significaría una victoria. Si hemos llegado hasta ahí y todavía vale false, es una derrota. Mostramos los mensajes adecuados y devolvemos el valor de fin.

**Compilación y ejecución**  
![](images/captura-de-pantalla-2021-01-31-a-las-18.46.08.png) 

![](images/captura-de-pantalla-2021-01-31-a-las-18.47.48.png)

