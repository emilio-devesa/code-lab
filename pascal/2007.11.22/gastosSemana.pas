program gastosSemana (input, output);
{Autor      Emilio Devesa
 Archivo    gastosSemana.pas
 Objeto     Este programa se hace para comprender el uso de arrays
 Espec      Lo que este programa debe hacer es pedir al usuario los gastos de cada
            dia de la semana y luego mostrar en pantalla el gasto diario y la
            media diaria.
 Fecha      22/11/2007
 Entrega    23/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

var gastos: array[1..7] of real value [otherwise 0];
    dias: array[1..7] of string(10) value [1:'Lunes';2:'Martes';3:'Miercoles';4:'Jueves';5:'Viernes';6:'Sabado';7:'Domingo'];

procedure setGastos;
var i: integer;
begin
    for i:=1 to 7 do begin
        write('Gastos del ', dias[i],'? ');
        readln(gastos[i]);
    end;
end;

procedure printGastos;
var i: integer;
begin
    for i:=1 to 7 do writeln('Gastos del ', dias[i],': ',gastos[i]:2:2);
end;

procedure printMedia;
var i:integer; total: real;
begin
    for i:=1 to 7 do total:=total+gastos[i];
    writeln('La media diaria es: ',total/7:2:2);
end;

begin
    setGastos;
    printGastos;
    printMedia;
end.