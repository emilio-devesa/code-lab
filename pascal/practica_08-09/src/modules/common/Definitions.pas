module Definitions;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Definitions.pas
    Provides definitions for constants and types
}

export  Definitions = (
            MAX_ITEMS,
            TAB,
            LF,
            THEORY_PASSED_MINIMUM, PRACTICE_PASSED_MINIMUM,
            tPersonalInfo,
            tStudent,
            tTerm, NoTerm, February, June, September, December,
            tPart, NoPart, Theory, Practice, Global,
            tGrades,
            tStudentsList,
            tGradesList,
            TermToChar, TermToString, PartToString
);

const   MAX_ITEMS = 100;
        TAB = chr(9);
        LF = chr(10);
        THEORY_PASSED_MINIMUM = 5.0;
        PRACTICE_PASSED_MINIMUM = 5.0;

type    tPersonalInfo = String (50);

        tStudent = record
			firstName: tPersonalInfo;
			lastName: tPersonalInfo;
			login: tPersonalInfo;
		end;

        tEnumToString = String (12);

        tTerm = (NoTerm, February, June, September, December);

        tPart = (NoPart, Theory, Practice, Global);

        tGrades = record
            login: tPersonalInfo;
            grades: array [February .. December, Theory .. Global] of record
                val: real value 0.0;
                passedIn: tTerm value NoTerm;
                hasValue: boolean value false;
            end;
        end;

        { LISTS }
        
        tStudentsList = record
            item: array [1 .. MAX_ITEMS] of tStudent;
            count: integer value 0;
        end;

        tGradesList = record
            item: array [1 .. MAX_ITEMS] of tGrades;
            count: integer value 0;
        end;

function TermToChar(t: tTerm): char;
function TermToString(t: tTerm): tEnumToString;
function PartToString(p: tPart): tEnumToString;

end;


function TermToChar;
begin
    case t of
        February:  TermToChar := 'f';
        June:      TermToChar := 'j';
        September: TermToChar := 's';
        December:  TermToChar := 'd';
        NoTerm:    TermToChar := ' ';
    end;
end;

function TermToString;
begin
    case t of
        NoTerm:    TermToString := 'None';
        February:  TermToString := 'February';
        June:      TermToString := 'June';
        September: TermToString := 'September';
        December:  TermToString := 'December';
    end;
end;


function PartToString;
begin
    case p of
        NoPart:     PartToString := '';
        Theory:     PartToString := 'Theory';
        Practice:   PartToString := 'Practice';
        Global:     PartToString := 'Global';
    end;
end;


end.