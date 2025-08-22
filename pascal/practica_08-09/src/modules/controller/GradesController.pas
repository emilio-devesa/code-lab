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

procedure inputGradesLoop(var element: Definitions.tGrades);
var term: Definitions.tTerm;
    part: Definitions.tPart;
    val: real value 0.0;
    pass: Definitions.tTerm value Definitions.NoTerm;
begin
    repeat
        term := GradesView.getTerm;
        if term <> Definitions.NoTerm
        then begin
            part := GradesView.getPart;
            if part <> Definitions.NoPart
            then begin
                val := GradesModel.getGrade(element, term, part, pass);
                writeln('Previous grade: ', val:3:1, Definitions.TermToChar(pass));
                val := GradesView.getGrade(part);
                GradesModel.setGrade(element, term, part, val, pass);
            end;
        end;
    until (term = Definitions.NoTerm);
end;

procedure setGrades;
var login: Definitions.tPersonalInfo;
    idx: integer;
    preexistingGrades: boolean value false;
    grades: Definitions.tGrades;
begin
    writeln;
    writeln('-------------------------');
    writeln('Update grades');
    writeln('Enter student login or leave blank to go back to Main Menu');
    writeln('-------------------------');
    if StudentService.checkStudentByLogin(studentsList, login)
    then begin
        idx := GradesListModel.find(gradesList, login);
        if idx > 0
        then preexistingGrades := GradesListModel.get(gradesList, idx, grades);
        
        if preexistingGrades
        then writeln('Updating grades for student: ', login)
        else writeln('Setting grades for student: ', login);

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
        if GradesPersistence.saveToFile(gradesList)
        then writeln('Grades saved to file.')
        else writeln('Grades could not be saved to file.');
    end
    else begin
        if trim(login) <> '' then writeln('Student not found.');
    end;
end;


end.