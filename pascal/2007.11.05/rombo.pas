program rombo (input, output);
{Autor      Emilio Devesa
 Archivo    rombo.pas
 Objetivo   Este programa se hace para dibujar un rombo centrado en pantalla.
 Espec      Pedir al usuario los datos del rombo que se va a representar y
            luego mostrar un rombo vacio o lleno y del tamaño indicado.
 Fecha      5/11/2007
 Entrega    12/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

var desplaz, nLineas, linea, nCar, carPorLinea: integer;
    carInterno, carExterno: char;

begin
    writeln ('PROGRAMA ROMBO':40);
    writeln ('Practicas de Programacion. Creado en Pascal ISO 10206');
    writeln ('Escrito por Emilio Devesa. 2007.');
    writeln;

    {Parte del programa donde el usuario introduce las propiedades del rombo que
    se va a dibujar.}
    write ('El numero de lineas del rombo ha de ser impar. Tambien ha de ser ');
    writeln ('mayor o igual ');
    writeln ('que 3 y menor o igual que 79.');
    write ('Escriba el numero de lineas del rombo: ');
    readln (nLineas);

    {Obligamos al programa a ejecutar lo que hay en la instruccion while si el numero no es impar.}
    if (nLineas mod 2) = 0
    then nLineas := 2;

    while (nLineas < 3) or (nLineas > 79) do begin
        {El numero de lineas no puede exceder 79 porque a partir de la linea
        79, se producen mas de 80 caracteres por linea, y 80 es el maximo
        permitido en una ventana de modo texto. Como debe ser impar, tomamos
        el valor 79 como maximo permitido.}
        writeln;
        if nLineas = 1
        then begin
            write ('Con menos de 3 lineas los caracteres no seran ');
            writeln ('suficientes para representar un ');
            write ('rombo. ');
        end;
        write ('Debe ser un impar mayor o igual que 3 y menor o igual ');
        writeln ('que 79.');
        write ('Por favor, introduzca el numero de nuevo: ');
        readln (nLineas);
        if (nLineas mod 2) = 0
        then nLineas := 1; {Obligamos al programa a ejecutar lo que hay en
                            la instruccion while de nuevo si el numero no es
                            impar.}
    end;
    writeln;

    write ('Introduzca el caracter utilizado en las aristas del rombo: ');
    readln (carExterno);
    writeln;
    write ('Introduzca el caracter utilizado en el interior del rombo: ');
    readln (carInterno);
    writeln;
    write ('A continuacion se dibujara el rombo: ');
    writeln;

    {Parte del programa donde se dibuja la mitad superior del rombo segun los
    datos introducidos por el usuario.}

    linea := 1;
    while linea <= ((nLineas - 1) div 2) do begin
    {Ajustes para centrar el rombo al dibujarlo en pantalla.}    
    {Como las lineas del rombo siempre estan compuestas por un numero impar
    de caracteres, el centrado ha de hacerse con un numero de caracteres por
    linea tambien impar. En este caso, decimos que una linea tiene 79 caracteres
    en lugar de 80.}
        nCar := 1;
        {Calculamos el centrado de la siguiente linea y se comienza a escribir de nuevo.}
        carPorLinea := linea + (linea - 1);
        desplaz := (79 - carPorLinea) div 2;
        write ('':desplaz);

        while nCar <= carPorLinea do begin
            if (nCar = 1) or (nCar = carPorLinea)
            then begin
                write (carExterno);
                nCar := nCar + 1;
            end
            else begin
                write (carInterno);
                nCar := nCar + 1;
            end;
        end;
        linea := linea + 1;
        writeln;
    end;

    {Parte del programa donde se dibuja la linea central segun los datos
    introducidos por el usuario.}
    carPorLinea := linea + (linea - 1);
    desplaz := (81 - carPorLinea) div 2;
    {La linea central puede que contenga 79 caracteres, por lo que el centrado lo
    realizamos tomando 81 como numero de caracteres de una linea en la pantalla.
    En consecuencia, el valor de desplaz es siempre mayor o igual que 1.}
    nCar := 1;
    write (carExterno:desplaz);
    repeat
            write (carInterno);
            nCar := nCar + 1;
    until nCar = (carPorLinea - 1);
    writeln (carExterno);
    linea := linea + 1;

    {Parte del programa donde se dibuja la mitad inferior segun los datos introducidos
    por el usuario.}

    while linea <= nLineas do begin
        nCar := 1;
        {La metodologia de dibujar las lineas es la misma que para la parte superior,
        pero en este caso una linea tiene siempre dos caracteres menos que la anterior.}
        carPorLinea := carPorLinea - 2;
        desplaz := (79 - carPorLinea) div 2;
        write ('':desplaz);

        if carPorLinea < 3 {Caso de la ultima linea.}
        then write (carExterno)
        else begin
            while nCar <= carPorLinea do begin
                if (nCar = 1) or (nCar = carPorLinea)
                then begin
                    write (carExterno);
                    nCar := nCar + 1;
                end
                else begin
                    write (carInterno);
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
