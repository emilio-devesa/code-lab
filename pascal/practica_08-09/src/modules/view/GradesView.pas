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
            printPreviousGrade,
            printGradesOfTerm
);

import  StandardInput;
        StandardOutput;
        Definitions qualified;
        Operations qualified;

function getTerm: Definitions.tTerm;
function getPart: Definitions.tPart;
procedure printGrade(grade: real; passedIn: Definitions.tTerm; hasValue: boolean);
procedure printPreviousGrade(val: real; isPassed: Definitions.tTerm);
function getGrade(part: Definitions.tPart): Definitions.tGradeString;
procedure printGradesOfTerm(element: Definitions.tGrades; t: Definitions.tTerm);


end;


function getTerm;
var input: String (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    getTerm := Definitions.NoTerm;
    repeat
        writeln;
        writeln('Select Term: ');
        writeln('1. February');
        writeln('2. June');
        writeln('3. September');
        writeln('4. December');
        writeln('0. Back');
        write('Option?: ');
        readln(input);
        option := Operations.StringToInteger(input, ok);
        if ok and_then (option in [0 .. 4])
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
var input: String (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    getPart := Definitions.NoPart;
    repeat
        writeln;
        writeln('Select Part: ');
        writeln('1. Theory');
        writeln('2. Practice');
        writeln('3. Global');
        writeln('0. Back');
        write('Option?: ');
        readln(input);
        option := Operations.StringToInteger(input, ok);
        if ok and_then (option in [0 .. 3])
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

procedure printGrade;
var msg: String (12);
    padding: integer value 9;
begin
    if hasValue
    then begin
        if (round(grade) = grade)
        then writeStr(msg, grade:padding:0)
        else writeStr(msg, grade:padding:1);
        if passedIn = Definitions.NoTerm 
        then writeStr(msg, msg+'  ')
        else begin
            writeStr(msg, grade:padding-1:1);
            writeStr(msg, msg+(Operations.TermToChar(passedIn)));
            writeStr(msg, msg+'  ');
        end;
    end
    else msg := '       --  ';
    write(msg);
end;

procedure printPreviousGrade;
begin
    writeln('Previous grade: ', val:3:1, Operations.TermToChar(isPassed));
end;

function getGrade;
var input: String(4);
begin
    write('Enter ', Operations.PartToString(part),' grade (0.0 - 10.0) or leave blank to go back: ');
    readln(input);
    getGrade := input;
end;

procedure printGradesOfTerm;
begin
    writeln('--------------------------------');
    writeln('   Theory | Practice |   Global');
    with element.grades[t, Definitions.Theory] do begin
        if (val >= 0)
        then printGrade(val, passedIn, hasValue)
    end;
    with element.grades[t, Definitions.Practice] do begin
        if (val >= 0)
        then printGrade(val, passedIn, hasValue)
    end;
    with element.grades[t, Definitions.Global] do begin
        if (val >= 0)
        then printGrade(val, passedIn, hasValue)
    end;
    writeln;
end;


end.