program triadasPi (input, output);
{Autor      Emilio Devesa
 Archivo    triadasPi.pas
 Objeto     Este programa se hace para encontrar todas las triadas de Pitagoras
            para enteros entre 1 y 100.
 Espec      Lo que este programa debe hacer es calcular si tres numeros enteros
            menores que 100 satisfacen la ecuacion del teorema de Pitagoras.
 Fecha      7/11/2007
 Entrega    12/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

var a, b, h: integer value 0;
    cAux: string (80);

begin
    writestr (cAux, 'Triadas de Pitagoras');
    writeln (cAux: 40 + length (cAux) div 2);

    writeln;
    writeln ('Las triadas hasta 100 son: ');

    for h:=5 to 100 do begin
        for a:=4 to h do
            for b:=3 to a do
                if h**2 = a**2 + b**2
                then writeln (b:2,(' '),a:2,(' '),h:3);

    end;
    writeln;
    write ('Pulse ENTER.');
    readln;
end.
