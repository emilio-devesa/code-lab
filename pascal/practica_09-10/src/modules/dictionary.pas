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
            PrintAllWordsSorted,
            PrintSortedDictionaryTwoWordsAtATime
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
procedure PrintSortedDictionaryTwoWordsAtATime;

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

function ExtractWordFromLine(line: string; long: integer; var extracted: string): boolean;
begin
    extracted := '';
    case long of
        4: if (length(line) >= 4) and_then (substr (line,  1, 4) <> '') then extracted := substr(line, 1, 4);
        5: if (length(line) >= 10) and_then (substr (line,  6, 5) <> '') then extracted := substr(line, 6, 5);
        6: if (length(line) >= 17) and_then (substr (line,  12, 6) <> '') then extracted := substr(line, 12, 6);
    end;
    ExtractWordFromLine := extracted <> '';
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
        if ExtractWordFromLine(aux, long, aux)
        then GetWord := aux
        else GetWord := '';
    end
    else GetWord := '';
end;

procedure PrintAllWords;
var finished: boolean value false; language: types.tLanguage; long: integer value 0;
    f: types.tTextFile; aux: string (17); 
begin
    language := utils.ChooseLanguage;
    if language = types.NoLang
    then finished := true;
    if not finished
    then long := utils.ChooseLength;
    if long = 0
    then finished := true;
    if not finished
    then begin
        if OpenDictionary(f, language)
        then begin
            reset (f);
            while not eof (f) do begin
                readln (f, aux);
                if ExtractWordFromLine(aux, long, aux)
                then writeln(aux);
            end;
        end
        else writeln('Could not open dictionary file.');
    end
    else writeln('Operation cancelled.');
    writeln;
    utils.WaitForEnter;
end;

procedure PrintTwoWordsInARow;
var finished: boolean value false; language: types.tLanguage; long: integer value 0;
    f: types.tTextFile; buffer, aux: string (17);
begin
    language := utils.ChooseLanguage;
    if language = types.NoLang
    then finished := true;
    if not finished
    then long := utils.ChooseLength;
    if long = 0
    then finished := true;
    if not finished
    then begin
        if OpenDictionary(f, language)
        then begin
            reset (f);
            buffer := '';
            while not eof (f) do begin
                readln (f, aux);
                if ExtractWordFromLine(aux, long, aux)
                then begin
                    if buffer = ''
                    then buffer := aux
                    else begin
                        writeln(buffer, types.TAB, aux);
                        buffer := '';
                    end;
                end;
            end;
            if buffer <> '' then writeln(buffer);
        end
        else writeln('Could not open dictionary file.');
    end
    else writeln('Operation cancelled.');
    writeln;
    utils.WaitForEnter;
end;

procedure PrintAllWordsSorted;
var finished: boolean value false; language: types.tLanguage; long, i: integer value 0;
    f: types.tTextFile; list: types.tWordList; aux: string (17);
begin
    language := utils.ChooseLanguage;
    if language = types.NoLang
    then finished := true;
    if not finished
    then long := utils.ChooseLength;
    if long = 0
    then finished := true;
    if not finished
    then begin
        if OpenDictionary(f, language)    
        then begin
            reset (f);
            i := 0;
            while not eof (f) and_then (i < 100) do begin
                readln (f, aux);
                if ExtractWordFromLine(aux, long, aux)
                then begin
                    i := i + 1;
                    list.item[i] := aux;
                end;
            end;
            list.size := i;
            if list.size > 0
            then begin
                writeln;
                writeln ('Sorting ', list.size:0, ' words...');
                Quicksort (list, 1, list.size);
                writeln ('Sorted words:');
                writeln;
                for i := 1 to list.size do begin
                    write (list.item[i], types.TAB);
                    if (i mod 5 = 0)
                    then writeln;
                end;
            end
            else writeln('No words found.');
        end
        else writeln('Could not open dictionary file.');
    end
    else writeln('Operation cancelled.');
    writeln;
    utils.WaitForEnter;
end;

procedure PrintSortedDictionaryTwoWordsAtATime;
var finished: boolean value false; language: types.tLanguage; long, i: integer value 0;
    f: types.tTextFile; list: types.tWordList; aux, buffer: string (17);
begin
    language := utils.ChooseLanguage;
    if language = types.NoLang
    then finished := true;
    if not finished
    then long := utils.ChooseLength;
    if long = 0
    then finished := true;
    if not finished
    then begin
        if OpenDictionary(f, language)    
        then begin
            reset (f);
            i := 0;
            while not eof (f) and_then (i < 100) do begin
                readln (f, aux);
                if ExtractWordFromLine(aux, long, aux)
                then begin
                    i := i + 1;
                    list.item[i] := aux;
                end;
            end;
            list.size := i;
            if list.size > 0
            then begin
                writeln;
                writeln('Sorting ', list.size:0, ' words...');
                Quicksort (list, 1, list.size);
                writeln('Sorted words (two at a time):');
                writeln;
                i := 1;
                buffer := '';
                while i <= list.size do begin
                    if EQ(buffer, '')
                    then buffer := list.item[i]
                    else begin
                        writeln(buffer, types.TAB, list.item[i]);
                        buffer := '';
                    end;
                    i := i + 1;
                end;
                if buffer <> '' then writeln(buffer);
            end
            else writeln('No words found.');
        end
        else writeln('Could not open dictionary file.');
    end
    else writeln('Operation cancelled.');
    writeln;
    utils.WaitForEnter;
end;


end.