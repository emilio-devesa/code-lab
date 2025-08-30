program fibonacci (input, output);
{Autor    Emilio Devesa
 Archivo  fibonacci.pas
 Objeto   Este programa calcula numeros de la serie de Fibonacci
 Espec    Lo que este programa debe hacer es pedir al usuario el numero
          de la serie de Fibonacci que desea calcular y mostrarlo en pantalla
          junto al tiempo (en segundos) que se ha necesitado para calcularlo.
 Fecha    31/05/2010
 Entrega
 Notas    La compilación será en gpc en el lenguaje pascal ISO 10206 con la
          directiva --extended-pascal
}

var num,result: integer; t1,t2: timestamp;

function fib_rec (i: integer): integer;
begin
    if i <= 1
    then fib_rec := i
    else fib_rec := fib_rec (i-1) + fib_rec(i-2);
end;

begin
    write ('Introducir numero: ');
    readln (num);
    gettimestamp (t1);
    result := fib_rec (num);
    writeln ('Resultado: ', result);
    gettimestamp (t2);
    writeln ('Tiempo (s): ', t2.second - t1.second);
end.