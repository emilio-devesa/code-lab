program Main;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md
}

import
    StandardInput;
    StandardOutput;
    Definitions qualified;
    Operations qualified;
    ConfigurationController qualified;
    StudentController qualified;
    GradesController qualified;
    ListController qualified;

var studentsList: Definitions.tStudentsList;
    gradesList: Definitions.tGradesList;

function mainMenu: integer;
var input: String (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    mainMenu := 0;
    repeat
        writeln;
        writeln('-------------------------');
        writeln('  MAIN MENU');
        writeln('-------------------------');
        writeln('1. New student');
        writeln('2. Update student');
        writeln('3. Update grades');
        writeln('4. Lists');
        writeln('5. Change configuration');
        writeln('0. Quit');
        write('Option?: ');
        readln(input);
        option := Operations.StringToInteger(input, ok);
        if ok and_then (option in [0 .. 5])
        then mainMenu := option
        else writeln('Invalid option');        
    until option in [0 .. 5];
end;

function submenuLists: integer;
var input: String (255) value '';
    option: integer value 0;
    ok: boolean value false;
begin
    submenuLists := 0;
    repeat
        writeln;
        writeln('-------------------------');
        writeln('  LISTS:');
        writeln('-------------------------');
        writeln('1. List students alphabetically');
        writeln('2. List students alphabetically and their season grades');
        writeln('3. List students and their season grades in descending order');
        writeln('0. Back');
        write('Option?: ');
        readln(input);
        option := Operations.StringToInteger(input, ok);
        if option in [0 .. 3]
        then submenuLists := option
        else writeln('Invalid option');
    until option in [0 .. 3];
end;

function start(option: integer): integer;
begin
    case (option) of
        1: { New Student } StudentController.newStudent(studentsList);
        2: { Update Student } StudentController.updateStudent(studentsList, gradesList);
        3: { Update Grades } GradesController.setGrades(studentsList, gradesList);
        4: case (submenuLists) of
                1: { List students alphabetically } ListController.listStudentsAlphabetically(studentsList);
                2: { List students alphabetically and their Season Grades } ListController.listStudentsAlphabeticallyAndSeasonGrades(studentsList, gradesList);
                3: { List students and their season grades descendentally sorted } ListController.listStudentsByDescendingSeasonGrades(studentsList, gradesList);
                0: { Return };
            end;
        5: { Change configuration } ConfigurationController.change;
        0: { Exit };
    end;
    start := option;
end;

begin
    Operations.ClearScreen;
    writeln('============================');
    writeln('  STUDENT GRADE MANAGER');
    writeln('============================');
    ConfigurationController.load;
    StudentController.loadStudents(studentsList);
    GradesController.loadGrades(gradesList);
	repeat
    until (start(mainMenu) = 0);
    writeln;
    StudentController.saveStudents(studentsList);
    GradesController.saveGrades(gradesList);
    Operations.WaitForEnter;
    Operations.ClearScreen;
end.