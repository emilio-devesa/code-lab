module highscores;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    highscores.pas
    Provides procedures to print highscores with different sorting criteria
}


export  highscores = (
        Init,
        Load,
        Save,
        Add,
        Print,
        SortBy
);

import  StandardInput;
        StandardOutput;
        types qualified;
        utils qualified;
        files qualified; 

procedure Init (var highscoresList: types.tHighscoresList);
function Load (var highscoresList: types.tHighscoresList): boolean;
function Save (var highscoresList: types.tHighscoresList): boolean;
procedure Add (var highscoresList: types.tHighscoresList; var newRecord: types.tGameRecord);
procedure Print (var highscoresList: types.tHighscoresList);
procedure SortBy (var highscoresList: types.tHighscoresList; criteria: types.tCriteria);


end;


function Compare (var a, b: types.tGameRecord; criteria: types.tCriteria): boolean;
begin
    case criteria of
        types.Word: Compare := LE(a.Word, b.Word);
        types.Player: Compare := LE(a.Player, b.Player);
        types.Attemps: Compare := a.Attemps <= b.Attemps;
        types.DateTime: Compare := LE(Date(a.DateTime), Date(b.DateTime));
    end;
end;

procedure Quicksort (var highscoresList: types.tHighscoresList; low, high: integer; criteria: types.tCriteria);
var i, j, pivot: integer; aux: types.tGameRecord;
begin
    if low < high
    then begin
        { Choose the pivot (in this case, the middle element) }
        pivot := (low + high) div 2;
        i := low;
        j := high;
        { Partition the array into two halves }
        repeat
            while Compare(highscoresList.item[i], highscoresList.item[pivot], criteria) do i := i + 1;
            while Compare(highscoresList.item[pivot], highscoresList.item[j], criteria) do j := j - 1;
            if i <= j
            then begin
                { Swap elements and move indices }
                aux := highscoresList.item[i];
                highscoresList.item[i] := highscoresList.item[j];
                highscoresList.item[j] := aux;
                i := i + 1;
                j := j - 1;
            end;
        until i > j;
        { Recursively sort the sub-lists }
        Quicksort(highscoresList, low, j, criteria);
        Quicksort(highscoresList, i, high, criteria);
    end;
end;

procedure Init;
var f: types.tBinFile;
begin
    if Load(highscoresList)
    then writeln('Highscores loaded successfully')
    else begin
        writeln('No highscores file found, starting with an empty list');
        if files.BinFileIsBound(f, types.F_HIGHSCORES)
        then rewrite(f);
        utils.WaitForEnter;
    end;
end;

function Load;
var f: types.tBinFile;
begin
    if (files.BinFileExists(f, types.F_HIGHSCORES) and_then files.BinFileIsBound(f, types.F_HIGHSCORES))
    then begin
        reset(f);
        read(f, highscoresList);
        Load := true;
    end
    else Load := false;
end;

function Save;
var f: types.tBinFile;
begin
    if (files.BinFileExists(f, types.F_HIGHSCORES) and_then files.BinFileIsBound(f, types.F_HIGHSCORES))
    then begin
        rewrite(f);
        write(f, highscoresList);
        Save := true;
    end
    else Save := false;
end;

procedure Add;
begin
    if highscoresList.size < types.MAX_GAMES
    then begin
        highscoresList.size := highscoresList.size + 1;
        highscoresList.item[highscoresList.size] := newRecord;
        if Save(highscoresList)
        then writeln ('New record added successfully.')
        else writeln ('Error saving new record to file.');
    end
    else begin
        writeln ('Highscores list is full. New record not added.');
        writeln ('Returning to Main Menu.');
    end;
    utils.WaitForEnter;
end;

procedure Print;
var i: integer; aux: string (80);
begin
    writeln;
    writeln ('Word', types.TAB, types.TAB, 'Player', types.TAB, types.TAB, 'Attemps', types.TAB, types.TAB, 'Date');
    for i := 1 to highscoresList.size do begin
        writestr (aux, highscoresList.item[i].Word,  types.TAB, types.TAB, highscoresList.item[i].Player);
        if highscoresList.item[i].Attemps = 0
        then writestr (aux, aux, 'surrendered')
        else writestr (aux, aux,  types.TAB, types.TAB, highscoresList.item[i].Attemps:0);
        writestr (aux, aux,  types.TAB, Date(highscoresList.item[i].DateTime));
        writeln (aux);
    end;
end;

procedure SortBy;
begin
    Quicksort (highscoresList, 1, highscoresList.size, criteria);
    Print(highscoresList);
    utils.WaitForEnter;
end;


end.