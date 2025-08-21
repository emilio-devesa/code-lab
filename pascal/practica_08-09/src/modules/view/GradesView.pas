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
            getGrade,
            printGrade,
            printGradesOfTerm
);

import  StandardInput;
        StandardOutput;
        Definitions qualified;


function getTerm: Definitions.tTerm;
function getPart: Definitions.tPart;
function getGrade(part: Definitions.tPart): real;
procedure printGrade(grade: real; passedIn: Definitions.tTerm);
procedure printGradesOfTerm(element: Definitions.tGrades; t: Definitions.tTerm);


end;

function getTerm;
var option: integer value 0;
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
        if option in [0 .. 4]
        then begin
            case option of
                1: getTerm := Definitions.February;
                2: getTerm := Definitions.June;
                3: getTerm := Definitions.September;
                4: getTerm := Definitions.December;
                0: getTerm := Definitions.NoTerm;
            end;
        end
        else writeln('Invalid option')
    until option in [0 .. 4];
end;

function getPart;
var option: integer value 0;
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
        if option in [0 .. 3]
        then begin
            case option of
                1: getPart := Definitions.Theory;
                2: getPart := Definitions.Practice;
                3: getPart := Definitions.Global;
                0: getPart := Definitions.NoPart;
            end;
        end
        else writeln('Invalid option');
    until option in [0 .. 3];
end;

function validateGrade(g: real): boolean;
var isValid: boolean;
begin
    isValid := (g >= 0.0) and (g <= 10.0);
    if not isValid
    then writeln('Invalid grade. Please enter a value between 0.0 and 10.0, with at most one decimal.');
    validateGrade := isValid;
end;

function getGrade;
var grade: real;
begin
    repeat
        write('Enter ', Definitions.PartToString(part),' grade (0.0 - 10.0): ');
        readln(grade);
    until validateGrade(grade);
    getGrade := grade;
end;

procedure printGrade;
begin
    if passedIn = Definitions.NoTerm 
    then write(grade:9:1, '  ')
    else write(grade:9:1, Definitions.TermToChar(passedIn), ' ');
end;

procedure printGradesOfTerm;
begin
    writeln('   Theory | Practice |   Global');
    if element.grades[t, Definitions.Theory].val >= 0
    then printGrade(element.grades[t, Definitions.Theory].val, element.grades[t, Definitions.Theory].passedIn);
        
    if element.grades[t, Definitions.Practice].val >= 0
    then printGrade(element.grades[t, Definitions.Practice].val, element.grades[t, Definitions.Practice].passedIn);
        
    if element.grades[t, Definitions.Global].val >= 0
    then printGrade(element.grades[t, Definitions.Global].val, element.grades[t, Definitions.Global].passedIn);
    
    writeln;
    writeln('--------------------------------');
end;


end.