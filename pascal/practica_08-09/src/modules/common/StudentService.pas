module StudentService;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).

    StudentService.pas
    Provides functions to check if a student is in the list by login
}

export  StudentService = (
            checkStudentByLogin,
            promptAndCheckStudentByLogin
);

import  Definitions qualified;
        StudentController qualified;
        StudentsListModel qualified;
        StudentView qualified;


function checkStudentByLogin (var list: Definitions.tStudentsList; var login: Definitions.tPersonalInfo): boolean;
function promptAndCheckStudentByLogin(var list: Definitions.tStudentsList): boolean;

end;

function checkStudentByLogin;
begin
    StudentView.getLogin(login);
    checkStudentByLogin := (StudentsListModel.find(list, login) <> 0)
end;

function promptAndCheckStudentByLogin;
var login: Definitions.tPersonalInfo;
begin
    StudentView.getLogin(login);
    promptAndCheckStudentByLogin := checkStudentByLogin(list, login);
end;

end.

