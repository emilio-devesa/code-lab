module files;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    files.pas
    Provides common procedures and functions for file management
}


export  files = (
            BinFileExists,
            BinFileIsBound,
            TextFileExists,
            TextFileIsBound
);

import  StandardInput;
        StandardOutput;
        types qualified;

function BinFileExists (var aFile: types.tBinFile; aName: types.tFileName): boolean;
function BinFileIsBound (var aFile: types.tBinFile; aName: types.tFileName): boolean;
function TextFileExists (var aFile: types.tTextFile; aName: types.tFileName): boolean;
function TextFileIsBound (var aFile: types.tTextFile; aName: types.tFileName): boolean;


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