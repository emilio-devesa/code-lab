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

import  StandardOutput;
        Definitions qualified;
        Operations qualified;
        StudentsListModel qualified;
        StudentModel qualified;
        StudentView qualified;
        GradesListModel qualified;
        GradesModel qualified;
        GradesView qualified;
        ListSort qualified;
        ListPager qualified;
        ListView qualified;

procedure listStudentsAlphabetically(var studentsList: Definitions.tStudentsList);
procedure listStudentsAlphabeticallyAndSeasonGrades(var studentsList: Definitions.tStudentsList; var gradesList: Definitions.tGradesList);
procedure listStudentsByDescendingSeasonGrades(var studentsList: Definitions.tStudentsList; var gradesList: Definitions.tGradesList);

const PAGE_SIZE = 22;

end;


procedure listStudentsAlphabetically;
var s: Definitions.tStudent;
    i, cnt, res: integer;
    pager: ListPager.tPager;
    aborted: boolean value false;
begin
    ListSort.sortStudents(studentsList);
    cnt := StudentsListModel.getCount(studentsList);
    ListPager.PagerInit(pager, PAGE_SIZE);
    { first page header }
    ListView.printPageHeader('Students List', ListPager.PagerPageNumber(pager));
    i := 1;
    while (i <=cnt) and (not aborted) do begin
        if StudentsListModel.get(studentsList, i, s)
        then begin
            StudentView.print(StudentModel.getFirstName(s),
                               StudentModel.getLastName(s),
                               StudentModel.getLogin(s)
                              );
            writeln;
            res := ListPager.PagerConsume(pager, 4);
            if res = -1 
            then aborted := true
            else begin
                if res = 1 
                then ListView.printPageHeader('Students List', ListPager.PagerPageNumber(pager));
            end;
        end;
        i := i + 1;
    end;
    if aborted
    then writeln('Aborted by user.');
    Operations.WaitForEnter;
    Operations.ClearScreen;
end;

procedure listStudentsAlphabeticallyAndSeasonGrades;
var s: Definitions.tStudent;
    g: Definitions.tGrades;
    term: Definitions.tTerm;
    i, j, cnt, res: integer;
    pager: ListPager.tPager;
    aborted: boolean value false;
begin
    term := GradesView.getTerm;
    ListSort.sortStudents(studentsList);
    cnt := StudentsListModel.getCount(studentsList);
    ListPager.PagerInit(pager, PAGE_SIZE);
    { first page header }
    ListView.printPageHeader('Students List for '+Operations.TermToString(term), ListPager.PagerPageNumber(pager));
    
    i := 1;
    while (i <=cnt) and (not aborted) do begin
        if StudentsListModel.get(studentsList, i, s)
        then begin
            StudentView.print(StudentModel.getFirstName(s),
                              StudentModel.getLastName(s),
                              StudentModel.getLogin(s)
                             );
            j := GradesListModel.find(gradesList, StudentModel.getLogin(s));
            if (j>0) and_then (GradesListModel.get(gradesList, j, g))
            then GradesView.printGradesOfTerm(g, term);
            writeln;
            res := ListPager.PagerConsume(pager, 7);
            if res = -1 
            then aborted := true
            else begin
                if res = 1 
                then ListView.printPageHeader('Students List for '+Operations.TermToString(term), ListPager.PagerPageNumber(pager));
            end;
        end;
        i := i + 1;
    end;
    if aborted
    then writeln('Aborted by user.');
    Operations.WaitForEnter;
    Operations.ClearScreen;
end;

procedure listStudentsByDescendingSeasonGrades;
var term: Definitions.tTerm;
    part: Definitions.tPart;
    s: Definitions.tStudent;
    g: Definitions.tGrades;
    i, cnt, res: integer;
    pager: ListPager.tPager;
    aborted: boolean value false;
begin
    term := GradesView.getTerm;
    part := GradesView.getPart;
    ListSort.sortGradesDesc(gradesList, term, part);
    cnt := GradesListModel.getCount(gradesList);
    ListPager.PagerInit(pager, PAGE_SIZE);
    { first page header }
    ListView.printPageHeader('Students List for '+Operations.TermToString(term)+' (sort by descending grades)', ListPager.PagerPageNumber(pager));
    
    i := 1;
    while (i <= cnt) and (not aborted) do begin
        if GradesListModel.get(gradesList, i, g) and_then StudentsListModel.get(studentsList, StudentsListModel.find(studentsList, GradesModel.getLogin(g)), s)
        then begin
            StudentView.print(StudentModel.getFirstName(s),
                                   StudentModel.getLastName(s),
                                   StudentModel.getLogin(s)
                                  );
            GradesView.printGradesOfTerm(g, term);
            writeln;
            res := ListPager.PagerConsume(pager, 8);
            if res = -1 
            then aborted := true
            else begin
                if res = 1 
                then ListView.printPageHeader('Students List for '+Operations.TermToString(term)+' (sort by descending grades)', ListPager.PagerPageNumber(pager));
            end;
        end;
        i := i + 1;
    end;
    if aborted
    then writeln('Aborted by user.');
    Operations.WaitForEnter;
    Operations.ClearScreen;
end;


end.