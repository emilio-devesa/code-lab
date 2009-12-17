program cuadrado (input, output);
{Autor      Emilio Devesa
 Archivo    cuadrado.pas
 Objeto     Este programa se hace para dibujar un cuadrado en pantalla
 Espec      Lo que este programa debe hacer es pedir al usuario el numero
            de lineas que debe ocupar el cuadrado, el caracter externo y
            el caracter interno del cuadrado, para luego pintarlo en pantalla
 Fecha      17/12/2009
 Entrega
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206 con la
            directiva --extended-pascal
}

var nLineas, nCar, i, centrado: integer value 1; carExt, carInt: char;

procedure Centrar (longitud: integer; var posicion: integer);
begin
    posicion := (80 - longitud) div 2;
end;

begin
    write ('Lineas? ');
    readln (nLineas);
    write ('Caracter externo? ');
    readln (carExt);
    write ('Caracter interno? ');
    readln (carInt);

    Centrar (nLineas, centrado);
    write ('':centrado);
    for nCar := 1 to nLineas do write (carExt); writeln;

    i := 2;
    while i < nLineas do begin
        write('':centrado);
        write(carExt);
        for nCar := 2 to (nLineas-1) do write (carInt);
        write (carExt); writeln; i := i + 1;
    end;

    write ('':centrado);
    for nCar := 1 to nLineas do write (carExt); writeln;
end.
