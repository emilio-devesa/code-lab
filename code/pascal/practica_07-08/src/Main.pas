program Main;
{   Práctica 2007-2008
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Emilio Devesa
    https://emiliodevesa.wordpress.com/
}

import  StandardInput; StandardOutput;
        TextFile qualified;
        Stats qualified;

const   textFileName = 'texto.txt';
        statsFileName = 'informacion.txt';
        noRepeatedWordsFileName = 'sinrepetidas.txt';
        cryptFileName = 'cifrado.txt';
        decryptFileName = 'descifrado.txt';


{** Menus' logics **}
function submenuExamineFile: integer;
var option: integer;
begin
    repeat
        writeln;
        writeln('EXAMINAR FICHERO:');
        writeln('1. Ver palabras ordenadas alfabéticamente');
        writeln('2. Conocer el número de ocurrencias de una palabra');
        writeln('0. Volver');
        write('Opcion?: ');
        readln(option);
        if (option < 0) or (2 < option)
        then writeln('Opción no válida.');
        submenuExamineFile := option;
    until(0 <= option) and (option <= 2);
end;

function mainMenu: integer;
var option: integer;
begin
    repeat
        writeln;
        writeln('PRACTICA 2007-2008');
        writeln('1. Consultar estádistica');
        writeln('2. Examinar texto');
        writeln('3. Cifrar línea');
        writeln('0. Salir');
        write('Opcion?: ');
        readln(option);
        if (option < 0) or (3 < option)
        then writeln('Opción no válida.');
        mainMenu := option;
    until(0 <= option) and (option <= 3);
end;


function start(option: integer): integer;
begin
    case (option) of
        1: Stats.printStats(statsFileName);
        2: case (submenuExamineFile) of
                1: {Print words alphabetically sorted};
                2: {Print a words number of ocurrencies};
                0: {return};
            end;
        3: {Crypt a text line};
        0: {exit};
    end;
    start := option;
end;

begin
    writeln('Generando estadística para ',textFileName,'...');
    Stats.getStats(textFileName, statsFileName);
    writeln('Eliminando elementos repetidos...');
    writeln('Cifrando fichero ',noRepeatedWordsFileName,'...');
    writeln('Descifrando fichero ',cryptFileName,'...');
    repeat
    until (start(mainMenu) = 0);
end.