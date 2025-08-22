module ListView;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    ListView.pas
    Provides a view for list operations
}

export  ListView = (
            printPageHeader
        );

import  StandardInput;
        StandardOutput;
        Operations qualified;

procedure printPageHeader(message: String; page: integer);


end;


procedure printPageHeader;
begin
    Operations.ClearScreen;
    writeln('================================');
    writeln(message, ' - Page ', page:0);
    writeln('================================');
    writeln;
end;


end.