module GradesController;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).

    GradesController.pas
    Provides the controller for the grades model
}

export	GradesController = (
            loadGrades,
            saveGrades,
            setGrades
);

import  StandardOutput;
        Definitions qualified;
        GradesModel qualified;
        GradesListModel qualified;
        GradesView qualified;
        GradesPersistence qualified;
        StudentService qualified;

procedure loadGrades(var gradesList: Definitions.tGradesList);
procedure saveGrades(var gradesList: Definitions.tGradesList);
procedure setGrades(var studentsList: Definitions.tStudentsList; var gradesList: Definitions.tGradesList);


end;

procedure loadGrades;
begin
    if GradesPersistence.loadFromFile(gradesList)
    then writeln('Grades loaded successfully.')
    else writeln('Grades could not be loaded.');
end;

procedure saveGrades;
begin
    if GradesPersistence.saveToFile(gradesList)
    then writeln('Grades saved successfully.')
    else writeln('Grades could not be saved.');
end;

procedure inputGradesLoop(var grades: Definitions.tGrades);
var term, part: integer;
begin
    repeat
        term := GradesView.getTerm;
        if term <> 0
        then begin
            part := GradesView.getPart;
            if part <> 0
            then begin
                case part of
                    1: begin
                        writeln ('Previous grade: ', grades.term[term].theory.val:3:2, grades.term[term].theory.passedIn);
                        grades.term[term].theory.val := GradesView.getTheoryGrade;
                    end;
                    2: begin
                        writeln ('Previous grade: ', grades.term[term].practice.val:3:2, grades.term[term].practice.passedIn);
                        grades.term[term].practice.val := GradesView.getPracticeGrade;
                    end;
                    3: begin
                        writeln ('Previous grade: ', grades.term[term].global:3:2);
                        grades.term[term].global := GradesView.getGlobalGrade;
                    end;
                end;
            end;
        end;
    until (term = 0);
end;

procedure setGrades;
var login: Definitions.tPersonalInfo;
    idx: integer;
    preexistingGrades: boolean value false;
    grades: Definitions.tGrades;
begin
    if StudentService.checkStudentByLogin(studentsList, login)
    then begin
        idx := GradesListModel.find(gradesList, login);
        if idx > 0
        then preexistingGrades := GradesListModel.get(gradesList, idx, grades);
        
        if preexistingGrades
        then writeln('Updating grades for student: ', login)
        else writeln('Setting grades for new student: ', login);

        inputGradesLoop(grades);
        GradesModel.setLogin(grades, login);
        if (preexistingGrades)
        then begin
            if GradesListModel.put(gradesList, idx, grades)
            then writeln('Grades updated successfully.');
        end
        else begin 
            if GradesListModel.add(gradesList, grades)
            then writeln('Grades saved successfully.');
        end;
    end
    else writeln('Student not found.');
    if GradesPersistence.saveToFile(gradesList)
    then writeln('Grades saved to file.')
    else writeln('Grades could not be saved to file.');
end;


end.