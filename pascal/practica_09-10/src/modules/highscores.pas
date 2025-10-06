module highscores;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    highscores.pas
    Provides procedures to print highscores with different sorting criteria
}


export  highscores = (
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

procedure Load (var highscoresList: types.tHighscoresList);
procedure Save (var highscoresList: types.tHighscoresList);
procedure Add (var highscoresList: types.tHighscoresList; newRecord: types.tGameRecord);
procedure Print (var highscoresList: types.tHighscoresList);
procedure SortBy (var highscoresList: types.tHighscoresList; criteria: types.tCriteria);

end;


function Compare (a, b: types.tGameRecord; criteria: types.tCriteria): boolean;
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

procedure Load;
var f: types.tBinFile;
begin
    if (files.BinFileExists(f, types.F_HIGHSCORES) and_then files.BinFileIsBound(f, types.F_HIGHSCORES))
    then begin
        reset(f);
        read(f, highscoresList);
    end
    else begin
        if utils.PrintError('Can not open the file.')
        then begin
            write('Returning to Main Menu. Press ENTER');
            readln;
        end
        else begin
            writeln('Execution aborted');
            halt;
        end;
    end;
end;

procedure Save;
var f: types.tBinFile;
begin
    if (files.BinFileExists(f, types.F_HIGHSCORES) and_then files.BinFileIsBound(f, types.F_HIGHSCORES))
    then begin
        rewrite(f);
        write(f, highscoresList);
    end
    else begin
        if utils.PrintError('Can not open the file.')
        then begin
            write('Returning to Main Menu. Press ENTER');
            readln;
        end
        else begin
            writeln('Execution aborted');
            halt;
        end;
    end;
end;

procedure Add;
begin
    if highscoresList.size < MAXINT
    then begin
        highscoresList.size := highscoresList.size + 1;
        highscoresList.item[highscoresList.size] := newRecord;
    end
    else begin
        writeln ('Highscores list is full. New record not added.');
        write ('Returning to Main Menu. Press ENTER.');
        readln;
    end;
end;

procedure Print;
var gameRecord: types.tGameRecord; i: integer; aux: string (80);
begin
    writeln;
    writeln ('Word', types.TAB, types.TAB, 'Player', types.TAB, types.TAB, 'Attemps', types.TAB, types.TAB, 'Date');
    for i := 1 to highscoresList.size do begin
        gameRecord := highscoresList.item[i];
        writestr (aux, gameRecord.Word,  types.TAB, types.TAB, gameRecord.Player);
        if gameRecord.Attemps = 0
        then writestr (aux, aux, 'surrendered')
        else writestr (aux, aux,  types.TAB, types.TAB, gameRecord.Attemps:0);
        writestr (aux, aux,  types.TAB, Date(gameRecord.DateTime));
        writeln (aux);
    end;
end;

procedure SortBy;
begin
    Quicksort (highscoresList, 1, highscoresList.size, criteria);
    Print(highscoresList);
    writeln;
    write ('Returning to Main Menu. Press ENTER.');
    readln;
end;


end.