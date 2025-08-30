program carteroAburrido (input, output);
{Autor      Emilio Devesa
 Archivo    carteroAburrido.pas
 Objeto     Este programa se hace para ver el funcionamiento de las matrices
 Espec      Lo que este programa debe hacer es poner en valor true los valores que
            son multiplos de 2, luego cambiar el valor a los multiplos de tres...
            y repetir la operacion hasta el final del array
 Fecha      26/11/2007
 Entrega    03/12/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

type tBuzones = array [1..100] of boolean value [otherwise false];

var i, mult: integer; b: tBuzones;

begin
    for i := 2 to 50 do begin
        mult := i + i;
        repeat
            b[mult] := not b[mult];
            mult:= mult + i;
        until mult > 100
    end;
    write ('Buzones abiertos: ');
    for i:=1 to 100 do if b[i] then write (i:0, ', ');
    writeln;
end.