module Stats;
{   Práctica 2007-2008
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Emilio Devesa
    https://emiliodevesa.wordpress.com/

    Stats.pas
    Provides statistic operations to count words, lines and pages.
    This module also extracts first and last word of each line
}

export  Stats = (getStats, printStats);

import  StandardInput; StandardOutput;
        TextFile qualified;

const   TAB = chr(9); PAGEBREAK = chr(12);

procedure getStats(inputFile: String; outputFile: String);
procedure printStats(statsFile: String);

end;

function getWordCount(inputString: String): integer;
var pos: integer;
    total: integer value 0;
begin
    repeat
        pos := index(inputString, ' ');
        inputString := SubStr(inputString, pos+1);
        if inputString <> ' ' then total := total+1;
    until (pos = 0);
    getWordCount := total;
end;

procedure getStats;
var textLine: String(1024);
    pageCount, lineCount, wordCount, position: integer;
    firstWord, lastWord: String(1024);
    fTxt, fStats: TextFile.tFile;
    statsLine: String(1024);
begin
    if (TextFile.fileExists(inputFile)) and_then (TextFile.openFile(fTxt, inputFile))
    then begin
        reset(fTxt);
        if (TextFile.openFile(fStats, outputFile))
        then begin
            rewrite(fStats);
            pageCount := 1; lineCount := 1; wordCount := 0;
            while not EOF(fTxt) do begin
                readln(fTxt, textLine);
                wordCount := getWordCount(textLine);
                if (wordCount > 0) then begin
                    if (index(textLine, ' ') > 0) then firstWord := SubStr(textLine, 1, index(textLine, ' ') - 1);
                    lastWord := textLine;
                    repeat
                        position := index(lastWord,' ');
                        if (position > 0) then lastWord := SubStr(lastWord, position + 1);
                    until (position = 0);
                    writeStr(statsLine, firstWord, TAB, lineCount:0, TAB, pageCount:0, TAB, wordCount:0, TAB, lastWord);
                    writeln(fStats, statsLine);
                end;                
                if (index(textLine,PAGEBREAK) > 0) then pageCount := pageCount + 1;
                lineCount := lineCount + 1;
                wordCount := 0; firstWord := ''; lastWord := '';
            end;
        end
        else begin
            writeln('ERROR Stats.Stats(): Can´t open ' + outputFile);
        end
    end
    else begin
        writeln('ERROR Stats.Stats(): Can´t open ' + inputFile);
    end;
end;

procedure printStats;
var fStats: TextFile.tFile;
    statsLine: String(1024);
begin
    if (TextFile.fileExists(statsFile)) and_then (TextFile.openFile(fStats, statsFile))
    then begin
        reset(fStats);
        while not EOF(fStats) do begin
            readln(fStats, statsLine);
            writeln(statsLine);
        end;
    end
    else begin
        writeln('ERROR Stats.printStats(): Can´t open ' + statsFile);
    end;
end;

end.