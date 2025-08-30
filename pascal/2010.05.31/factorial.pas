program factorial (input, output);
{Autor      Emilio Devesa
 Archivo    factorial.pas
 Objeto     Este programa calcula el factorial de un numero
 Espec      Lo que este programa debe hacer es pedir al usuario el numero
            cuyo factorial se desea conocer y mostrar el resultado calculado
            mediante una funcion recursiva y mediante una función iterativa.
 Fecha      31/05/2010
 Entrega
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206 con la
            directiva --extended-pascal
}

var i, r: integer;

function fact_rec (i: integer): integer;
begin
    if i = 0
    then fact_rec := 1
    else fact_rec := i * fact_rec (i-1);
end;

function fact_ite (i: integer): integer;
var n,res: integer;
begin
    if i = 0
    then fact_ite := 1
    else begin
        res := 1;
        for n := 1 to i do res := res * n;
        fact_ite := res;
    end;
end;

begin
    write ('Introduzca numero: ');
    readln (i);
    r := fact_rec (i);
    writeln ('Calculo recursivo: ', r:0);
    r := fact_ite (i);
    writeln ('Calculo iterativo: ', r:0);
end.