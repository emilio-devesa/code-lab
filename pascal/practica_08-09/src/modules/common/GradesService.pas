module GradesService;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    GradesService.pas
    Provides functions to check and update logins in the grades list
}

export  GradesService = (
            loginExists,
            updateLogin
);

import  Definitions qualified;


function loginExists(var list: Definitions.tGradesList; login: Definitions.tPersonalInfo): boolean;
function updateLogin(var list: Definitions.tGradesList; oldLogin, newLogin: Definitions.tPersonalInfo): boolean;

end;


function loginExists;
var i: integer;
begin
    loginExists := false;
    for i := 1 to list.count do
        if list.item[i].login = login
        then begin
            loginExists := true;
        end;
end;


function updateLogin;
var i: integer;
    updated: boolean value false;
begin
    for i := 1 to list.count do
        if list.item[i].login = oldLogin
        then begin
            list.item[i].login := newLogin;
            updated := true;
        end;
    updateLogin := updated;
end;


end.