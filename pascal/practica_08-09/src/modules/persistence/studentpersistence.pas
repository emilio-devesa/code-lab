module StudentPersistence;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    StudentPersistence.pas
    Provides file persistence for the student list using a binary file.
}

export  StudentPersistence = (
        loadFromFile,
        saveToFile
);

import  StandardInput;
        StandardOutput;
        Definitions qualified;
        StudentModel qualified;
        StudentsListModel qualified;


const   dataFileName = '.students';

type    tFile = bindable file of Definitions.tStudentsList;

function loadFromFile (var list: Definitions.tStudentsList): boolean;
function saveToFile (var list: Definitions.tStudentsList): boolean;


end;


function fileExists(var f: tFile; filename: String): boolean;
var b: bindingtype;
begin
    unbind(f);
    b := binding(f);
    b.name := filename;
    bind(f, b);
    b := binding(f);
    fileExists := b.existing;
end;

function fileIsBound(var f: tFile; filename: String): boolean;
var b: bindingtype;
begin
    unbind(f);
    b := binding(f);
    b.name := filename;
    bind(f, b);
    b := binding(f);
    fileIsBound := b.bound;
end;

function loadFromFile;
var f: tFile;
begin
    if fileExists(f, dataFileName) and_then fileIsBound(f, dataFileName)
    then begin
        reset(f);
        read(f, list);
        loadFromFile := true;
    end
    else loadFromFile := false;
end;

function saveToFile;
var f: tFile;
begin
    if fileIsBound(f, dataFileName)
    then begin
        rewrite(f);
        write(f, list);
        saveToFile := true;
    end
    else saveToFile := false;
end;


end.