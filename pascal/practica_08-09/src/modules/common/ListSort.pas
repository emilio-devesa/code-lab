module ListSort;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    ListSort.pas
    Provides an implementation of the quicksort algorithm to sort lists of students or grades
}

export  ListSort = (
            sortStudents,
            sortGradesDesc
);

import  Definitions qualified;
        StudentsListModel qualified;
        GradesListModel qualified;

procedure sortStudents(var origin, target: Definitions.tStudentsList);
procedure sortGradesDesc(var origin, target: Definitions.tGradesList; term, part: integer);

end;


procedure quicksortStudents(var l: Definitions.tStudentsList; low, high: integer);
var i, j: integer;
    pivot, aux: Definitions.tStudent;
begin
    if low < high
    then begin
        { Choose the pivot (in this case, the middle element) }
        pivot := l.item[(low + high) div 2];
        i := low;
        j := high;
        { Partition the array into two halves }
        repeat
            while l.item[i].firstName < pivot.firstName do i := i + 1;
            while l.item[j].firstName > pivot.firstName do j := j - 1;
            if i <= j
            then begin
                { Swap elements and move indices }
                aux := l.item[i];
                l.item[i] := l.item[j];
                l.item[j] := aux;
                i := i+1;
                j := j-1;
            end;
        until i > j;
        { Recursively sort the sub-lists }
        quicksortStudents(l, low, j);
        quicksortStudents(l, i, high);
    end;
end;

procedure quicksortGradesDesc(var l: Definitions.tGradesList; low, high: integer; t, p: integer);
var i, j: integer;
    pivot, aux: Definitions.tGrades;
begin
    if low < high
    then begin
        { Choose the pivot (in this case, the middle element) }
        pivot := l.item[(low + high) div 2];
        i := low;
        j := high;
        { Partition the array into two halves }
        repeat
            case p of
                1: begin
                    { Sort by theory grade}
                    while l.item[i].term[t].theory.val < pivot.term[t].theory.val do i := i + 1;
                    while l.item[j].term[t].theory.val > pivot.term[t].theory.val do j := j - 1;
                end;
                2: begin
                    { Sort by practice grade }
                    while l.item[i].term[t].practice.val < pivot.term[t].practice.val do i := i + 1;
                    while l.item[j].term[t].practice.val > pivot.term[t].practice.val do j := j - 1;
                end;
                3: begin
                    { Sort by global grade }
                    while l.item[i].term[t].global < pivot.term[t].global do i := i + 1;
                    while l.item[j].term[t].global > pivot.term[t].global do j := j - 1;
                end;
            end;
            if i <= j
            then begin
                { Swap elements and move indices }
                aux := l.item[i];
                l.item[i] := l.item[j];
                l.item[j] := aux;
                i := i+1;
                j := j-1;
            end;
        until i > j;
        { Recursively sort the sub-lists }
        quicksortGradesDesc(l, low, j, t, p);
        quicksortGradesDesc(l, i, high, t, p);
    end;
end;


procedure sortStudents;
var size: integer;
begin
    size := StudentsListModel.getCount(origin);
    StudentsListModel.clone(origin, target);
    if size > 1
    then quicksortStudents(target, 1, size);
end;

procedure sortGradesDesc;
var size: integer;
begin
    size := GradesListModel.getCount(origin);
    GradesListModel.clone(origin, target);
    if size > 1
    then quicksortGradesDesc(target, 1, size, term, part);
end;

end.