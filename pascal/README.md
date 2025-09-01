# Pascal  
En este directorio se encuentran muchos ejercicios de la asignatura **Programación** e incluso unas prácticas de final de curso de la carrera escritas en Pascal Estandar Extendido.

Este documento aporta información útil sobre el compilador, la sintaxis y las instrucciones más comunes en programación estructurada disponibles en este lenguaje.

## Compiladores  
Para compilar este código, es necesario el compilador de GNU Pascal (gpc) para Pascal Estandard ISO 10206.

Desde http://www.gnu-pascal.de se puede descargar un IDE y el compilador para Windows.

En Ubuntu (u otra distribuciones de GNU/Linux), el compildador ya no se encuentra en los repositorios oficiales de paquetes, pero se puede descargar desde https://launchpad.net/~ueter/+archive/ubuntu/gpc-3.4 y para instalarlo basta con hacer:  
`$ sudo dpkg -i gpc-3.4_20070904-107v_amd64.deb`

De ahi en adelante solo se necesita un editor de texto plano (por ejemplo VS Code) o el editor del IDE de Windows.

## Estructura básica de un programa en Pascal  
```
program programa (input, output);

export
    {en módulos/units, cláusula en la que exportamos sus identificadores};

import
    {cláusula en la que importamos modulos/units};

const
    {declaracion de constantes};

type
    {declaracion de tipos que diseñemos nosotros};
	
var 
    {declaracion de variables};

{funciones y procedimientos}
function ...
begin
end;

procedure ...
begin
end;

begin
    {flujo principal del programa}
end.
```

Como siempre conviene recordar que los archivos se guardan con extension ".pas" y que el compilador se invoca:  
`$ gpc --extended-pascal programa.pas` 

Si se trata de un modulo añadimos la directiva -c:  
`$ gpc --extended-pascal -c modulo.pas` 

En pascal los comentarios se introducen entre corchetes `{ }`. Por ejemplo:  
`{Ejemplo de comentario en Pascal}`

**Dos programas de ejemplo:**  
1. **hello_world.pas**
```
program hello_world (input, output);
begin
    writeln ('Hello world!');
    readln;
end.
```

2. **countdown.pas**: usando algunos elementos (funciones, procedimientos, variables...)
```
program countdown (input, output);
{ En este ejemplo implementaremos una cuenta atrás que puede definir el usuario }

{ Todavia no vamos a usar esto, lo haremos si usamos modulos. Por eso queda entre comentarios }
{ import;
  export; }

const cero = 0;

type tContador = record
        actual: integer;
        final: integer;
end;

var contador: tContador;

procedure PonerACero (var c: tContador);
{ Este procedimiento pone el valor final del contador a cero }
begin
    c.final := cero;
end;

procedure Descontar (var c: tContador);
begin
    c.actual := c.actual - 1;
end;

function EstablecerInicio: integer;
{ Esta función pregunta al usuario el valor inicial del contador }
var n: integer;
begin
    write ('Introducir numero inicial: ');
    readln (n);
    EstablecerInicio := n;
end;

procedure ComenzarCuentaAtras (var c: tContador);
begin
    while c.actual > c.final do begin
        Descontar (c);
        writeln (c.actual);
    end;
end;

begin
    PonerACero (contador);
    contador.actual := EstablecerInicio;
    ComenzarCuentaAtras (contador);
    writeln ('Se llego al final.');
    readln;
end.
```

## Tipos de datos  
Una variable (el nombre que introduce un usuario, un número que controle un bucle, etc.) siempre debe estar asociada a un tipo de dato. Por ejemplo, una variable muy sencilla puede ser:  
`var i: integer;` 

Esto quiere decir que manejaremos un dato (_i_) y ese dato será siempre un número entero (_integer_). Es importante distinguir entre lo que es el dato y lo que es su tipo. Además, si en un momento determinado del programa hacemos:  
`i := 1;` 

Ocurrirán tres cosas:  
En primer lugar, el programa tomará el valor _1_ y mirará si es un número entero, porque es lo que _i_ puede almacenar.  
A continuación, buscará la región de memoria que se asocia al nombre _i_. Esta región es donde se graba el valor de la variable (no su nombre, ni su tipo).  
Por ultimo, copia el valor de _1_ a esta región de memoria.

Es decir, _i_ es el nombre de un espacio de memoria que puede almacenar un valor (el que nosotros le grabemos) únicamente del tipo del que se haya definido, que en este caso era _integer_. 

Principalmente podemos guardar datos de más tipos:  
- Tipos que el lenguaje proporciona
- Tipos que definamos nosotros. 

Los tipos definidos en el lenguaje son:  
- `integer` numeros enteros entre _minint_ y _maxint_ 
- `char` caracteres de la tabla ASCII
- `boolean` valores logicos _true_ o _false_
- `string` en realidad son cadenas de _char_
- `real, complex...` numeros en coma flotante (reales, complejos...)

Además puede ser que necesitemos tipos más complejos, como listas, colas, pilas, árboles de cualquier naturaleza... Estos tipos definidos por el usuario habrá que construirlos (a veces se denominan tipos abstractos) y hay que crearlos a partir de los primarios.

**IMPORTANTE**: Todo dato debe ser de un tipo bien definido, asi que no podemos usar una variable para almacenar ahora un entero y luego un string.

## Flujo del programa  
La programación estructurada es un tipo de programación muy común y contemplada en casi cualquier lenguaje: Pascal, C, Phyton... Básicamente dicta que cualquier algoritmo se puede desarrollar con tres tipos de sentencias:  
- Secuencias: una instrucción se ejecuta tras otra
- Decisiones (selectores): se toma un camino u otro de acuerdo a una condición que puede ser verdadera o falsa (`if ... then ... else ...`, `case`)
- Bucles (iteradores): repetición de una sentencia o una secuencia de sentencias (`while`, `for`, `repeat`)

**Secuencia**  
Una secuencia de instrucciones normal y corriente en Pascal puede ser:
```
writeln ('Hola mundo');
writeln ('Adios mundo');
```

Se ejecutan en el mismo orden en el que han sido escritas o invocadas en el código fuente.

**Selectores**  
Para decidir si mostrar un mensaje u otro de acuerdo a, por ejemplo, que una variable `i` valga 1, usaremos el `if`:
```
if i = 1
then writeln ('Hola mundo')
else writeln ('Adios mundo');
```

Si en vez de decidir entre dos caminos (`if ... then ... else ...`) nuestra intención es distinguir varios, disponemos del `case`:
```
case i of
	1: writeln ('Hola mundo');
	2: writeln ('Adios mundo');
	3: ...
	...
	otherwise writeln ('Cualquier otro caso no contemplado antes');
end;
```

**Iteradores**  
Si quisiésemos repetir una instrucción un número determinado de veces (por ejemplo tres) recurriremos a los bucles. Hay tres tipos de bucle:  
- `repeat`: comienza ejecutándo las instrucciones de su interior y a continuación comprueba si se da la condición para terminar. Si es falsa, vuelve a ejecutar las instrucciones que contenga; o si es verdadera, el bucle termina y el programa continúa a partir de ese punto. Por eso se ejecuta siempre al menos una vez. Debemos crear una variable de control que debe incrementarse manualmente.  
- `while`: antes de ejecutarse por primera vez evalúa la condición. Si es verdadera, ejecuta las instrucciones de su interior y vuelve a evaluarla; si es falsa, el programa continúa a partir de ese punto. Puede que no se ejecute nunca. Al igual que en bucle `repeat`, debemos crear una variable de control que debe incrementarse manualmente. 
- `for`: es el bucle más seguro de todos pues no conduce a la creación de bucles infinitos. Asigna un valor inicial a una variable de control creada ad-hoc y ejecuta el interior del bucle para todos los valores intermedios (si existen), incrementando la variable de forma automática, hasta llegar a un valor final establecido.

Si tomamos el ejemplo puesto antes, vemos cómo se puede escribir con cualquiera de los bucles:

* Ejemplo `for`:
```
for i := 1 to 3 do writeln ('Hola mundo');
```

* Ejemplo `while`:
```
i := 1;
while i <= 3 do begin
	writeln ('Hola mundo');
	i := i + 1;
end;
```

* Ejemplo `repeat`:
```
i := 1;
repeat
	writeln ('Hola mundo');
	i := i + 1;
until i > 3;
```

Los bucles `repeat` y `while` se pueden programar en forma decreciente o regresiva manualmente; y para realizar un bucle `for` de forma decreciente (útil para ordenar arrays, por poner un ejemplo) utilizaremos la palabra `downto`:  
```
for i := 3 downto 1 do writeln ('Hola mundo');
```

**Un ejemplo completo**  
```
program Flow (input, output);

var num: integer; condition: boolean;

begin
	condition := 1 = 1;			    {Comparing 1 = 1 is always true}
	write ('1 = 1... ');
	if condition
	then writeln ('It´s True')
	else writeln ('It´s False');

	condition := 1 = 2;			    {Comparing 1 = 2 is always false}
	write('1 = 2... ');
	if condition
	then writeln ('It´s True')
	else writeln ('It´s False');
	
	num := 10;
	case num of					    {Compares in order until it matches with any case}
		0: writeln ('Number is 0');
		1: writeln ('Number is 1');
		2: writeln ('Number is 2');
		otherwise writeln ('Number is ', num:0);
	end;

	num := 1;						{Set the loop iterator start}
	repeat						    {Executes at least once}
		writeln ('This is a repeat loop, iteration ', num:0);
		num := num + 1;             {Iterator must be incremented manually}
	until (num > 3);				{Checks after executing}
	
	num := 1;						{Set the loop iterator start}
	while (num <= 3) do begin		{Checks before executing, it might never execute}
		writeln ('This is a while loop, iteration ', num:0);
		num := num + 1;				{Iterator must be incremented manually}
	end;

	{The For loop executes a finite number of steps, iterator increments automatically}
	for num := 1 to 3 do writeln ('This is a for loop, iteration ', num:0);
end.
```

Puedes compilarlo con esta orden:
```
$ gpc --extended-pascal Flow.pas
```

## Estructuras
En Pascal hay más formas de manejar los datos que simplemente almacenarlos en variables o establecer unas constantes. Hay además dos tipos de dato muy importantes que son los arrays y los registros.

Un array (tambien se puede llamar vector o matriz) es una porción de memoria que almacenará un número determinado de datos de un mismo tipo.
```
type
	tNombre = string (30);
var
	alumnos: array[1 .. 100] of tNombre;
```

En este ejemplo, tendremos un grupo de 100 datos de tipo tNombre almacenados de forma consecutiva y al que podemos acceder de forma aleatoria. Por ejemplo, podemos escribir el nombre del alumno que se ha guardado en la posición 20:
```
writeln (alumnos[20]);
```

Puedes pensar en un array como si se tratase de una lista de un tamaño determinado llena de elementos de un solo tipo.

La otra estructura son los registros. Supongamos la siguiente colección de tipos:  
```
type
	tNombre = string (30);
	tEdad = integer;
	tTelefono = integer;
```

Podemos definir un nuevo tipo que represente un registro (un conjunto de datos) y una variable de esta forma:  
```
	tRegistro: record
		nombre: tNombre;
		edad: tEdad;
		telefono: tTelefono;
	end;
	
var
	unRegistro: tRegistro;
```

Para hacer referencia a los campos de un registro usamos su identificador seguido de un punto y el campo deseado. Por ejemplo, nos referimos al campo _nombre_ mediante `unRegistro.nombre`, y podríamos hacer asignaciones como la siguiente:  
```
unRegistro.nombre := 'pepito grillo';
```

Obviamente podemos combinar los tipos de datos y las estructuras para obtener tipos abstractos más complejos o estructuras nuevas, por ejemplo:  
```
type
	tNombre = string (30);
	tEdad = integer;
	tTelefono = integer;

	tRegistroAlumno = record
		nombre: tNombre;
		edad: tEdad;
		telefono: tTelefono;
	end;

	tListaAlumnos = array[1 .. 100] of tRegistroAlumno;
	
var
	listaAlumnos: tListaAlumnos;
```

Tendríamos ya creada una lista, y si queremos grabar el alumno Pepito Grillo en la posicion 3, usaríamos una sentencia como esta:  
```
listaAlumnos[3].nombre := 'pepito grillo';
```

De esta forma hemos creado una lista estática de 100 elementos de cualquier tipo: usando un array podemos hacer una lista de un tipo de elementos, pero ese tipo puede ser un registro que almacene diferentes campos.

## Ficheros  
Según el contenido que almacenen, en Pascal existen básicamente dos tipos de ficheros:  
- Binarios: guardan los datos de forma binaria
- De texto: guardan la información como texto plano

Los ficheros binarios y de texto en pascal se definen como:  
```
type
	fBinario: file of ***;
	fTexto: text;
```
 
Los asteriscos deben ser un tipo (primitivo o abstracto) previamente definido (por ejemplo: `file of integer`). La palabra `text` es una palabra reservada del lenguaje.

Estos archivos serán archivos temporales que se destruyen al terminar el programa. En Windows, el fichero estará almacenado en el mismo directorio del programa, oculto y con un nombre asignado por el SO. Si tienes el explorador configurado para ver los archivos ocultos, podrás ver como se crea al abrir el programa, podrás ver su contenido mientras el programa esté corriendo, y cómo se borra automáticamente cuando el programa termina.

En GNU/Linux (o MacOS) es un poco más dificil consultar el archivo temporal. Supongamos que nuestro ejecutable se llama `a.out` (nombre por defecto si no se especifica lo contrario). Mientras el programa se esté ejecutando podremos consultar el archivo. Para localizarlo, abre otra terminal y escribe:  
```
lsof -c a.out
```

Esto muestra todos los procesos abiertos relativos a `a.out`. Encontraremos una línea en la cual aparece "(deleted)" al final. Por ejemplo:  
```
a.out   19624  emi    3u   REG    8,1      256   568 /var/tmp/GPaaa19624 (deleted)
```  

Nos fijamos en los datos de la segunda y cuarta columna: `19624` y `3u`. Ahora escribimos:  
```
cd /proc/19624/fd
```

cambiando 19624 por el numero que te haya salido. A continuacion, del 3u tomamos tan solo el tres y escribimos:  
```
cat 3
```

Y ya veremos en pantalla el contenido del fichero temporal.

## Operaciones con ficheros  
- `rewrite (f)`: Esta instruccion crea un archivo vacio y te situa al inicio en modo de escritura. Si el archivo ya existe, se sobreescribe.
- `reset (f)`: Esta instruccion es la opuesta a `rewrite`. El fichero tiene que existir, se pone el fichero en modo lectura y te situa al principio.
- `update (f)`: Esta instrucción es un híbrido, abre un fichero que ya exista previamente en modo escritura. Si el archivo no existe, provoca error.

Además para escribir y leer dentro de un fichero, basta con usar las instrucciones conocidas `write`, `writeln`, `read` y `readln` con el nombre del fichero como primer argumento. Es decir:
- `writeln ('Hola');`: Esto escribe "Hola" por pantalla
- `writeln (f, 'Hola')`: Esto escribe "Hola" en el fichero (antes hay que hacer el `rewrite` o el `update`)
- `readln (n)`: Lee una variable `n` por el teclado
- `readln (n)`:	Lee una variable `n` desde el fichero. El resto de la linea se descarta asi que es interesante distinguirlo de `read`.
- `read (n)`: Lee una variable `n` y te situa justo en el caracter siguiente, no descarta el resto de la linea.

## Funciones  
Pascal proporciona dos funciones booleanas relativas a ficheros:  
- `eof` (end of file): Indica que se ha encontrado el caracter de final de fichero. En Windows este caracter es `CTRL+Z` y en GNU/Linux es `CTRL+D`. Se usa generalmente de la siguiente forma:  
```
while not eof do...
```
- `eoln` (end of line): Solo se aplica a ficheros de tipo `text` para indicar el caracter de salto de línea (Windows: ``; GNU/Linux: ``). Se emplea de forma análoga a la anterior:  
```
while not eoln do....
```

## Archivos persistentes  
Los archivos persistentes son los que sobreviven al programa y no son borrados por el SO al finalizar la ejecución. Tambien pueden existir previamente y ser recuperados y utilizados por un programa.

Se manejan exactamente igual que un fichero temporal, salvo por tres diferencias:  
1. Hay que marcarlos como "enlazables" para distinguirlos de los ficheros internos
2. Hay que "enlazarlos" para que se usen como ficheros persistentes
3. Hay que asignarles un nombre con el que guardarlos en disco

Para marcarlos como "enlazables" usaremos la palabra reservada `bindable`:  
```
type
	fBinario: bindable file of ***;
	fTexto: bindable text;
```


## Acceso a ficheros persistentes  
Abrir un archivo externo en Pascal no es tan sencillo como pueda parecer porque cada implementación del lenguaje lo hará a su manera.  
En GNU Pascal Estándar Ampliado (ISO 10206), se deben programar unas funciones que hagan el trabajo sucio. También he contemplado la posibilidad de que el archivo no exista previamente en el directorio del programa y por eso hay dos funciones muy similares: `ExisteFicheroTexto` y `EnlazaFicheroTexto`:
```
program abrir_ficheros_gpc (input, output);

type {Nombre: 8 caracteres, 1 punto y 3 caracteres para la extension}
	tNombreFichero = string (12);
	tFicheroTexto = bindable text;

var f: tFicheroTexto; {Variable con la que manejaremos el fichero}

function ExisteFicheroTexto (nombre: tNombreFichero): boolean;
{Objetivo: Comprueba si existe un fichero con nombre tNombreFichero
 PreCD: El fichero es externo (bindable)
 PosCD: Devuelve TRUE si existe o FALSE en caso contrario}
var b: bindingtype; f: tFicheroTexto;
begin
	unbind (f);			{desenlaza f de enlaces previos si hay}
	b := binding (f);	{ínicia b}
	b.name := nombre;
	bind (f, b);		{enlaza la variable f con el fichero argumento}
	b := binding (f);	{actualiza b}
	ExisteFicheroTexto := b.existing;
end;

function EnlazaFicheroTexto (var f: tFicheroTexto; nombre: tNombreFichero): boolean;
{Objetivo: Enlaza un fichero tFicheroTexto
 PreCD: El fichero es externo (bindable)
 PosCD: Devuelve TRUE si ha podido enlazarlo o FALSE en caso contrario}
var b: bindingtype;
begin
	unbind (f);			{desenlaza f de enlaces previos si hay}
	b := binding (f);	{inicia b}
	b.name := nombre;
	bind (f, b);		{enlaza la variable f con el fichero argumento}
	b := binding (f);	{actualiza b}
	EnlazaFicheroTexto := b.bound;
end;

begin
	if ExisteFicheroTexto ('prueba.txt')
	then begin
		if EnlazaFicheroTexto (f, 'prueba.txt')
		then writeln ('Fichero prueba.txt enlazado')
		else writeln ('Fichero prueba.txt no enlazado');
	end
	else writeln ('Fichero prueba.txt no existe');
end.
```

Este programa implementa esas dos funciones. En la ejecución, buscará y tratará en enlazar un archivo de texto llamado `prueba.txt`. Puedes compilar este programa con:  
```
$ gpc --extended-pascal abrir_ficheros_gpc.pas
```

## Rutas a ficheros  
Los ficheros peristentes quedarán por defecto almacenados en el directorio del programa. Si queremos que se almacenen en otra carpeta, debemos asignar como nombre la ruta completa.

En Windows:
```
if EnlazaFicheroTexto (f, 'C:\Fich\prueba.txt')
```

En GNU/Linux:
```
if EnlazaFicheroTexto (f, '/home/emilio/prueba.txt')
```

## Ficheros de acceso directo  
Hasta ahora, hemos visto un tipo de ficheros en los que la información se guarda de forma secuencial y para acceder a un elemento en concreto hay que leer todos los que le preceden.  
Para evitar esto podemos emplear ficheros de acceso directo. Se parecen a un array. En un fichero de acceso directo todos los datos ocupan una posición numerada. Si necesitamos ir al elemento N, podemos ir directamente a esa posición ahorrándonos el coste de leer todo el contenido que la preceda. Sobretodo porque leer en el disco duro (en general, en cualquier memoria secundaria) es una tarea muy lenta que retrasará la ejecución de todo el programa.

Los ficheros de acceso directo pueden ser tanto temporales como persistentes. Se declaran de la siguiente forma:  
```
var
	fDirecto    : file [1..10000] of integer;
	fExtDirecto : bindable file [1..10000] of integer;
```

Aquí tenemos dos ficheros. El primero es un fichero temporal y el segundo es un fichero externo (persistente). Las operaciones sobre ellos son las mismas que en el caso de ficheros de acceso secuencial, pero Pascal proporciona dos más:  
```
seekread (fDirecto, pos);
seekwrite (fDirecto, pos);
```

Estas dos operaciones nos llevarían a la posición `pos` de un fichero `fDirecto`, dejándolo listo para lectura o escritura respectivamente en esa posición.