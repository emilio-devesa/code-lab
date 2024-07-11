module List;
{   Práctica 2007-2008
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    Emilio Devesa
    https://emiliodevesa.wordpress.com/

    List.pas
    Provides a Dinamic List data structure and basic operations
}

export  List = (tList, tInfo, tPosition, init, isEmpty, add, get, update, getSize, print, populateFromFile);

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
procedure populateFromFile(inputFile: String; var l: tList);

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

procedure populateFromFile;
var fText: TextFile.tFile;
    inputString: String(1024);
    pos: integer;
    word: String(1024);
begin
    if (TextFile.fileExists(inputFile)) and_then (TextFile.openFile(fText, inputFile))
    then begin
        reset(fText);
        readln(fText, inputString);
        inputString := Trim(inputString);
        repeat
            pos := index(inputString, ' ');
            word := '';
            { Only one word }
            if (pos = 0)
            then begin
                word := inputString;
                inputString := '';
            end
            { More words }
            else begin
                { Make sure strings don't start with a blank space }
                if (pos > 1)
                then word := SubStr(inputString, 1, pos-1);
                inputString := SubStr(inputString, pos+1);
            end;
            if (word <> '') then add(l, word);
        until inputString = '';
    end
    else begin
        writeln('ERROR List.populateFromFile(): Can´t open '+inputFile);
    end;
end;

end.