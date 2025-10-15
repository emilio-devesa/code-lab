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
            SHELL_PAGE_SIZE,
            tPersonalInfo,
            tStudent,
            tEnumToString,
            tTerm, NoTerm, February, June, September, December,
            tPart, NoPart, Theory, Practice, Global,
            tGradeString,
            tGrades,
            tStudentsList,
            tGradesList
);

const   MAX_ITEMS = 100;
        TAB = chr(9);
        LF = chr(10);
        THEORY_PASSED_MINIMUM = 5.0;
        PRACTICE_PASSED_MINIMUM = 5.0;
        SHELL_PAGE_SIZE = 22;

type    tPersonalInfo = String (50);

        tStudent = record
			firstName: tPersonalInfo;
			lastName: tPersonalInfo;
			login: tPersonalInfo;
		end;

        tEnumToString = String (12);

        tTerm = (NoTerm, February, June, September, December);

        tPart = (NoPart, Theory, Practice, Global);

        tGradeString = String (4);

        tGrades = record
            login: tPersonalInfo;
            grades: array [February .. December, Theory .. Global] of record
                val: real value 0.0;
                passedIn: tTerm value NoTerm;
                hasValue: boolean value false;
            end;
        end;
        
        tStudentsList = record
            item: array [1 .. MAX_ITEMS] of tStudent;
            count: integer value 0;
        end;

        tGradesList = record
            item: array [1 .. MAX_ITEMS] of tGrades;
            count: integer value 0;
        end;


end;


end.