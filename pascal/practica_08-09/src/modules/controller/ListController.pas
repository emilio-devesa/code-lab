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

procedure listStudentsAlphabeticallyAndSeasonGrades;
var s: Definitions.tStudent;
    g: Definitions.tGrades;
    term: Definitions.tTerm;
    i, j: integer;
begin
    term := GradesView.getTerm;
    ListSort.sortStudents(studentsList);
    for i := 1 to StudentsListModel.getCount(studentsList) do begin
        if StudentsListModel.get(studentsList, i, s)
        then begin
            StudentView.print(StudentModel.getFirstName(s),
                              StudentModel.getLastName(s),
                              StudentModel.getLogin(s)
                             );
            j := GradesListModel.find(gradesList, StudentModel.getLogin(s));
            if (j>0) and_then (GradesListModel.get(gradesList, j, g))
            then GradesView.printGradesOfTerm(g, term);
        end;
    end;
end;

procedure listStudentsByDescendingSeasonGrades;
var term: Definitions.tTerm;
    part: Definitions.tPart;
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
            GradesView.printGradesOfTerm(g, term);
        end;
    end;
end;


end.