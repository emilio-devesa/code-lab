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
        GradesModel qualified;
        GradesListModel qualified;
        GradesController qualified;


function loginExists(var list: Definitions.tGradesList; login: Definitions.tPersonalInfo): boolean;
procedure updateLogin(var list: Definitions.tGradesList; oldLogin, newLogin: Definitions.tPersonalInfo);

end;


function loginExists;
begin
    loginExists := GradesListModel.find(list, login) > 0;
end;


procedure updateLogin;
var idx: integer;
    grades: Definitions.tGrades;
begin
    idx := GradesListModel.find(list, oldLogin);
    if (idx > 0) and_then (GradesListModel.get(list, idx, grades))
    then begin
        GradesModel.setLogin(grades, newLogin);
        if GradesListModel.put(list, idx, grades)
        then GradesController.saveGrades(list);
    end;
end;


end.