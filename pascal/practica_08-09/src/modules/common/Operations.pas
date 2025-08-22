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
            askToContinue
);

import  StandardInput;
        StandardOutput;

procedure ClearScreen;
procedure WaitForEnter;
function askToContinue: char;


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


end.