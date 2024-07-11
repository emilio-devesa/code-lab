module Crypt;
{   Práctica 2007-2008
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Emilio Devesa
    https://emiliodevesa.wordpress.com/

    Crypt.pas
    Provides basic operations to crypt and decrypt text
}

import  StandardInput; StandardOutput;

end;

function cryptChar(c: char): char;
begin
    cryptChar:=succ(c);
end;

function decryptChar(c: char): char;
begin
    decryptChar:=pred(c);
end;


end.