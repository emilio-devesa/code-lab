# Práctica del curso 2008-2009

Elaborar un programa dirigido por menús para gestionar las notas de una asignatura.
El programa debe ser capaz de recoger los datos de los alumnos (nombre, apellidos y login), las convocatorias posibles en el curso (febrero/junio, septiembre, diciembre) y las notas de cada convocatoria (teoría, práctica y global) así como la modificación de los errores que pudiera haber.

El programa debe permitir los siguientes listados
- Alfabético de alumnos (apellidos, nombre y login)
- Alfabético de alumnos y notas de la convocatoria que pida el usuario
- Alumnos y notas de una convocatoria en orden decreciente de estas

Los listados deben detener la salida cuando se llene la pantalla y continuar cuando el usuario pulse la barra espaciadora o salir si escribe la letra q/Q.
Las notas se mostrarán como máximo con un decimal.

La introducción de los datos se tiene que poder detener en cualquier momento sin que se pierda el trabajo hecho.

El programa preguntará al usuario sólo la primera vez que se use si se guarda la nota de teoría y/o la de práctica una vez que se superan en una de las convocatorias del curso. Luego lo tendrá en cuenta el resto del curso.

Por ejemplo, si se guarda la nota de prácticas, y un alumno las aprueba en febrero (pero no la asignatura) al introducir las notas en la siguiente convocatoria se hará constar la nota de febrero seguida por la inicial del nombre del mes en que aprobó por ejemplo (1.3f).

En la introducción de datos, el programa sólo permitirá datos numéricos entre 0 y 10 con un decimal como máximo (salvo para 10 que no aceptará ninguno)