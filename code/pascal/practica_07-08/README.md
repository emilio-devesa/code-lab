# Práctica del curso 2007-2008

Realizar un programa en Pascal ISO 10206 que realice una estadística, una eliminación de palabras repetidas, un cifrado y descrifrado de un texto leído desde el fichero texto.txt


## Estadística

Por cada línea del texto almacenar en el fichero llamado información un registro cuyos campos indiquen:
- Primera palabra en la línea
- Número absoluto de línea
- Número de página donde está la línea
- Número de palabras en la línea
- Última palabra en la línea


## Eliminación de palabras repetidas

Guardar en el fichero sinrepetidas.txt el texto original sin palabras repetidas, dejando la primera ocurrencia


## Cifrado

Leer el fichero sinrepetidas.txt. Cifrarlo mediante el método de sustitución simple (utilizar como alfabeto del criptosistema el código ASCII). El resultado almacenarlo en un fichero de texto llamado cifrado.txt


## Descifrado

Leer cifrado.txt y almacenar el código una vez descifrado en un fichero llamado descifrado.txt



El programa debe tener un menú donde el usuario pueda:
1. Consultar la estadística almacenada en el fichero información
2. De las palabras que aparecen en texto.txt:
	a. Verlas odrdenadas alfabéticamente
	b. Conocer el número de ocurrencias de una palabra
3. Obtener por pantalla el cifrado de cualquier línea de texto.txt
