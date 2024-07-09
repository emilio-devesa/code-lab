module Strip;
{   Práctica 2007-2008
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Emilio Devesa
    https://emiliodevesa.wordpress.com/

    Strip.pas
    Provides operations to get the number of ocurrencies of a word in a text file
    and to write a file without word repetitions
}

export  Strip = (getOcurrencies, stripRepetitions);

import  StandardInput; StandardOutput; TextFile qualified;

function getOcurrencies(inputFile: String; token: String): integer;
procedure stripRepetitions(inputFile: String; outputFile: String);

end;

function getOcurrencies;
var pos, count: integer value 0;
    line: String(1024);
    fText: TextFile.tFile;
begin
    if (TextFile.fileExists(inputFile)) and_then (TextFile.openFile(fText, inputFile))
    then begin
        reset(fText);
        count := 0;
        while not EOF(fText) do begin
            readln(fText, line);
            repeat
                pos := index(line, ' ');
                if (pos > 0) and_then (SubStr(line, 1, pos - 1) = token) then count := count + 1;
                line := SubStr(line, pos + 1);
            until pos = 0;
        end;
        getOcurrencies := count;
    end
    else begin
        writeln('ERROR Strip.getOcurrencies(): Can´t open ', inputFile);
    end;
end;

procedure stripRepetitions;
var fInput, fOutput: TextFile.tFile;
    line, word: String(255);
    pos: integer;
begin
    if (TextFile.fileExists(inputFile)) and_then (TextFile.openFile(fInput, inputFile))
    then begin
        reset(fInput);
        if (TextFile.openFile(fOutput, outputFile))
        then begin
            rewrite(fOutput);
            while not EOF (fInput) do begin
                readln(fInput, line);
                repeat
                    pos := index(line, ' ');
                    if pos > 0 then begin
                        word := SubStr(line, 1, pos - 1);
                        if (getOcurrencies(outputFile, word) = 0)
                        then begin
                            write(fOutput, word);
                            write(fOutput, ' ');
                        end
                    end;
                    line := SubStr(line, pos + 1);
                until pos = 0;
            end;
        end
        else begin
            writeln('ERROR Strip.stripRepetitions(): Can´t open ', outputFile);
        end
    end
    else begin
        writeln('ERROR Strip.stripRepetitions(): Can´t open ', inputFile);
    end;
end;

end.