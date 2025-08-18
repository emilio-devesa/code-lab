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

procedure listStudentsAlphabetically(var origin: Definitions.tStudentsList);
procedure listStudentsAlphabeticallyAndSeasonGrades(var students: Definitions.tStudentsList; var grades: Definitions.tGradesList);
procedure listStudentsByDescendingSeasonGrades(var students: Definitions.tStudentsList; var grades: Definitions.tGradesList);

end;


procedure listStudentsAlphabetically;
var list: Definitions.tStudentsList;
    s: Definitions.tStudent;
    i: integer;
begin
    ListSort.sortStudents(origin, list);
    for i := 1 to StudentsListModel.getCount(list) do begin
        if StudentsListModel.get(list, i, s)
        then StudentView.print(StudentModel.getFirstName(s),
                               StudentModel.getLastName(s),
                               StudentModel.getLogin(s)
                              );
    end;
end;


procedure listStudentsAlphabeticallyAndSeasonGrades;
var list: Definitions.tStudentsList;
    term: integer;
    s: Definitions.tStudent;
    g: Definitions.tGrades;
    i: integer;    
begin
    term := GradesView.getTerm;
    ListSort.sortStudents(students, list);
    for i := 1 to StudentsListModel.getCount(list) do begin
        if StudentsListModel.get(list, i, s)
        then begin
            StudentView.print(StudentModel.getFirstName(s),
                               StudentModel.getLastName(s),
                               StudentModel.getLogin(s)
                              );
            if GradesListModel.get(grades, 
                                   GradesListModel.find(grades, StudentModel.getLogin(s)),
                                   g)
            then begin
                GradesView.printTheoryGrade(GradesModel.getTheoryGrade(g, term));
                GradesView.printPracticeGrade(GradesModel.getPracticeGrade(g, term));
                GradesView.printGlobalGrade(GradesModel.getGlobalGrade(g, term));
            end;
        end;
    end;
end;



procedure listStudentsByDescendingSeasonGrades;
var list: Definitions.tGradesList;
    term, part: integer;
    s: Definitions.tStudent;
    g: Definitions.tGrades;
    i: integer;    
begin
    term := GradesView.getTerm;
    part := GradesView.getPart;
    ListSort.sortGradesDesc(grades, list, term, part);
    for i := GradesListModel.getCount(list) downto 1 do begin
        if GradesListModel.get(list, i, g)
        then begin
            if StudentsListModel.get(students, 
                                       StudentsListModel.find(students, GradesModel.getLogin(g)),
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