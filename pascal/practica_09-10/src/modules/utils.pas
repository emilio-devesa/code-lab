module utils;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    utils.pas
    Provides common procedures and functions
}


export  utils = (
            GetRandomInteger,
            Confirm,
            ClearScreen,
            CenterText,
            PrintError, 
            PrintFatalError,
            EnMinuscula, EnMayuscula,
            StringToInteger,
            ChooseLanguage,
            ChooseLength,
            LanguageToInteger
);

import  StandardInput;
        StandardOutput;
        types qualified;

function GetRandomInteger (max: integer): integer;
function Confirm: boolean;
procedure ClearScreen;
procedure CenterText (s: string);
function PrintError (error: string): boolean;
procedure PrintFatalError (error: string);
function EnMinuscula (c: char): char;
function EnMayuscula (c: char): char;
function StringToInteger(input: string; var ok: boolean): integer;
function ChooseLanguage: types.tLanguage;
function ChooseLength: integer;
function LanguageToInteger (language: types.tLanguage): integer;


end;


function GetRandomInteger;
var ts: TimeStamp; seed: integer;
begin
    GetTimeStamp (ts);
    seed := (1103515245 * (ts.MicroSecond + ts.Second * 1000000) + 12345) mod 2147483648;
    GetRandomInteger := (seed) mod max;
end;

function Confirm;
var option: char;
begin
    repeat
        write ('Confirm? (y/n): ');
        readln (option);
        Confirm := option in ['Y', 'y'];
    until option in ['Y', 'y', 'N', 'n'];
end;

{ Clears screen using ANSI escape code }
procedure ClearScreen;
begin
    write(chr(27)+'[2J');  (* Clear screen *)
    write(chr(27)+'[H');   (* Move cursor to top-left *)
end;

procedure CenterText;
var spaces, i: integer;
begin
    spaces := (80 - length(s)) div 2;
    for i := 1 to spaces do
        write(' ');
    writeln(s);
end;

function PrintError;
begin
    writeln ('Error: ', error);
    write ('Confirm to continue. ');
    if Confirm
    then PrintError := true
    else PrintError := false;
end;

procedure PrintFatalError;
begin
    writeln ('Fatal error: ', error);
    writeln ('Execution aborted.');
    halt;
end;

function EnMinuscula;
type tCMayusculas = set of 'A' .. 'Z';
var cMay: tCMayusculas;
begin
    if c in cMay
    then EnMinuscula := chr(ord(c)+32)
    else EnMinuscula := c;
end;

function EnMayuscula;
type tCMinusculas = set of 'a' .. 'z';
var cmin: tCMinusculas;
begin
    if c in cmin
    then EnMayuscula := chr(ord(c)-32)
    else EnMayuscula := c;
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

function ChooseLanguage;
var input: string (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    ChooseLanguage := types.NoLang;
    repeat
        writeln;
        writeln ('Choose language:');
        writeln ('1. Castillian');
        writeln ('2. Galician');
        writeln ('3. English');
        writeln ('0. Back');
        writeln;
        write ('Option?: ');
        readln (input);
        option := StringToInteger(input, ok);
        if ok and_then (option in [0 .. 3])
        then begin
            case option of
                0: ChooseLanguage := types.NoLang;
                1: ChooseLanguage := types.Castillian;
                2: ChooseLanguage := types.Galician;
                3: ChooseLanguage := types.English;
            end;
        end
        else writeln('Invalid option');        
    until option in [0 .. 3];
end;

function ChooseLength;
var input: string (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    ChooseLength := 0;
    repeat
        writeln;
        writeln ('Choose word length:');
        writeln ('1. 4 letters');
        writeln ('2. 5 letters');
        writeln ('3. 6 letters');
        writeln ('0. Back');
        writeln;
        write ('Option?: ');
        readln (input);
        option := StringToInteger(input, ok);
        if ok and_then (option in [0 .. 3])
        then begin
            case option of
                1: ChooseLength := 4;
                2: ChooseLength := 5;
                3: ChooseLength := 6;
                0: ChooseLength := 0;
            end;
        end
        else writeln('Invalid option');        
    until option in [0 .. 3];
end;

function LanguageToInteger;
begin
    case language of
        types.NoLang: LanguageToInteger := 0;
        types.Castillian: LanguageToInteger := 1;
        types.Galician: LanguageToInteger := 2;
        types.English: LanguageToInteger := 3;
    end;
end;


end.