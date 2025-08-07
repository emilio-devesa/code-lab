module StudentModel;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    StudentModel.pas
    Provides the model for the students
}

export	StudentModel = (
            setFirstName,
            setLastName,
            setLogin,
            getFirstName,
            getLastName,
            getLogin
);

import  Definitions;

procedure setFirstName(var student: tStudent; firstName: tPersonalInfo);
procedure setLastName(var student: tStudent; lastName: tPersonalInfo);
procedure setLogin(var student: tStudent; login: tPersonalInfo);
function getFirstName(student: tStudent): tPersonalInfo;
function getLastName(student: tStudent): tPersonalInfo;
function getLogin(student: tStudent): tPersonalInfo;


end;


procedure setFirstName;
begin
	student.firstName := firstName;
end;

procedure setLastName;
begin
	student.lastName := lastName;
end;

procedure setLogin;
begin
	student.login := login;
end;

function getFirstName;
begin
    getFirstName := student.firstName;
end;

function getLastName;
begin
    getLastName := student.lastName;
end;

function getLogin;
begin
	getLogin := student.login;
end;


end.