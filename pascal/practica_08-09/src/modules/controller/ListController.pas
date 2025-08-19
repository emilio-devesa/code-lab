module ListController;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    ListController.pas
    Provides the controller for lists
}

export	ListController = (
            listStudentsAlphabetically,
            listStudentsAlphabeticallyAndSeasonGrades,
            listStudentsByDescendingSeasonGrades
);

import  Definitions qualified;
        StudentsListModel qualified;
        StudentModel qualified;
        StudentView qualified;
        GradesListModel qualified;
        GradesModel qualified;
        GradesView qualified;
        ListSort qualified;
        StandardOutput;

procedure listStudentsAlphabetically(var studentsList: Definitions.tStudentsList);
procedure listStudentsAlphabeticallyAndSeasonGrades(var studentsList: Definitions.tStudentsList; var gradesList: Definitions.tGradesList);
procedure listStudentsByDescendingSeasonGrades(var studentsList: Definitions.tStudentsList; var gradesList: Definitions.tGradesList);

end;


procedure listStudentsAlphabetically;
var s: Definitions.tStudent;
    i: integer;
begin
    ListSort.sortStudents(studentsList);
    for i := 1 to StudentsListModel.getCount(studentsList) do begin
        if StudentsListModel.get(studentsList, i, s)
        then StudentView.print(StudentModel.getFirstName(s),
                               StudentModel.getLastName(s),
                               StudentModel.getLogin(s)
                              );
    end;
end;

procedure debugPrintGradesList(var list: Definitions.tGradesList);
var i: integer;
begin
    writeln('grades count: ', list.count);
    for i := 1 to list.count do
        writeln(i, ': "', list.item[i].login, '"');
end;

procedure listStudentsAlphabeticallyAndSeasonGrades;
var term: integer;
    s: Definitions.tStudent;
    login: Definitions.tPersonalInfo;
    g: Definitions.tGrades;
    i, j: integer;
begin
    term := GradesView.getTerm;
    ListSort.sortStudents(studentsList);
    for i := 1 to StudentsListModel.getCount(studentsList) do begin
        if StudentsListModel.get(studentsList, i, s)
        then begin
            s := studentsList.item[i];
            login := StudentModel.getLogin(s);
            StudentView.print(s.firstName, s.lastName, s.login);
            j := GradesListModel.find(gradesList, login);
            if (j>0) and_then (GradesListModel.get(gradesList, j, g))
            then begin
                GradesView.printGradesOfTerm(g, term);
                writeln;
            end;
        end;
    end;
end;

procedure listStudentsByDescendingSeasonGrades;
var term, part: integer;
    s: Definitions.tStudent;
    g: Definitions.tGrades;
    i: integer;    
begin
    term := GradesView.getTerm;
    part := GradesView.getPart;
    ListSort.sortGradesDesc(gradesList, term, part);
    for i := GradesListModel.getCount(gradesList) downto 1 do begin
        if GradesListModel.get(gradesList, i, g)
        then begin
            if StudentsListModel.get(studentsList, 
                                       StudentsListModel.find(studentsList, GradesModel.getLogin(g)),
                                       s
                                      )
            then StudentView.print(StudentModel.getFirstName(s),
                                   StudentModel.getLastName(s),
                                   StudentModel.getLogin(s)
                                  );
            GradesView.printTheoryGrade(GradesModel.getTheoryGrade(g, term));
            GradesView.printPracticeGrade(GradesModel.getPracticeGrade(g, term));
            GradesView.printGlobalGrade(GradesModel.getGlobalGrade(g, term));
        end;
    end;
end;



end.