module GradesController;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).

    GradesController.pas
    Provides the controller for the grades model
}

export	GradesController = (
            gradesList,
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

var     gradesList: Definitions.tGradesList;

procedure loadGrades;
procedure saveGrades;
procedure setGrades;

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
    grades: Definitions.tGrades;
    idx: integer;
begin
    if StudentService.checkStudentByLogin(login)
    then begin
        idx := GradesListModel.find(gradesList, login);
        if (idx = 0) and (GradesListModel.getCount(gradesList) < Definitions.MAX_ITEMS)
        then begin
            inputGradesLoop(grades);
            if GradesListModel.add(gradesList, grades)
            then writeln ('Grades saved successfully.')
            else writeln ('Error when saving new grades.');
        end
        else begin
            if GradesListModel.get(gradesList, idx, grades)
            then begin
                inputGradesLoop(grades);
                if GradesListModel.put(gradesList, idx, grades)
                then writeln ('Grades updated successfully.')
                else writeln ('Error when saving updated grades.');
            end
            else writeln ('Error obtaining grades for this student.');
        end;
    end
    else begin
        writeln('Student not found.');
    end;    
end;


end.