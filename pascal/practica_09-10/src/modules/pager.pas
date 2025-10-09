module pager;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    pager.pas
    Simple pager helper
}

export  pager = (
            tPager,
            PagerInit,
            PagerConsume,
            PagerPageNumber
);

import  utils qualified;

type    tPager = record
            pageSize: integer;
            linesOnPage: integer value 0;
            pageNumber: integer value 1;
        end;

procedure PagerInit(var p: tPager; aPageSize: integer);
function PagerConsume(var p: tPager; linesPrinted: integer): integer;
function PagerPageNumber(p: tPager): integer;


end;


procedure PagerInit;
begin
    if aPageSize <= 0 
    then p.pageSize := 20 
    else p.pageSize := aPageSize;
    p.linesOnPage := 0;
    p.pageNumber := 1;
end;

{ PageConsume returns:
     0 = continue, 
     1 = new page (caller should print header), 
    -1 = aborted 
}
function PagerConsume;
begin
    PagerConsume := 0;
    if linesPrinted < 1 
    then linesPrinted := 1; { defensive }
    p.linesOnPage := p.linesOnPage + linesPrinted;
    if p.linesOnPage >= p.pageSize 
    then begin
        utils.WaitForEnter;
        p.linesOnPage := 0;
        p.pageNumber := p.pageNumber + 1;
        PagerConsume := 1;
    end;
end;

function PagerPageNumber;
begin
    PagerPageNumber := p.pageNumber;
end;


end.