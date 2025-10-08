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

function GetWord (language: types.tLanguage; long: integer): types.tWord;
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

procedure Quicksort(var list: types.tWordList; low, high: integer);
var i, j: integer; pivot: types.tWord; aux: types.tWord;
begin
    if low < high
    then begin
        { Choose the pivot (in this case, the middle element) }
        pivot := list.item[(low + high) div 2];
        i := low;
        j := high;
        { Partition the array into two halves }
        repeat
            while list.item[i] < pivot do i := i + 1;
            while list.item[j] > pivot do j := j - 1;
            if i <= j
            then begin
                { Swap elements and move indices }
                aux := list.item[i];
                list.item[i] := list.item[j];
                list.item[j] := aux;
                i := i + 1;
                j := j - 1;
            end;
        until i > j;
        { Recursively sort the sub-lists }
        Quicksort(list, low, j);
        Quicksort(list, i, high);
    end;
end;

function GetWord;
var f: types.tTextFile; lineNumber, i: integer value 0; aux: string (17);
begin
    if OpenDictionary(f, language)
    then begin
        reset (f);
        lineNumber := utils.GetRandomInteger(100);
        while not eof (f) and_then (i <= lineNumber) do begin
            readln (f, aux);
            i := i + 1;
        end;
        case long of
            4: if (length(aux) >= 4) and_then (substr (aux,  1, 4) <> '') then aux := substr(aux, 1, 4);
            5: if (length(aux) >= 10) and_then (substr (aux,  6, 5) <> '') then aux := substr(aux, 6, 5);
            6: if (length(aux) >= 17) and_then (substr (aux,  12, 6) <> '') then aux := substr(aux, 12, 6);
        end;
        GetWord := aux;
    end
    else GetWord := '';
end;

procedure PrintAllWords;
var language: types.tLanguage; long: integer; f: types.tTextFile; aux: string (17);
begin
    language := utils.ChooseLanguage;
    if language <> types.NoLang
    then begin
        long := utils.ChooseLength;
        if long in [4..6]
        then begin
            if OpenDictionary(f, language)
            then begin
                reset (f);
                while not eof (f) do begin
                    readln (f, aux);
                    case long of
                        4: if (length(aux) >= 4) and_then (substr (aux,  1, 4) <> '') then writeln (substr (aux,  1, 4));
                        5: if (length(aux) >= 10) and_then (substr (aux,  6, 5) <> '') then writeln (substr (aux,  6, 5));
                        6: if (length(aux) >= 17) and_then (substr (aux,  12, 6) <> '') then writeln (substr (aux, 12, 6));
                    end;
                end;
            end;
        end;
    end;
    utils.WaitForEnter;
end;

procedure PrintTwoWordsInARow;
var language: types.tLanguage; long: integer; f: types.tTextFile; buffer: string (17); aux: string (17);
begin
    language := utils.ChooseLanguage;
    if language <> types.NoLang
    then begin
        long := utils.ChooseLength;
        if long in [4..6]
        then begin
            if OpenDictionary(f, language)
            then begin
                reset (f);
                buffer := '';
                while not eof (f) do begin
                    readln (f, aux);
                    if EQ(buffer, '')
                    then begin
                        case long of
                            4: if (length(aux) >= 4) and_then (substr (aux,  1, 4) <> '') then buffer := substr (aux, 1, 4);
                            5: if (length(aux) >= 10) and_then (substr (aux,  6, 5) <> '') then buffer := substr (aux, 6, 5);
                            6: if (length(aux) >= 17) and_then (substr (aux,  12, 6) <> '') then buffer := substr (aux, 12, 6);
                        end;
                    end
                    else begin
                        case long of
                            4: if (length(aux) >= 4) and_then (substr (aux,  1, 4) <> '') then writeln(buffer, types.TAB, substr (aux, 1, 4));
                            5: if (length(aux) >= 10) and_then (substr (aux,  6, 5) <> '') then writeln(buffer, types.TAB, substr (aux, 6, 5));
                            6: if (length(aux) >= 17) and_then (substr (aux,  12, 6) <> '') then writeln(buffer, types.TAB, substr (aux, 12, 6));
                        end;
                        buffer := '';
                    end;
                end;
                if buffer <> '' then writeln(buffer);
            end;
        end;
    end;
    utils.WaitForEnter;
end;

procedure PrintAllWordsSorted;
var language: types.tLanguage; long: integer; f: types.tTextFile; list: types.tWordList; aux: string (17); i: integer;
begin
    language := utils.ChooseLanguage;
    if language <> types.NoLang
    then begin
        long := utils.ChooseLength;
        if long in [4..6]
        then begin
            if OpenDictionary(f, language)    
            then begin
                reset (f);
                i := 0;
                while not eof (f) and_then (i < 100) do begin
                    readln (f, aux);
                    case long of
                        4:  if (length(aux) >= 4) and_then (substr (aux,  1, 4) <> '')
                            then begin
                                i := i + 1;
                                list.item[i] := substr (aux,  1, 4);
                            end;
                        5:  if (length(aux) >= 10) and_then (substr (aux,  6, 5) <> '')
                            then begin
                                i := i + 1;
                                list.item[i] := substr (aux,  6, 5);
                            end;
                        6:  if (length(aux) >= 17) and_then (substr (aux,  12, 6) <> '')
                            then begin
                                i := i + 1;
                                list.item[i] := substr (aux, 12, 6);
                            end;
                    end;
                end;
                list.size := i;
                if list.size > 0
                then begin
                    writeln ('Sorting ', list.size:0, ' words...');
                    Quicksort (list, 1, list.size);
                    writeln ('Sorted words:');
                    for i := 1 to list.size do begin
                        write (list.item[i], types.TAB);
                        if (i mod 5 = 0)
                        then writeln;
                    end;
                end
                else writeln('No words found.');
            end;
        end;
    end;
    utils.WaitForEnter;
end;


end.