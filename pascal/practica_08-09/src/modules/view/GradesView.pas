module GradesView;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    GradesView.pas
    Provides a view for introducing and validating grades
}


export  GradesView = (
            getTerm,
            getPart,
            getTheoryGrade,
            getPracticeGrade,
            getGlobalGrade
);

import  StandardInput;
        StandardOutput;


function getTerm: integer;
function getPart: integer;
function getTheoryGrade: real;
function getPracticeGrade: real;
function getGlobalGrade: real;

end;

function getTerm;
var option: integer;
begin
    repeat
        writeln;
        writeln('Select Term: ');
        writeln('1. February');
        writeln('2. June');
        writeln('3. September');
        writeln('4. December');
        writeln('0. Back');
        write('Option?: ');
        readln(option);
        if (option < 0) or (4 < option)
        then writeln('Invalid option');
        getTerm := option;
    until (0 <= option) and (option <= 4);
end;

function getPart;
var option: integer;
begin
    repeat
        writeln;
        writeln('Select Part: ');
        writeln('1. Theory');
        writeln('2. Practice');
        writeln('3. Global');
        writeln('0. Back');
        write('Option?: ');
        readln(option);
        if (option < 0) or (3 < option)
        then writeln('Invalid option');
        getPart := option;
    until (0 <= option) and (option <= 3);
end;

function validateGrade(g: real): boolean;
var isValid: boolean;
begin
    isValid := (g >= 0.0) and (g <= 10.0);
    if not isValid
    then writeln('Invalid grade. Please enter a value between 0.0 and 10.0, with at most one decimal.');
    validateGrade := isValid;
end;

function getTheoryGrade;
var grade: real;
begin
    repeat
        write('Enter theory grade (0.0 - 10.0): ');
        readln(grade);
    until validateGrade(grade);
    getTheoryGrade := grade;
end;

function getPracticeGrade;
var grade: real;
begin
    repeat
        write('Enter practice grade (0.0 - 10.0): ');
        readln(grade);
    until validateGrade(grade);
    getPracticeGrade := grade;
end;

function getGlobalGrade;
var grade: real;
begin
    repeat
        write('Enter exam grade (0.0 - 10.0): ');
        readln(grade);
    until validateGrade(grade);
    getGlobalGrade := grade;
end;


end.