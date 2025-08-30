module GradesModel;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    GradesModel.pas
    Provides the model for the element
}

export	GradesModel = (
            setLogin,
            getLogin,
            setGrade,
            getGrade
);

import  Definitions qualified;

procedure setLogin(var element: Definitions.tGrades; login: Definitions.tPersonalInfo);
function getLogin(element: Definitions.tGrades): Definitions.tPersonalInfo;
procedure setGrade(var element: Definitions.tGrades; term: Definitions.tTerm; part: Definitions.tPart; val: real; passedIn: Definitions.tTerm; hasValue: boolean);
function getGrade(element: Definitions.tGrades; term: Definitions.tTerm; part: Definitions.tPart; var passedIn: Definitions.tTerm; var hasValue: boolean): real;


end;


procedure setLogin;
begin
	element.login := login;
end;

function getLogin;
begin
	getLogin := element.login;
end;

procedure setGrade;
begin
    element.grades[term, part].val := val;
    element.grades[term, part].passedIn := passedIn;
    element.grades[term, part].hasValue := true;
end;

function getGrade;
begin
    getGrade := element.grades[term, part].val;
    passedIn := element.grades[term, part].passedIn;
    hasValue := element.grades[term, part].hasValue;
end;


end.