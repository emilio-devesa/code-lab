program Main;
{   Práctica 2007-2008
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Emilio Devesa
    https://emiliodevesa.wordpress.com/
}

import  StandardInput; StandardOutput;

const   textFileName = 'texto.txt';
        statsFileName = 'informacion.txt';
        noRepeatedWordsFileName = 'sinrepetidas.txt';
        cryptFileName = 'cifrado.txt';
        decryptFileName = 'descifrado.txt';

begin
    writeln('Generando estadística para ',textFileName,'...');
    writeln('Eliminando elementos repetidos...');
    writeln('Cifrando fichero ',noRepeatedWordsFileName,'...');
    writeln('Descifrando fichero ',cryptFileName,'...');
end.