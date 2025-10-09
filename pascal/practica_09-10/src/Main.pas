program Main;
{   Practica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md
}

import  StandardInput;
        StandardOutput;
        types qualified;
        utils qualified;
        game qualified;
        highscores qualified;
        dictionary qualified;


procedure WriteProgramHeader;
begin
    writeln;
    utils.CenterText ('**************************************');
    utils.CenterText (' Programming Exercise: Guess the Word ');
    utils.CenterText ('**************************************');
    writeln;
end;

function mainMenu: integer;
var input: string (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    mainMenu := 0;
    repeat
        writeln;
        writeln('-------------------------');
        writeln('  MAIN MENU');
        writeln('-------------------------');
        writeln ('1. Play / Validate');
        writeln ('2. Show game highscores');
        writeln ('3. Print words');
        writeln ('0. Exit');
        writeln;
        write('Option?: ');
        readln(input);
        option := utils.StringToInteger(input, ok);
        if ok and_then (option in [0 .. 3])
        then mainMenu := option
        else writeln('Invalid option');        
    until option in [0 .. 3];
end;

function SubMenuPlayValidate: integer;
var input: string (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    SubMenuPlayValidate := 0;
    repeat
        writeln;
        writeln('-------------------------');
        writeln('  GAME MENU');
        writeln('-------------------------');
        writeln ('1. Validate game');
        writeln ('2. Play');
        writeln ('0. Back');
        writeln;
        write('Option?: ');
        readln(input);
        option := utils.StringToInteger(input, ok);
        if ok and_then (option in [0 .. 2])
        then SubMenuPlayValidate := option
        else writeln('Invalid option');        
    until option in [0 .. 2];
end;

function SubMenuShowHighscores: integer;
var input: string (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    SubMenuShowHighscores := 0;
    repeat
        writeln;
        writeln('-------------------------');
        writeln('  SHOW HIGHSCORES');
        writeln('-------------------------');
        writeln ('1. Sort by word');
        writeln ('2. Sort alphabetically by player name');
        writeln ('3. Sort by number of attempts');
        writeln ('4. Sort by date, from oldest to newest');
        writeln ('0. Back');
        writeln;
        write('Option?: ');
        readln(input);
        option := utils.StringToInteger(input, ok);
        if ok and_then (option in [0 .. 4])
        then SubMenuShowHighscores := option
        else writeln('Invalid option');        
    until option in [0 .. 4];
end;

function SubMenuPrintWords: integer;
var input: string (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    SubMenuPrintWords := 0;
    repeat
        writeln;
        writeln('-------------------------');
        writeln('  PRINT WORDS');
        writeln('-------------------------');
        writeln ('1. Print words from dictionary');
        writeln ('2. Sort words from dictionary');
        writeln ('3. Print words from dictionary (two at a time)');
        writeln ('4. Print words from dictionary, sorted and two at a time');
        writeln ('0. Back');
        writeln;
        write('Option?: ');
        readln(input);
        option := utils.StringToInteger(input, ok);
        if ok and_then (option in [0 .. 4])
        then SubMenuPrintWords := option
        else writeln('Invalid option');        
    until option in [0 .. 4];
end;

function start(option: integer): integer;
begin
    case (option) of
        1:  case (SubMenuPlayValidate) of
                1: { Validate Game } game.PlayGame(true);
                2: { Play Game } game.PlayGame(false);
                0: { Return };
            end;
        2:  case (SubMenuShowHighscores) of
                1: { Sort by word } highscores.SortBy(types.Word);
                2: { Sort alphabetically by player name } highscores.SortBy(types.Player);
                3: { Sort by number of attempts } highscores.SortBy(types.Attemps);
                4: { Sort by date, from oldest to newest } highscores.SortBy(types.DateTime);
                0: { Return };
            end;
        3:  case (SubMenuPrintWords) of
                1: { Print words from dictionary } dictionary.PrintAllWords;
                2: { Sort words from dictionary } dictionary.PrintAllWordsSorted;
                3: { Print words from dictionary (two at a time) } dictionary.PrintTwoWordsInARow;
                4: { Print words from dictionary, sorted and two at a time } dictionary.PrintSortedDictionaryTwoWordsAtATime;
                0: { Return };
            end;
        0: { Exit };
    end;
    start := option;
end;

begin
    highscores.Init;
    repeat
        utils.ClearScreen;
        WriteProgramHeader;
    until (start(mainMenu) = 0);
    writeln;
end.
