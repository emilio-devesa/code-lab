program romboConRepeat (input, output);
{Autor      Emilio Devesa
 Archivo    romboConRepeat.pas
 Objetivo   Este programa se hace para dibujar un rombo en pantalla
 Espec      Lo que este programa debe hacer es pedir al usuario los datos del
            rombo y despues dibujar un rombo en pantalla con esas caracteristicas.
 Fecha      5/11/2007
 Entrega    12/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

var
    size: integer;
    extChar, innChar: char;
    line, chars, position, i: integer;
    sizeIsOdd, overCenter: boolean;

begin
    {Este bucle pregunta el tamaño del rombo al usuario y se asegura de que
    el valor esté comprendido entre 3 y 80 para poder representarlo en la terminal}
    repeat
        write('Introducir tamaño del rombo (min: 3, max:80): ');
        readln(size);
        if (size<3) or (size>80)
        then writeln('Tamaño no válido.')
    until (3<=size) and (size<=80);
    write('Introducir caracter externo: ');
    readln(extChar);
    write('Introducir caracter interno: ');
    readln(innChar);

    sizeIsOdd:=(size mod 2)<>0;
    overCenter:=false;
    line:=1;
    repeat
        {Calculamos cuantos caracteres se pintan en cada linea}
        chars:=(2*line)-1;
        {Calculamos la posicion en la que deben pintarse}
        {Si el tamaño es par se pinta un rombo del tamaño del numero impar anterior}
        if (sizeIsOdd)
        then position:=(size div 2 + 1)-(chars div 2)
        else position:=(size div 2)-(chars div 2);

        {Pintamos los caracteres correspondientes a una linea}
        i:=1;
        repeat
            if (i=1)
            then write(extChar:position)
            else if (i=chars)
                then write(extChar)
                else write(innChar);
            i:=i+1;
        until (i>chars);
        writeln;

        {Comprobamos si hemos sobrepasado el centro del rombo.
        Si es así, empezamos a pintar la parte inferior}
        if not overCenter
        then begin
            line:=line+1;
            if (sizeIsOdd)
            then overCenter := line>(size div 2)
            else overCenter := line>(size div 2 - 1);
        end
        else line:=line-1;
    until (line<1);
end.
