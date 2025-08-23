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

procedure sortStudents(var list: Definitions.tStudentsList);
procedure sortGradesDesc(var list: Definitions.tGradesList; term: Definitions.tTerm; part: Definitions.tPart);

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
            while l.item[i].lastName < pivot.lastName do i := i + 1;
            while l.item[j].lastName > pivot.lastName do j := j - 1;
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

procedure quicksortGradesDesc(var l: Definitions.tGradesList; low, high: integer; term: Definitions.tTerm; part: Definitions.tPart);
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
            { Compare grades based on the specified term and part }
            while l.item[i].grades[term, part].val > pivot.grades[term, part].val do i := i + 1;
            while l.item[j].grades[term, part].val < pivot.grades[term, part].val do j := j - 1;
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
        quicksortGradesDesc(l, low, j, term, part);
        quicksortGradesDesc(l, i, high, term, part);
    end;
end;


procedure sortStudents;
var size: integer;
begin
    size := StudentsListModel.getCount(list);
    if size > 1
    then quicksortStudents(list, 1, size);
end;

procedure sortGradesDesc;
var size: integer;
begin
    size := GradesListModel.getCount(list);
    if size > 1
    then quicksortGradesDesc(list, 1, size, term, part);
end;

end.