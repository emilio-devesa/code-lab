program sumaParImpar (input, output);
{Autor      Emilio Devesa
 Archivo    sumaParImpar.pas
 Objeto     Este programa se hace para sumar pares e impares de m y de n, la suma
            de los pares de m y de n, y la suma de los impares de m y de n.
 Espec      Lo que este programa debe hacer es sumar valores alternando entre par
            e impar.
 Fecha      7/11/2007
 Entrega    8/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

var m, n, i, sumaParM, sumaParN, sumaImpM, sumaImpN, sumaParTotal, sumaImpTotal: integer value 0;
    cAux: string (80);

begin
    writeStr (cAux, 'Sumar pares e impares de m y n.');
    writeln (cAux: 40 + length (cAux) div 2);
    writeStr (cAux, 'Practicas de programacion.');
    writeln (cAux: 40 + length (cAux) div 2);

    repeat
        write ('Introduce un entero m: ');
        readln (m);
    until (m > 0) and (m <= maxint);

    repeat
        write ('Introduce otro entero n: ');
        readln (n);
    until (n > 0) and (n < maxint);

    for i := 0 to m do
        if i > 0
        then begin
            if (i mod 2) = 0
            then sumaParM := sumaParM + 1
            else sumaImpM := sumaImpM + 1;
        end;

    for i := 0 to n do
        if i > 0
        then begin
            if (i mod 2) = 0
            then sumaParN := sumaParN + 1
            else sumaImpN := sumaImpN + 1;
        end;

    writeln ('La suma de los numeros pares hasta ', m:0, ' es = ', sumaParM:0);
    writeln ('La suma de los numeros impares hasta ', m:0, ' es = ', sumaImpM:0);

    writeln ('La suma de los numeros pares hasta ', n:0, ' es = ', sumaParN:0);
    writeln ('La suma de los numeros impares hasta ', n:0, ' es = ', sumaImpN:0);

    sumaParTotal := sumaParM + sumaParN;
    sumaImpTotal := sumaImpM + sumaImpN;

    write ('Los pares hasta ', m:0,' y hasta ', n:0, ' suman = ');
    writeln (sumaParTotal:0);
    write ('Los impares hasta ', m:0,' y hasta ', n:0, ' suman = ');
    write (sumaImpTotal:0);
    readln;
end.