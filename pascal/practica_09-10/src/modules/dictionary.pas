module dictionary;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    dictionary.pas
    Provides access to word dictionaries and list printing
}


export  dictionary = (
            GetWord,
            PrintDictionary
);

import  StandardInput;
        StandardOutput;
        types qualified;
        utils qualified;
        files qualified;
        pager qualified;

function GetWord (language: types.tLanguage; long: integer): types.tWord;
procedure PrintDictionary(listName: string; sorted: boolean; wordsInRow: integer);

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

function PopulateListFromDictionary(var list: types.tWordList; language: types.tLanguage; long: integer): boolean;
var f: types.tTextFile; aux: string (17); i: integer value 0;
begin
    list.size := 0;
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
        PopulateListFromDictionary := list.size > 0;
    end
    else PopulateListFromDictionary := false;
end;

procedure SortList(var list: types.tWordList);
begin
    if list.size > 1
    then Quicksort (list, 1, list.size);
end;


procedure PrintListHeader(listName: string; pageNumber: integer);
begin
    writeln('-------------------------');
    writeln (' ', listName, ' - Page ', pageNumber:0);
    writeln('-------------------------');
    writeln;
end;

procedure PrintPaginatedList(listName: string; var list: types.tWordList; itemsPerLine: integer; pageSize: integer);
var i, res: integer; pageNumber: pager.tPager; buffer: string (17);
begin
    if (list.size > 0) and_then (itemsPerLine > 0) and_then (pageSize > 0)
    then begin
        pager.PagerInit(pageNumber, pageSize);
        { first page header }
        PrintListHeader(listName, pager.PagerPageNumber(pageNumber));
        i := 1;
        buffer := '';
        while (i <= list.size) do begin
            if EQ(buffer, '')
            then buffer := list.item[i]
            else writestr(buffer, buffer, types.TAB, list.item[i]);
            if (i mod itemsPerLine = 0)
            then begin
                writeln(buffer);
                buffer := '';
                res := pager.PagerConsume(pageNumber, 1);
                if res = 1
                then PrintListHeader(listName, pager.PagerPageNumber(pageNumber));
            end;
            i := i + 1;
        end;
        if buffer <> '' then writeln(buffer);
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
        if ExtractWordFromLine(aux, long, aux)
        then GetWord := aux
        else GetWord := '';
    end
    else GetWord := '';
end;

procedure PrintDictionary;
var finished: boolean value false; language: types.tLanguage; long: integer value 0; list: types.tWordList;
begin
    language := utils.ChooseLanguage;
    if language <> types.NoLang
    then long := utils.ChooseLength;
    finished := (language = types.NoLang) or (long = 0);

    if not finished
    then begin
        if PopulateListFromDictionary(list, language, long)
        then begin
            if sorted
            then begin
                writeln;
                writeln('Sorting ', list.size:0, ' words...');
                writeln;
                SortList(list);
            end;
            PrintPaginatedList(listName, list, wordsInRow, types.PAGE_SIZE);
        end
        else writeln('No words found.');
    end;
    
    writeln;
    utils.WaitForEnter;
end;


end.