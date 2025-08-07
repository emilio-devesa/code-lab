module StudentView;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    StudentView.pas
    Provides the view for printing or reading a student's personal information
}

export	StudentView = (
            getFirstName,
            getLastName,
            getLogin,
            print
);

import  StandardInput;
        StandardOutput;
        Definitions qualified;

procedure getFirstName(var firstName: Definitions.tPersonalInfo);
procedure getLastName(var lastName: Definitions.tPersonalInfo);
procedure getLogin(var login: Definitions.tPersonalInfo);
procedure print(firstName, lastName, login: Definitions.tPersonalInfo);

end;


procedure getFirstName;
begin
    write('Enter first name: ');
    readln(firstName);
end;

procedure getLastName;
begin
    write('Enter last name: ');
    readln(lastName);
end;

procedure getLogin;
begin
    write('Enter login: ');
    readln(login);
end;

procedure print;
begin
    writeln(firstName, ' ', lastName, ' ', login);
end;

end.