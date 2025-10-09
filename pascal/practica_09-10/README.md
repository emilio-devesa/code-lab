# Práctica del curso 2009-2010

Implementar el juego: “**DESCUBRO PALABRAS**”. En PASCAL ESTANDAR EXTENDIDO.

El usuario escoge el idioma (ingles, gallego o castellano) y el nivel de dificultad (4 letras, 5 letras, 6 letras). Debe haber un fichero de texto externo por cada idioma. Los ficheros externos se llamarán Ingles, Gallego, Castellano. Dentro de cada fichero sólo puede haber cien líneas. Cada línea con tres palabras separadas por el carácter tabulador. Dentro de cada línea la primera palabra tendrá 4 letras, la segunda palabra será de cinco letras y la tercera de 6 letras.

El ordenador escoge de forma aleatoria una palabra del fichero de texto que contenga las palabras en el idioma y nivel de dificultad elegido por el usuario

1. El usuario escribe por teclado una palabra del número de caracteres elegido
2. El ordenador mostrará por pantalla una cadena del tamaño de la palabra:
    * Si una de las letras es correcta, y corresponde exactamente por su posición, a una letra de la palabra a descubrir, el ordenador lo indica poniendo la letra en mayúscula.
    * Si la letra es correcta, pero no está en el sitio correcto, el ordenador lo indicará poniendo la letra en minúscula.
    * El ordenador no indicará si la palabra tiene letras repetidas, teniendo prioridad en la indicación la letra del sitio correcto.
    * Si ninguna letra corresponde, el ordenador lo indicará marcando una “?” en su lugar.

El usuario con las pistas obtenidas, vuelve a escribir otra palabra para que el ordenador le dé pistas según la descripción del paso 2; hasta que la palabra haya sido acertada o el jugador se rinda.

* El programa escribirá, por cada juego realizado, en un fichero binario de acceso directo, llamado HistoricodeJugadas, un registro con los valores siguientes:
```
PalabraPorDescubrir NombreJugador   NúmeroIntentos  FechaJugada
```

Por ejemplo:
```
Examen  José Pérez Gómez    5   12 octubre 2009
Examen  Juan Pereza Bostezo rendido 12 septiembre 2009
```

* El programa será dirigido por menús, mostrando en un primer nivel:
    * Opción Jugar. Donde se podrá elegir:
        * Opción Validar: deberá imprimir un mensaje con la palabra a descubrir justo antes de que el usuario escriba por primera vez una palabra.
        * Opción Juego (sin mostrar la palabra a descubrir).
    * Opción Consultar HistóricodeJugadas.
        * Mostrar todos los valores de los registros del fichero ordenados según cualquiera de los cuatro campos que indique el usuario.
    * Opción Ver Palabras en pantalla
        * De cualquiera de los ficheros de texto, escogiendo el usuario el número de letras de las palabras a visualizar.
        * Listadas por orden alfabético de palabras.
        * Dos palabras por línea y el usuario debe pulsar la tecla ENTER para ver la siguiente
pantalla de palabras.

Las palabras deben aparecer en el diccionario de la lengua del idioma elegido, pero no tendrán letras acentuadas ni caracteres especiales exceptuando la letra Ñ/ñ.

En la ordenación alfabética el carácter especial ñ/Ñ estará después de la n/N y antes de la o/O.