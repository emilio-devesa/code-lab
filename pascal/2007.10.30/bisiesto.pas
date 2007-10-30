program bisiesto (input, output);
{Autor      Emilio Devesa
 Archivo    bisiesto.pas
 Objetivo   Este programa se hace para saber si un año es o no bisiesto
 Espec      Calcular si el año es divisible por 4, por 100 y por 400.
 Fecha      30/10/2007
 Entrega    5/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

var
    year: integer;
    mod4, mod100, mod400: real;

begin
    writeln ('Introduzca el año a calcular: ');
    readln (year);

    mod4:= year mod 4;
    mod100:= year mod 100;
    mod400:= year mod 400;

    if year=0
    then writeln ('El año introducido no es válido. El programa terminará ahora.')
    else if mod4=0
        then if mod100=0
            then if mod400=0
                then writeln ('El año ', year:0, ' es bisiesto.')
                else writeln ('El año ', year:0, ' no es bisiesto.')
            else writeln ('El año ', year:0, ' es bisiesto.')
        else writeln ('El año ', year:0, ' no es bisiesto.');

    writeln ('Pulse ENTER');
    readln;

end.
