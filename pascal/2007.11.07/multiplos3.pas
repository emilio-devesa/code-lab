program multiplos3 (input, output);
{Autor      Emilio Devesa
 Archivo    multiplos3.pas
 Objeto     Este programa se hace para sumar los enteros entre 1 y 100 que son
            multiplos de 3, los que son multiplos de 3 mas 1, y los que son
            multiplos de 3 mas 2.
 Espec      Lo que este programa debe hacer es calcular los multiplos de 3 hasta
            llegar a 100 y luego sumar sus valores. A continuacion sumar 1 a cada
            valor y volver a sumar los valores. Por ultimo, sumar 2 a los
            multiplos de 100 y volver a sumar sus valores.
 Fecha      7/11/2007
 Entrega    12/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

var multiplo, sumaMult, sumaMult1, sumaMult2: integer value 0;
    cAux: string (80);

begin
    writestr (cAux, 'Multiplos de 3 hasta 100.');
    writeln (cAux: 40 + length (cAux) div 2);
    writestr (cAux, 'Practicas de programacion.');
    writeln (cAux: 40 + length (cAux) div 2);
    writeln;

    for multiplo := 3 to 100 do begin
        if (multiplo mod 3) = 0
        then begin
            sumaMult := sumaMult + multiplo;
            sumaMult1 := sumaMult1 + multiplo + 1;
            sumaMult2 := sumaMult2 + multiplo + 2;
        end;
    end;

    writeln ('La suma de los multiplos de 3 hasta 100 es = ', sumaMult:0);
    writeln ('La suma de los multiplos de 3 mas 1 hasta 100 es = ', sumaMult1:0);
    writeln ('La suma de los multiplos de 3 mas 2 hasta 100 es = ', sumaMult2:0);
    write ('Pulse ENTER.');
    readln;
end.
