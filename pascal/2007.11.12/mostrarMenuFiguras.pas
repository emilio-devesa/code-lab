program mostrarMenuFiguras (input, output);
{Autor      Emilio Devesa
 Archivo    mostrarMenuFiguras.pas
 Objetivo   Este programa se hace para mostrar un menu
 Espec      Mostrar un menu para poder seleccionar el procedimiento a
            ejecutar indefinidamente hasta escojer la opcion de salir.
 Fecha      12/11/2007
 Entrega    19/11/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

function getInnChar: char;
var c: char;
begin
    write ('Caracter interior?: ');
    readln (c);
    getInnChar:=c;
end;

function getExtChar: char;
var c: char;
begin
    write ('Caracter exterior?: ');
    readln (c);
    getExtChar:=c;
end;

function getSize(min,max: integer): integer;
var n: integer;
begin
    repeat
        write ('Tamaño? (min=',min:1,', max=',max:2,'): ');
        readln (n);
        if (n<min) or (n>max)
        then write('Tamaño no válido. ');
    until (min<=n) and (n<=max);
    getSize:=n;
end;

function mainMenu: integer;
var opc: integer;
begin
    repeat
        writeln ('MENU PRINCIPAL:');
        writeln ('1. Cuadrado');
        writeln ('2. Triangulo');
        writeln ('3. Rombo');
        writeln ('0. Salir');
        write ('Opción? : ');
        readln (opc);
        if (opc<0) or (3<opc)
        then writeln('Opción no válida.');
        mainMenu:=opc;
    until (0<=opc) and (opc<=3);
end;

procedure cuadrado;
var size, x, y: integer;
    ic, ec: char;
begin
    size:=getSize(2,80);
    ic:=getInnChar;
    ec:=getExtChar;
    for y:=1 to size do begin
        for x:=1 to size do
            if (x=1) or (x=size) or (y=1) or (y=size)
            then write(ec)
            else write(ic);
        writeln;
    end;
end;

procedure triangulo;
var size, position, x, y: integer;
    ic, ec: char;
begin
    size:=getSize(2,40);
    ic:=getInnChar;
    ec:=getExtChar;
    for y:=1 to size do begin
        position:=size+1 - y;
        for x:=1 to (2*y)-1 do
            if (x=1) 
            then write(ec:position)
            else if (x=(2*y)-1) or (y=size)
                then write(ec)
                else write(ic);
        writeln;
    end;
end;

procedure rombo;
var size, position, x, y: integer;
    ic, ec: char;
begin
    size:=getSize(3,40);
    ic:=getInnChar;
    ec:=getExtChar;
    for y:=1 to ((size+1)div 2) do begin
        position:=(size-(2*y)+3) div 2;
        for x:=1 to (2*y)-1 do
            if (x=1) 
            then write(ec:position)
            else if (x=(2*y)-1)
                then write(ec)
                else write(ic);
        writeln;
    end;
    for y:=(size div 2) downto 1 do begin
        position:=(size-(2*y)+3) div 2;
        for x:=1 to (2*y)-1 do
            if (x=1) 
            then write(ec:position)
            else if (x=(2*y)-1)
                then write(ec)
                else write(ic);
        writeln;
    end;
end;

var exit: boolean value false;

begin
    while not exit do begin
        case mainMenu of
            1: cuadrado;
            2: triangulo;
            3: rombo;
            0: exit:=true;
        end;
    end;
end.