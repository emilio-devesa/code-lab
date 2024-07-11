module List;
{   Práctica 2007-2008
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Emilio Devesa
    https://emiliodevesa.wordpress.com/

    List.pas
    Provides a Dinamic List data structure and basic operations
}

export  List = (tList, tInfo, tPosition, init, isEmpty, add, get, update, getSize, print, sort);

import  StandardInput; StandardOutput;
        TextFile qualified;

const   NULL = nil;

type    tInfo = String (1024);
        tPosition = ^tNode;
        tNode = record
            info: tInfo;
            next: tPosition;
        end;
        tList = tPosition;

procedure init(var l: tList);
function isEmpty(var l: tList): boolean;
procedure add(var l: tList; info: tInfo);
function get(l: tList; index: integer): tPosition;
procedure update(var l: tList; p: tPosition; info: tInfo);
function getSize(l: tList): integer;
procedure print(l: tList);
procedure sort(var l: tList);


end;

procedure init;
begin
    l := NULL;
end;

function isEmpty;
begin
    isEmpty := l = NULL;
end;

function getLast(var l: tList): tPosition;
var p: tPosition;
begin
    if l = NULL
    then getLast := NULL
    else begin
            p := l;
            while p^.next <> NULL do p := p^.next;
            getLast := p;
    end;
end;

function newNode (var node: tPosition): boolean;
begin
    new(node);
    if node = NULL
    then newNode := false
    else begin
            newNode := true;
            node^.next := NULL;
    end;
end;

procedure add;
var p, node: tPosition;
begin
    if newNode(node)
    then begin
            if l = NULL
            then l := node
            else begin
                    p := getLast(l);
                    p^.next := node;
            end;
            node^.info := info;
    end
end;

function get;
var p: tPosition; i: integer;
begin
    p := l;
    i := 1;
    while (p <> NULL) and (i < index) do begin
        p := p^.next;
        i := i+1;
    end;
    get := p;
end;

procedure update;
begin
    p^.info := info;
end;

function getSize;
var p: tPosition; total: integer value 0;
begin
    if l = NULL
    then total := 0
    else begin
        p := l;
        while p^.next<>NULL do begin
            p := p^.next;
            total := total+1;
        end;
    end;
    getSize := total;
end;

procedure print;
var p: tPosition;
begin
    p := l;
    while p <> NULL do begin
        write(p^.info, ' ');
        p := p^.next;
    end;
end;

procedure quicksort(var l: tList; low, high: integer);
var i, j: integer; pivot, aux1, aux2: tInfo; pos1, pos2: tPosition;
begin
    if low < high
    then begin
        { Choose the pivot (in this case, the middle element) }
        pivot := get(l, (low + high) div 2)^.info;
        i := low;
        j := high;
        { Partition the array into two halves }
        repeat
            while get(l,i)^.info<pivot do i:=i+1;
            while get(l,j)^.info>pivot do j:=j-1;
            if i <= j
            then begin
                { Swap elements and move indices }
                aux1 := get(l,i)^.info;
                pos1 := get(l,i);
                aux2 := get(l, j)^.info;
                pos2 := get(l,j);
                update(l, pos1, aux2);
                update(l, pos2, aux1);
                i := i+1;
                j := j-1;
            end;
        until i > j;
        { Recursively sort the sub-lists }
        quicksort(l, low, j);
        quicksort(l, i, high);
    end;
end;

procedure sort;
begin
    if isEmpty(l)
    then writeln('List is empty') 
    else quicksort(l, 1, getSize(l));
end;

end.