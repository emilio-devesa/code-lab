program triangulo (input, output);
{Autor      Emilio Devesa
 Archivo    triangulo.pas
 Objetivo   Este programa se hace para dibujar un triangulo centrado en pantalla.
 Espec      Lo que este programa debe hacer es pedir al usuario los datos del
            triangulo que se va a representar y luego mostrar un triangulo vacio o
            lleno y del tamaño indicado.
 Fecha      5/11/2007
 Entrega    12/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

var nLineas, linea, nCar, desplaz, carPorLinea: integer;
    carInterm, carVertices: char;
begin
    writeln ('PROGRAMA TRIANGULO':40);
    writeln ('Practicas de Programacion. Creado en Pascal ISO 10206');
    writeln ('Escrito por Emilio Devesa. 2007.');
    writeln;

    {Parte del programa donde el usuario introduce las propiedades
    del triangulo que se va a dibujar.}
    write ('Numero de lineas del triangulo (mayor o igual que 2 y menor o igual');
    write (' que 40): ');
    readln (nLineas);

    while (nLineas < 2) or (nLineas > 40) do begin
        {El numero de lineas no puede exceder 40 porque a partir de la linea
        40, se producen mas de 80 caracteres por linea, y 80 es el maximo
        permitido en una ventana de modo texto.}
        writeln;
        if nLineas < 2
        then begin
            write ('Con menos de 2 lineas los caracteres ');
            writeln ('no seran suficientes para representar un');
            {Se acaba de usar writeln porque esa cadena y la anterior suman
            casi 80 caracteres, que es el ancho maximo de linea.}
            write ('triangulo. ');
        end;
        writeln ('Debe ser mayor o igual que 2 y menor o igual que 40.');
        write ('Por favor, introduzca el numero de nuevo: ');
        readln (nLineas);
    end;
    writeln;

    write ('Introduzca el caracter utilizado en los comienzos de linea: ');
    readln (carVertices);
    writeln;

    if nLineas > 1
    then begin
        write ('Introduzca el caracter intermedio: ');
        readln (carInterm);
        writeln;
    end;

    {Ajustes para centrar el triangulo al dibujarlo en pantalla.}
    {El numero de caracteres en una linea se calcula mediante la siguiente
    expresion aritmetica.}
    carPorLinea := linea + (linea - 1);

    {Como las lineas del triangulo siempre estan compuestas por un numero impar
    de cacracteres, el centrado ha de hacerse con un numero de caracteres por
    linea tambien impar. En este caso, decimos que una linea tiene 79 caracteres
    en lugar de 80.}
    desplaz := (79 - carPorLinea) div 2;
    
    writeln ('A continuacion se dibujara el triangulo: ');
    writeln;
    {Parte del programa donde se dibuja el triangulo segun los datos
    introducidos por el usuario.}

    while linea <= nLineas do begin
        {Calculamos el centrado de la siguiente linea y se
        comienza a escribir de nuevo.}
        nCar := 1;
        carPorLinea := linea + (linea - 1);
        desplaz := (79 - carPorLinea) div 2;
        write ('':desplaz);

        while nCar <= carPorLinea do begin
            if (nCar = 1) or (nCar = carPorLinea)
            then begin
                write (carVertices);
                {Estos son los caracteres del principio y
                final de cada linea.}
                nCar := nCar + 1;
            end
            else begin
                if ( nCar mod 2 ) > 0
                then begin
                    write (carVertices);
                    {En los caracteres impares se escribe
                    el caracter carVertices.}
                    nCar := nCar + 1;
                end
                else begin
                    write (carInterm);
                    {En los caracteres pares se escribe
                    el caracter carInterm.}
                    nCar := nCar + 1;
                end;
            end;
        end;
        linea := linea + 1;
        writeln;
    end;

    write ('Pulse ENTER para salir.');
    readln;
end.