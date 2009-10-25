program etiquetas (input, output);

label 234, 53;  {no son números de línea ni enteros}

var nombre: string(15) value '';

begin
    234: write ('Dime tu nombre: ');
        readln (nombre);
        if nombre = '' then goto 234;
        writeln ('hola ', nombre);

    53: goto 53;    {bucle infinito}
end.
