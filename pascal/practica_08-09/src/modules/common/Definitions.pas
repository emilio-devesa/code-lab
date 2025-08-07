module Definitions;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Definitions.pas
    Provides definitions for constants and types
}

export  Definitions = (
            MAX_ITEMS,
            tPersonalInfo,
            tStudent,
            tGrade,
            tGrades,
            tStudentsList,
            tGradesList
);

const   MAX_ITEMS = 100;

type    tPersonalInfo = String (50);

        tStudent = record
			firstName: tPersonalInfo;
			lastName: tPersonalInfo;
			login: tPersonalInfo;
		end;

        tGrade = record
            val: real value 0.0;
            passedIn: char value ' ';  { 'f', 'j', 's', 'd', ' ' }
        end;

        tGrades = record
            login: tPersonalInfo;
            term: array [1 .. 4] of record
                theory: tGrade;
                practice: tGrade;
                global: real value 0.0;
            end;
        end;

        { LISTS }
        
        tStudentsList = record
            item: array [1 .. MAX_ITEMS] of tStudent;
            count: integer value 0;
        end;

        tGradesList = record
            item: array [1 .. MAX_ITEMS] of tStudentGrades;
            count: integer value 0
        end;


end;


end.