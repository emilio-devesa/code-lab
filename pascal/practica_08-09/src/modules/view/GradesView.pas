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

type    tReadStr = String (3);

function getTerm: Definitions.tTerm;
function getPart: Definitions.tPart;
procedure printGrade(grade: real; passedIn: Definitions.tTerm; hasValue: boolean);
procedure printPreviousGrade(val: real; isPassed: Definitions.tTerm);
procedure getGrade(term: Definitions.tTerm; part: Definitions.tPart; var val: real; var passedIn: Definitions.tTerm; var hasValue: boolean);
procedure printGradesOfTerm(element: Definitions.tGrades; t: Definitions.tTerm);


end;

function getTerm;
var option: integer value 0;
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
    getPart := Definitions.NoPart;
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

function validateGrade(input: tReadStr; var val: real): boolean;
var isValid: boolean value true;
    i, decimalPos, decimalCount: integer value -1;
begin
    val := -1.0;
    decimalPos := -1;
    { Check valid digits }
    for i := 1 to Length(input) do isValid := isValid and (input[i] in ['0'..'9', '.']);
    { Check decimal point }
    for i := 1 to Length(input) do begin
        if (input[i] = '.')
        then begin
            if (decimalPos < 0)
            then decimalPos := i
            else isValid := false; { More than one decimal point }
        end;
    end;
    { Check decimals }
    if (isValid)
    then begin
        if (decimalPos in [0 .. (Length(input))])
        then decimalCount := Length(input) - decimalPos;
        if decimalCount > 1
        then isValid := false; { More than one decimal number }
    end;
    { Read String as real }
    if (isValid)
    then readstr(input, val);
    { Return }
    validateGrade := (isValid) and ((val >= 0.0) and (val <= 10.0));
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
            writeStr(msg, msg+(Definitions.TermToChar(passedIn)));
            writeStr(msg, msg+'  ');
        end;
    end
    else msg := '       --  ';
    write(msg);
end;

procedure printPreviousGrade;
begin
    writeln('Previous grade: ', val:3:1, Definitions.TermToChar(isPassed));
end;

procedure getGrade;
var input: tReadStr;
    isValid: boolean value false;
begin
    if hasValue
    then printPreviousGrade(val, term);
    repeat
        write('Enter ', Definitions.PartToString(part),' grade (0.0 - 10.0) or leave blank to go back: ');
        readln(input);
        if (eq(input, ''))
        then hasValue := false
        else begin
            hasValue := true;
            isValid := validateGrade(input, val);
            if not isValid
            then writeln('Invalid grade. Please enter a value between 0.0 and 10.0, with at most one decimal.');
        end;
    until isValid or (not hasValue);
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
    {
    if element.grades[t, Definitions.Theory].val >= 0
    then printGrade(element.grades[t, Definitions.Theory].val, element.grades[t, Definitions.Theory].passedIn);
    }
    {    
    if element.grades[t, Definitions.Practice].val >= 0
    then printGrade(element.grades[t, Definitions.Practice].val, element.grades[t, Definitions.Practice].passedIn, false);
        
    if element.grades[t, Definitions.Global].val >= 0
    then printGrade(element.grades[t, Definitions.Global].val, element.grades[t, Definitions.Global].passedIn, false);
    }
    writeln;
end;


end.