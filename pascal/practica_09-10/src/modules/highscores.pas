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

var highscoresList: types.tHighscoresList;

procedure Init;
function Load: boolean;
function Save: boolean;
procedure Add(var newRecord: types.tGameRecord);
procedure Print;
procedure SortBy(criteria: types.tCriteria);


end;


function Compare (var a, b: types.tGameRecord; criteria: types.tCriteria): boolean;
var result: boolean;
begin
    case criteria of
        types.Word: result := a.Word < b.Word;
        types.Player: result := a.Player <= b.Player;
        types.Attemps: result := a.Attemps < b.Attemps;
        types.DateTime: begin
            result := a.DateTime.Year < b.DateTime.Year;
            result := result and_then (a.DateTime.Month < b.DateTime.Month);
            result := result and_then (a.DateTime.Day < b.DateTime.Day);
            result := result and_then (a.DateTime.Hour < b.DateTime.Hour);
            result := result and_then (a.DateTime.Minute < b.DateTime.Minute);
            result := result and_then (a.DateTime.Second < b.DateTime.Second);
        end;
    end;
    Compare := result;
end;

procedure optimizedBubbleSort(criteria: types.tCriteria);
var i, j: integer; aux: types.tGameRecord; sorted: boolean;
begin
    j := 1;
    repeat
        sorted := true;
        for i := 1 to (highscoresList.size - j) do
            if Compare (highscoresList.item[i + 1], highscoresList.item[i], criteria)
            then begin
                aux := highscoresList.item[i];
                highscoresList.item[i] := highscoresList.item[i+1];
                highscoresList.item[i+1] := aux;
                sorted := false;
            end;
        j := j + 1;
    until (j >= highscoresList.size) or (sorted);
end;

procedure Init;
var f: types.tBinFile;
begin
    if Load
    then writeln('Highscores loaded successfully')
    else begin
        writeln('No highscores file found, starting with an empty list');
        highscoresList.size := 0;
        if Save
        then writeln('New highscores file created successfully')
        else writeln('Error creating new highscores file');
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
        writeln ('Highscores loaded from file successfully. ', highscoresList.size:0, ' records found.');
        Load := true;
    end
    else Load := false;
end;

function Save;
var f: types.tBinFile;
begin
    if files.BinFileIsBound(f, types.F_HIGHSCORES)
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
        writeln('New record added: ', newRecord.Word, ' by ', newRecord.Player, ' with id ', highscoresList.size:0);
        if Save
        then writeln ('New record added successfully.')
        else writeln ('Error saving new record to file.');
    end
    else writeln ('Highscores list is full. New record not added.');
    utils.WaitForEnter;
end;

procedure Print;
var i: integer; aux: string (80);
begin
    writeln;
    if highscoresList.size = 0
    then writeln ('No highscores to display.')
    else begin
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
    writeln;
end;

procedure SortBy;
begin
    if highscoresList.size = 0
    then writeln('No highscores to sort.')
    else begin
        case criteria of
            types.Word: writeln('Sorting by Word...');
            types.Player: writeln('Sorting by Player...');
            types.Attemps: writeln('Sorting by Attemps...');
            types.DateTime: writeln('Sorting by Date...');
        end;
        writeln('Sorting ', highscoresList.size:0, ' records');
        optimizedBubbleSort(criteria);
        Print;
    end;
    utils.WaitForEnter;
end;


end.