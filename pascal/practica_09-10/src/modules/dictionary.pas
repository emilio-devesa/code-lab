module dictionary;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    dictionary.pas
    Provides access to word dictionaries and list printing
}


export  dictionary = (
            GetWord,
            PrintAllWords,
            PrintTwoWordsInARow,
            PrintAllWordsSorted
);

import  StandardInput;
        StandardOutput;
        types qualified;
        utils qualified;
        files qualified;

function GetWord (language: types.tLanguage; length: integer): types.tWord;
procedure PrintAllWords;
procedure PrintTwoWordsInARow;
procedure PrintAllWordsSorted;

end;

function OpenDictionary(var f: types.tTextFile; language: types.tLanguage): boolean;
begin
    case language of
        types.NoLang:
            OpenDictionary := false;
        types.Castillian:
            OpenDictionary := files.TextFileExists (f, types.F_CASTILLIAN) and_then files.TextFileIsBound (f, types.F_CASTILLIAN);
        types.Galician:
            OpenDictionary := files.TextFileExists (f, types.F_GALICIAN) and_then files.TextFileIsBound (f, types.F_GALICIAN);
        types.English:
            OpenDictionary := files.TextFileExists (f, types.F_ENGLISH) and_then files.TextFileIsBound (f, types.F_ENGLISH);
    end;
end;

procedure Quicksort(var l: types.tWordList; low, high: integer);
var i, j, pivot: integer; aux: types.tWord;
begin
    if low < high
    then begin
        { Choose the pivot (in this case, the middle element) }
        pivot := (low + high) div 2;
        i := low;
        j := high;
        { Partition the array into two halves }
        repeat
            while (l.item[i] <= l.item[pivot]) do i := i + 1;
            while (l.item[pivot] <= l.item[j]) do j := j - 1;
            if i <= j
            then begin
                { Swap elements and move indices }
                aux := l.item[i];
                l.item[i] := l.item[j];
                l.item[j] := aux;
                i := i + 1;
                j := j - 1;
            end;
        until i > j;
        { Recursively sort the sub-lists }
        Quicksort(l, low, j);
        Quicksort(l, i, high);
    end;
end;

function GetWord;
var f: types.tTextFile; lineNumber: integer; aux: string (17); i: integer;
begin
    if OpenDictionary(f, language)
    then begin
        reset (f);
        lineNumber := utils.GetRandomInteger(100);
        for i := 0 to lineNumber do readln (f, aux);
        case length of
            4: aux := substr(aux, 1, 4);
            5: aux := substr(aux, 6, 5);
            6: aux := substr(aux, 12, 6);
        end;
        GetWord := aux;
    end
    else GetWord := '';
end;

procedure PrintAllWords;
var language: types.tLanguage; length: integer; f: types.tTextFile; aux: string (17);
begin
    language := utils.ChooseLanguage;
    if language <> types.NoLang
    then begin
        length := utils.ChooseLength;
        if length in [4..6]
        then begin
            if OpenDictionary(f, language)
            then begin
                reset (f);
                while not eof (f) do begin
                    readln (f, aux);
                    case length of
                        4: writeln (substr (aux,  1, 4));
                        5: writeln (substr (aux,  6, 5));
                        6: writeln (substr (aux, 12, 6));
                    end;
                end;
            end;
        end;
    end;
    writeln;
    write ('Press ENTER to return to Main Menu.');
    readln;
end;

procedure PrintTwoWordsInARow;
var language: types.tLanguage; f: types.tTextFile; aux: string (17); a, b, c: types.tWord; buffer: string (17);
begin
    language := utils.ChooseLanguage;
    if language <> types.NoLang
    then begin
        if OpenDictionary(f, language)
        then begin
            reset (f);
            buffer := '';
            while not eof (f) do begin
                readln (f, aux);
                a := substr (aux,  1, 4);
                b := substr (aux,  6, 5);
                c := substr (aux, 12, 6);
                if EQ(buffer, '')
                then begin
                    writeln(a, types.TAB, b);
                    buffer := c;
                end
                else begin
                    writeln(buffer, types.TAB, a);
                    writeln(b, types.TAB, c);
                    buffer := '';
                end;
            end;
        end;
    end;
    writeln;
    write ('Press ENTER to return to Main Menu.');
    readln;
end;

procedure PrintAllWordsSorted;
var language: types.tLanguage; f: types.tTextFile; list: types.tWordList; aux: string (17); i: integer;
begin
    language := utils.ChooseLanguage;
    if language <> types.NoLang
    then begin
        if OpenDictionary(f, language)    
        then begin
            reset (f);
            i := 0;
            while not eof (f) do begin
                readln (f, aux);
                list.item[i + 1] := substr (aux,  1, 4);
                list.item[i + 2] := substr (aux,  6, 5);
                list.item[i + 3] := substr (aux, 12, 6);
                i := i + 3;
            end;
            list.size := i;
            Quicksort (list, 1, list.size);
            for i := 1 to list.size do write (list.item[i], types.TAB);
        end;
    end;
    writeln;
    write ('Press ENTER to return to Main Menu.');
    readln;
end;


end.