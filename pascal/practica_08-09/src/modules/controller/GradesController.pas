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
        Operations qualified;
        GradesModel qualified;
        GradesListModel qualified;
        GradesView qualified;
        GradesPersistence qualified;
        StudentService qualified;
        ConfigurationService qualified;

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

procedure propagateFurther(var grades: Definitions.tGrades; termPassed: Definitions.tTerm; part: Definitions.tPart; val: real);
var term: Definitions.tTerm;
begin
    for term := termPassed to Definitions.December do begin
        GradesModel.setGrade(grades, term, part, val, termPassed, true);
    end;
end;

procedure readGrades(var grades: Definitions.tGrades; login: Definitions.tPersonalInfo; term: Definitions.tTerm; part: Definitions.tPart; var hasValue: boolean);
var val: real value 0.0;
    passedIn: Definitions.tTerm value Definitions.NoTerm;
begin
    writeln;
    val := GradesModel.getGrade(grades, term, part, passedIn, hasValue);
    GradesView.getGrade(term, part, val, passedIn, hasValue);
    { Grades saving logic should be now here resolved }
    case part of
        Definitions.Theory:     if (ConfigurationService.checkIsTheorySaved) and_then (val >= Definitions.THEORY_PASSED_MINIMUM)
                                then passedIn := term;
        Definitions.Practice:   if (ConfigurationService.checkIsPracticeSaved) and_then (val >= Definitions.PRACTICE_PASSED_MINIMUM)
                                then passedIn := term;
        otherwise ;
    end;
    if (passedIn <> Definitions.NoTerm)
    then propagateFurther(grades, term, part, val);
    if hasValue
    then begin
        GradesModel.setLogin(grades, login);
        GradesModel.setGrade(grades, term, part, val, passedIn, hasValue);
    end;
end;

procedure setGrades;
var login: Definitions.tPersonalInfo;
    idx: integer;
    term: Definitions.tTerm;
    part: Definitions.tPart;
    grades: Definitions.tGrades;
    hasValue: boolean value false;
begin
    writeln;
    writeln('-------------------------');
    writeln('Update grades');
    writeln('Enter student login or leave blank to go back to Main Menu');
    writeln('-------------------------');
    if StudentService.checkStudentByLogin(studentsList, login)
    then begin
        repeat
            term := GradesView.getTerm;
            if term <> Definitions.NoTerm
            then begin
                part := GradesView.getPart;
                if part <> Definitions.NoPart
                then begin
                    idx := GradesListModel.find(gradesList, login);
                    if (idx <> 0) and_then GradesListModel.get(gradesList, idx, grades)
                    then writeln('Please introduce existing student grades')
                    else writeln('Please introduce new student grades');
                    readGrades(grades, login, term, part, hasValue);
                    if hasValue
                    then begin
                        if idx = 0
                        then begin
                            if GradesListModel.add(gradesList, grades)
                            then writeln('Grades for ', login, ' have been added.');
                        end
                        else begin
                            if GradesListModel.put(gradesList, idx, grades)
                            then writeln('Grades for ', login, ' have been updated.');
                        end;
                        saveGrades(gradesList);
                    end;
                end
                else writeln;
            end;
        until (term = Definitions.NoTerm);
    end
    else begin
        if trim(login) <> '' then writeln('Student not found.');
    end;
    Operations.WaitForEnter;
    Operations.ClearScreen;
end;


end.