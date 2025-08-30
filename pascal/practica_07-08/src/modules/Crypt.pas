module Crypt;
{   Práctica 2007-2008
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Crypt.pas
    Provides basic operations to crypt and decrypt text
}

export  Crypt=(CryptFile, DecryptFile, CryptLineFromFile);

import  StandardInput; StandardOutput;
        TextFile qualified;

procedure CryptFile(inputFile: String; outputFile: String);
procedure DecryptFile(inputFile: String; outputFile: String);
procedure CryptLineFromFile(inputFile: String; lineNumber: integer; var result: String);

end;

function cryptChar(c: char): char;
begin
    cryptChar:=succ(c);
end;

function decryptChar(c: char): char;
begin
    decryptChar:=pred(c);
end;

procedure CryptLineFromFile;
var i: integer value 1;
    fText: TextFile.tFile;
    originalStr: String (1024);
begin
    if (TextFile.fileExists(inputFile)) and_then (TextFile.openFile(fText, inputFile))
    then begin
        reset(fText);
        result:='';
        while not eof(fText) and_then (i<=lineNumber) do begin
            readln(fText, originalStr);
            i:=i+1;
        end;
        for i:=1 to length(originalStr) do begin
            result:=result+(cryptChar(originalStr[i]));
        end;
    end
    else begin
        writeln('ERROR Crypt.CryptLineFromFile(): Can´t open '+inputFile);
    end;
end;

procedure CryptFile;
var fText, fCrypt: TextFile.tFile;
    c: char;
begin
    if (TextFile.fileExists(inputFile)) and_then (TextFile.openFile(fText, inputFile))
    then begin
        reset (fText);
        if (TextFile.openFile(fCrypt, outputFile))
        then begin
            rewrite(fCrypt);
            while not eof(fText) do begin
                read(fText, c);
                write(fCrypt, cryptChar(c));
            end;
        end
        else begin
            writeln('ERROR Crypt.CryptFile(): Can´t open '+outputFile);
        end
    end
    else begin
        writeln('ERROR Crypt.CryptFile(): Can´t open '+inputFile);
    end;
end;

procedure DecryptFile;
var fText, fCrypt: TextFile.tFile;
    c: char;
begin
    if (TextFile.fileExists(inputFile)) and_then (TextFile.openFile(fCrypt, inputFile))
    then begin
        reset (fCrypt);
        if (TextFile.openFile(fText, outputFile))
        then begin
            rewrite(fText);
            while not eof(fCrypt) do begin
                read(fCrypt, c);
                write(fText, decryptChar(c));
            end;
        end
        else begin
            writeln('ERROR Crypt.DeryptFile(): Can´t open '+outputFile);
        end
    end
    else begin
        writeln('ERROR Crypt.DeryptFile(): Can´t open '+inputFile);
    end;
end;

end.