module TextFile;
{   Práctica 2007-2008
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    TextFile.pas
    Provides the text file type definition and basic operations
}

export  TextFile = (tFile, fileExists, openFile);

import  StandardOutput;

type    tFile = bindable text;

function fileExists(filename: String): boolean;
function openFile(var f: tFile; filename: String): boolean;

end;

function fileExists;
var b: bindingtype; f: tFile;
begin
    unbind(f);
    b := binding(f);
    b.name := filename;
    bind(f, b);
    b := binding(f);
    fileExists := b.existing;
end;

function openFile;
var b: bindingtype;
begin
    unbind(f);
    b := binding(f);
    b.name := filename;
    bind(f, b);
    b := binding(f);
    openFile := b.bound;
end;

end.