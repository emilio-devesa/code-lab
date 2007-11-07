program DescomponerFactoresPrimos (input, output);
{Autor      Emilio Devesa
 Archivo    descomponerFactoresPrimos.pas
 Objetivo   Este programa se hace para saber si un número es primo.
 Espec      Lo que este programa debe hacer es pedir un número al usuario y luego
            comenzar a calcular sus factores para saber si es o no un numero primo
 Fecha      7/11/2007
 Entrega    7/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

var cAux: string (80);
    n, expon: integer;
    factor: integer value 2;
    esPrimerFactor: boolean value true;

begin
    {cabecera}
    writestr (cAux, 'Descomponer en factores primos');
    writeln (cAux: 40 + length (cAux) div 2);
    writestr (cAux, '2 <= n <= ', maxint:0);
    writeln (cAux: 40 + length (cAux) div 2);

    repeat
        write ('Introduce n: ');
        readln (n);
    until (n >= 2) and (n <= maxint);


    {descomponer}
    writestr (cAux, n:0);
    while n > 1 do begin
        {encontrar potencia de factor}
        expon := 0;
        while n mod factor = 0 do begin
            n := n div factor;
            expon := expon + 1;
        end;

        {anotar factor y potencia}
        if expon > 0
        then begin
            if esPrimerFactor
            then begin
                esPrimerFactor := false;
                if (n = 1) and (expon = 1) {es primo}
                then writestr (cAux, cAux, ' es primo.')
                else begin
                    writestr (cAux, cAux, ' = ', factor:0);
                    if expon > 1
                    then writestr (cAux, cAux, '^', expon:0);
                end
            end
            else begin
                writestr (cAux, cAux, ' * ', factor:0);
                if expon > 1
                then writestr (cAux, cAux, '^', expon:0);
            end
        end;

        {pasar al siguiente factor}
        if factor = 2
        then factor := 3
        else factor := factor + 2;
    end;

    {ver resultado}
    writeln (cAux: 40 + length (cAux) div 2);
    write ('Pulse ENTER.');
    readln;
end.