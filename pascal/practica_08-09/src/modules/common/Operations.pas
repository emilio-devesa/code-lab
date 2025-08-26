module Operations;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Operations.pas
    Provides common operations
}

export  Operations = (
            ClearScreen,
            WaitForEnter,
            askToContinue,
            TermToChar,
            TermToString,
            PartToString,
            StringToInteger
);

import  StandardInput;
        StandardOutput;
        Definitions qualified;

procedure ClearScreen;
procedure WaitForEnter;
function askToContinue: char;
function TermToChar(t: Definitions.tTerm): char;
function TermToString(t: Definitions.tTerm): Definitions.tEnumToString;
function PartToString(p: Definitions.tPart): Definitions.tEnumToString;
function StringToInteger(input: String; var ok: boolean): integer;


end;


{ Clears screen using ANSI escape code }
procedure ClearScreen;
begin
    write(chr(27)+'[2J');  (* Clear screen *)
    write(chr(27)+'[H');   (* Move cursor to top-left *)
end;

{ Pause and wait for user to press ENTER }
procedure WaitForEnter;
begin
    write('Press ENTER to continue...');
    readln;
end;

function askToContinue;
var input: String(1);
    key: char;
begin
    repeat
        write('Press SPACE to continue, Q to quit: ');
        readln(input);
        if length(input) = 0
        then key := chr(0)   { ningún carácter introducido }
        else key := input[1];
    until (key in [' ','q','Q']);
    askToContinue := key;
end;

function TermToChar;
begin
    case t of
        Definitions.February:  TermToChar := 'f';
        Definitions.June:      TermToChar := 'j';
        Definitions.September: TermToChar := 's';
        Definitions.December:  TermToChar := 'd';
        Definitions.NoTerm:    TermToChar := ' ';
    end;
end;

function TermToString;
begin
    case t of
        Definitions.NoTerm:    TermToString := 'None';
        Definitions.February:  TermToString := 'February';
        Definitions.June:      TermToString := 'June';
        Definitions.September: TermToString := 'September';
        Definitions.December:  TermToString := 'December';
    end;
end;

function PartToString;
begin
    case p of
        Definitions.NoPart:     PartToString := '';
        Definitions.Theory:     PartToString := 'Theory';
        Definitions.Practice:   PartToString := 'Practice';
        Definitions.Global:     PartToString := 'Global';
    end;
end;

function StringToInteger;
var
    i, sign, val: integer;
    ch: char;
begin
    val := 0;
    sign := 1;
    ok := false;
    StringToInteger := -1;
    i := 1;
    { Check sign }
    if (length(input) > 0) then if (input[i] = '-') then
    begin
        sign := -1;
        i := i + 1;
    end
    else if input[i] = '+' then
        i := i + 1;
    { Parse characters and calculate the number }
    while i <= length(input) do
    begin
        ch := input[i];
        val := val * 10 + (ord(ch) - ord('0'));
        i := i + 1;
    end;
    if (length(input) > 0) then begin
        StringToInteger := sign * val;
        ok := true;
    end;
end;


end.