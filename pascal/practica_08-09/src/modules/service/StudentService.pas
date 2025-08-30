module StudentService;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    StudentService.pas
    Provides functions to check if a student is in the list by login
}

export  StudentService = (
            checkStudentByLogin
);

import  Definitions qualified;
        StudentsListModel qualified;
        StudentView qualified;

function checkStudentByLogin(var list: Definitions.tStudentsList; var login: Definitions.tPersonalInfo): boolean;


end;


function checkStudentByLogin;
begin
    StudentView.getLogin(login);
    checkStudentByLogin := StudentsListModel.find(list, login) <> 0;
end;


end.

