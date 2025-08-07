module ListSort;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    ListSort.pas
    Provides an implementation of the quicksort algorithm to sort lists of students or grades
}

export  ListSort = (
            sortStudents
);

import  Definitions qualified;
        StudentsListModel qualified;

procedure sortStudents(var origin, target: Definitions.tStudentsList);

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


procedure sortStudents;
var size: integer;
begin
    size := origin.count;
    StudentsListModel.clone(origin, target);
    if size > 1
    then quicksortStudents(target, 1, size);
end;

end.