module GradesController;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

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
        GradesValidatorService qualified;

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

procedure furtherGradePropagation(var grades: Definitions.tGrades; term: Definitions.tTerm; part: Definitions.tPart; val: real);
var passedInTerm, t: Definitions.tTerm value Definitions.NoTerm;
begin
    case part of
        Definitions.Theory:     if (ConfigurationService.checkIsTheorySaved) and_then (val >= Definitions.THEORY_PASSED_MINIMUM)
                                then passedInTerm := term;
        Definitions.Practice:   if (ConfigurationService.checkIsPracticeSaved) and_then (val >= Definitions.PRACTICE_PASSED_MINIMUM)
                                then passedInTerm := term;
        otherwise ;
    end;
    if (passedInTerm <> Definitions.NoTerm)
    then begin
        for t := passedInTerm to Definitions.December do begin
            GradesModel.setGrade(grades, term, part, val, passedInTerm, true);
        end;
    end;
end;

procedure readGrades(var grades: Definitions.tGrades; login: Definitions.tPersonalInfo; term: Definitions.tTerm; part: Definitions.tPart; var hasValue: boolean);
var val: real value 0.0;
    isValid: boolean value false;
    passedIn: Definitions.tTerm value Definitions.NoTerm;
    input: Definitions.tGradeString;
begin
    writeln;
    val := GradesModel.getGrade(grades, term, part, passedIn, hasValue);
    if hasValue
    then GradesView.printPreviousGrade(val, term);
    repeat
        input := GradesView.getGrade(part);
        hasValue := not eq(input, '');
        isValid := GradesValidatorService.validate(input, val);
        if not isValid
        then writeln('Invalid grade. Please enter a value between 0.0 and 10.0, with at most one decimal.');
    until isValid or hasValue;
    if isValid
    then begin
        GradesModel.setLogin(grades, login);
        GradesModel.setGrade(grades, term, part, val, passedIn, hasValue);
        furtherGradePropagation(grades, term, part, val);
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