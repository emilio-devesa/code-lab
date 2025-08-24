module GradesListModel;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    GradesListModel.pas
    Provides the model for the grades list
}

export	GradesListModel = (
            add,
            get,
            put,
            remove,
            find,
            clone,
            getCount
);

import  Definitions qualified;

function add (var list: Definitions.tGradesList; grades: Definitions.tGrades): boolean;
function get (var list: Definitions.tGradesList; i: integer; var grades: Definitions.tGrades): boolean;
function put (var list: Definitions.tGradesList; i: integer; grades: Definitions.tGrades): boolean;
function remove (var list: Definitions.tGradesList; login: Definitions.tPersonalInfo): boolean;
function find (var list: Definitions.tGradesList; login: Definitions.tPersonalInfo): integer;
procedure clone(var origin, target: Definitions.tGradesList);
function getCount (var list: Definitions.tGradesList): integer;


end;


function add;
begin
    if (list.count < Definitions.MAX_ITEMS)
    then begin
        list.count := list.count + 1;
        list.item[list.count] := grades;
        add := true;
    end
    else add := false;
end;

function get;
begin
    if (i>0) and_then (i <= list.count)
    then begin
        grades := list.item[i];
        get := true;
    end
    else get := false;
end;

function put;
begin
    put := false;
    if (i > 0) and (i <= list.count)
    then begin
        list.item[i] := grades;
        put := true;
    end;
end;

function remove;
var i: integer;
begin
    remove := false;
    i := find(list, login);
    if i > 0
    then begin
        while (i < list.count) do begin
            list.item[i] := list.item[i+1];
            i := i + 1;
        end;
        list.count := list.count - 1;
        remove := true;
    end;
end;

function find;
var i: integer;
begin
    find := 0;
    if list.count > 0
    then begin
        for i := 1 to list.count do begin
            if list.item[i].login = login
            then find := i;
        end;
    end
end;

procedure clone;
var i: integer;
begin
    target.count := origin.count;
    if origin.count > 0
    then for i := 1 to origin.count do target.item[i] := origin.item[i];
end;

function getCount;
begin
    getCount := list.count;
end;


end.