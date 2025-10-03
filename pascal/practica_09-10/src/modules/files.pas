module files;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    files.pas
    Provides common procedures and functions for file management
}


export  files = (
            F_CASTILLAN,
            F_GALICIAN,
            F_ENGLISH,
            F_HIGHSCORES,
            tFileName,
            tBinFile,
            tTextFile,
            BinFileExists,
            BinFileIsBound,
            TextFileExists,
            TextFileIsBound
);

import  StandardInput;
        StandardOutput;
        types qualified;

const   F_CASTILLAN = 'data/Castellano';
        F_GALICIAN = 'data/Gallego';
        F_ENGLISH = 'data/Ingles';
        F_HIGHSCORES = 'data/HistoricodeJugadas';

type    tFileName = string (23);
        tBinFile = bindable file [0..MAXINT] of types.tGameRecord;
        tTextFile = bindable text;

function BinFileExists (var aFile: tBinFile; aName: tFileName): boolean;
function BinFileIsBound (var aFile: tBinFile; aName: tFileName): boolean;
function TextFileExists (var aFile: tTextFile; aName: tFileName): boolean;
function TextFileIsBound (var aFile: tTextFile; aName: tFileName): boolean;


end;


function BinFileExists;
var b: bindingtype;
begin
    unbind(aFile);
    b := binding(aFile);
    b.name := aName;
    bind(aFile, b);
    b := binding(aFile);
    BinFileExists := b.existing;
end;

function BinFileIsBound;
var b: bindingtype;
begin
    unbind(aFile);
    b := binding(aFile);
    b.name := aName;
    bind(aFile, b);
    b := binding(aFile);
    BinFileIsBound := b.bound;
end;

function TextFileExists;
var b: bindingtype;
begin
    unbind(aFile);
    b := binding(aFile);
    b.name := aName;
    bind(aFile, b);
    b := binding(aFile);
    TextFileExists := b.existing;
end;

function TextFileIsBound;
var b: bindingtype;
begin
    unbind(aFile);
    b := binding(aFile);
    b.name := aName;
    bind(aFile, b);
    b := binding(aFile);
    TextFileIsBound := b.bound;
end;


end.