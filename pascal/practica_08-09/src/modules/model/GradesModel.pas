module GradesModel;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    GradesModel.pas
    Provides the model for the grades
}

export	GradesModel = (
            setLogin,
            setTheoryGrade,
            setPracticeGrade,
            setGlobalGrade,
            getLogin,
            getTheoryGrade,
            getPracticeGrade,
            getGlobalGrade
);

import  Definitions qualified;

procedure setLogin(var grades: Definitions.tGrades; login: Definitions.tPersonalInfo);
procedure setTheoryGrade(var grades: Definitions.tGrades; i: integer; grade: Definitions.tGrade);
procedure setPracticeGrade(var grades: Definitions.tGrades; i: integer; grade: Definitions.tGrade);
procedure setGlobalGrade(var grades: Definitions.tGrades; i: integer; grade: real);
function getLogin(grades: Definitions.tGrades): Definitions.tPersonalInfo;
function getTheoryGrade(grades: Definitions.tGrades; i: integer): Definitions.tGrade;
function getPracticeGrade(grades: Definitions.tGrades; i: integer): Definitions.tGrade;
function getGlobalGrade(grades: Definitions.tGrades; i: integer): real;


end;


procedure setLogin;
begin
	grades.login := login;
end;

procedure setTheoryGrade;
begin
    grades.term[i].theory := grade;
end;

procedure setPracticeGrade;
begin
    grades.term[i].practice := grade;
end;

procedure setGlobalGrade;
begin
    grades.term[i].global := grade;
end;

function getLogin;
begin
	getLogin := grades.login;
end;

function getTheoryGrade;
begin
    getTheoryGrade := grades.term[i].theory;
end;

function getPracticeGrade;
begin
    getPracticeGrade := grades.term[i].practice;
end;

function getGlobalGrade;
begin
    getGlobalGrade := grades.term[i].global;
end;


end.