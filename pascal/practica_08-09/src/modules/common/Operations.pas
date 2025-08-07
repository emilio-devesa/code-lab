module Operations;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Operations.pas
    Provides common operations
}


export  Operations = (
            ClearScreen,
            WaitForEnter
);


import  StandardInput;
        StandardOutput;


procedure ClearScreen;
procedure WaitForEnter;
end;


{** Output text user interface operations **}

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

end.