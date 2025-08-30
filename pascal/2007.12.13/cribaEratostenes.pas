program cribaEratostenes (input, output);
{Autor      Emilio Devesa
 Archivo    cribaEratostenes.pas
 Objeto     Crear un programa que muestre los numeros primos entre 2-997
 Espec      Este programa debe servir para ver el uso de conjuntos
 Fecha      13/12/2007
 Entrega    17/12/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}
{$ extended-pascal}
{$ setlimit=1000}

type tCNum = set of 2..997;

var i,j: integer;
    conj: tCNum;

begin
    conj := [2..997];
    i := 2;
    repeat  
        j := i + i;
        repeat
            conj := conj - [j];
            j := j+i;   
        until j > 997;
        repeat i := i + 1 until i in conj
    until i * i > 1000 ;
    writeln ('Los primos entre 2 y 997 son: ');
    for i in conj do write(i:4) ; 
    writeln;
end.
