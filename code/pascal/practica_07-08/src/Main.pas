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
        Strip qualified;
        Crypt qualified;
        List qualified;

const   textFileName = 'text.txt';
        statsFileName = 'information.txt';
        noRepeatedWordsFileName = 'norepetition.txt';
        cryptFileName = 'crypt.txt';
        decryptFileName = 'decrypt.txt';

{** Menus' logics **}
function mainMenu: integer;
var option: integer;
begin
    repeat
        writeln;
        writeln('MAIN MENU');
        writeln('1. Consult statistics');
        writeln('2. Examine text');
        writeln('3. Encrypt line');
        writeln('0. Quit');
        write('Option?: ');
        readln(option);
        if (option < 0) or (3 < option)
        then writeln('Opción no válida.');
        mainMenu := option;
    until(0 <= option) and (option <= 3);
end;

function submenuExamineFile: integer;
var option: integer;
begin
    repeat
        writeln;
        writeln('EXAMINE FILE:');
        writeln('1. View words arranged alphabetically');
        writeln('2. Know the number of occurrences of a word');
        writeln('0. Back');
        write('Option?: ');
        readln(option);
        if (option < 0) or (2 < option)
        then writeln('Invalid option');
        submenuExamineFile := option;
    until(0 <= option) and (option <= 2);
end;

{** Operations **}
procedure populateListFromFile(inputFile: String; var l: List.tList);
var fText: TextFile.tFile;
    inputString: String(1024);
    pos: integer;
    word: String(1024);
begin
    if (TextFile.fileExists(inputFile)) and_then (TextFile.openFile(fText, inputFile))
    then begin
        reset(fText);
        readln(fText, inputString);
        inputString := Trim(inputString);
        repeat
            pos := index(inputString, ' ');
            word := '';
            { Only one word }
            if (pos = 0)
            then begin
                word := inputString;
                inputString := '';
            end
            { More words }
            else begin
                { Make sure strings don't start with a blank space }
                if (pos > 1)
                then word := SubStr(inputString, 1, pos-1);
                inputString := SubStr(inputString, pos+1);
            end;
            if (word <> '') then List.add(l, word);
        until inputString = '';
    end
    else begin
        writeln('ERROR Main(): Can´t open '+inputFile);
    end;
end;
procedure printSortedWords;
var l: List.tList;
begin
    writeln('Creating list...');
    List.init(l);
    writeln('Populating list...');
    populateListFromFile(noRepeatedWordsFileName, l);
    writeln('Sorting list...');
    List.sort(l);
    List.print(l);
    writeln;
end;

procedure printOcurrencesOfWord;
var searchWord: String(1024);
begin
    write('Type word: ');
    readln(searchWord);
    writeln('Ocurrences: ', Strip.getOcurrences(textFileName, searchWord));
end;

procedure cryptString;
var lineNumber: integer; cryptedStr: String (1024);
begin
    write('Type line number: ');
    readln(lineNumber);
    Crypt.CryptLineFromFile(textFileName, lineNumber, cryptedStr);
    writeln(cryptedStr);
end;

function start(option: integer): integer;
begin
    case (option) of
        1: Stats.printStats(statsFileName);
        2: case (submenuExamineFile) of
                1: printSortedWords;
                2: printOcurrencesOfWord;
                0: {return};
            end;
        3: cryptString;
        0: {exit};
    end;
    start := option;
end;

begin
    writeln('Creating statistics from ',textFileName,'...');
    Stats.getStats(textFileName, statsFileName);
    writeln('Deletion of repeated elements...');
    Strip.stripRepetitions(textFileName, noRepeatedWordsFileName);
    writeln('Encrypting file ',noRepeatedWordsFileName,'...');
    Crypt.CryptFile(noRepeatedWordsFileName, cryptFileName);
    writeln('Decrypting file ',cryptFileName,'...');
    Crypt.DecryptFile(cryptFileName, decryptFileName);
    repeat
    until (start(mainMenu)=0);
end.