program calendar (input, output);
{Autor    Emilio Devesa
 Archivo  calendar.pas
 Objeto   Este programa se hace para comprender el trabajo con modulos.
 Espec    Lo que este programa debe hacer es mostrar el calendario de un año
          cualquiera introducido por el usuario.
 Fecha    21/11/2007
 Entrega  26/11/2007
 Notas    La compilación será en gpc en el lenguaje pascal ISO 10206 con la
          directiva --extended-pascal
}

function isLeapYear(year: integer): boolean;
begin
    isLeapYear:=((year mod 4 = 0) and not (year mod 100 = 0)) or (year mod 400 = 0);
end;

function getDayOfTheWeek(year:integer; month:integer; day: integer): integer;
{ GAUSS FORMULA: (d + m + 5*(y-1 mod 4) + 4*(y-1 mod 100) + 6*(y-1 mod 400)) mod 7;
    ADJUSTMENT FOR m:
    MONTH       Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    COMMON YEAR 0   3   3   6   1   4   6   2   5   0   3   5
    LEAP YEAR   0   3   4   0   2   5   0   3   6   1   4   6
 https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week#Gauss's_algorithm
}
var offsetOfCommonYear: array [1..12] of integer value [1:0; 2:3; 3:3; 4:6; 5:1; 6:4; 7:6; 8:2; 9:5; 10:0; 11:3; 12:5];
    offsetOfLeapYear: array [1..12] of integer value [1:0; 2:3; 3:4; 4:0; 5:2; 6:5; 7:0; 8:3; 9:6; 10:1; 11:4; 12:6];
    offset: integer;
begin
    if isLeapYear(year)
    then offset:=offsetOfLeapYear[month]
    else offset:=offsetOfCommonYear[month];
    getDayOfTheWeek:=(day + offset + 5*((year-1) mod 4) + 4*((year-1) mod 100) + 6*((year-1) mod 400)) mod 7;
end;

procedure printQuarter(year, quarter: integer);
const separator='    ';
var dayOfTheMonth: array [1..12] of integer value [otherwise 1];
    daysInMonth: array [1..12] of integer value [1:31; 2:28; 3:31; 4:30; 5:31; 6:30; 7:31; 8:31; 9:30; 10:31; 11:30; 12:31];
    monthOfTheQuarter: array [1..4,1..3] of integer value [1:[1:1; 2:2; 3:3]; 2:[1:4; 2:5; 3:6]; 3:[1:7; 2:8; 3:9]; 4:[1:10; 2:11; 3:12]];
    weekIsOver: array [1..3] of boolean value [otherwise false];
    monthIsOver: array[1..3] of boolean value [otherwise false];
    month, weekday, monthIndex, whitespace:integer;
begin
    if isLeapYear(year) then daysInMonth[2]:=29;
    repeat
        for monthIndex:=1 to 3 do begin
            month:=monthOfTheQuarter[quarter, monthIndex];
            if monthIsOver[monthIndex]
            then begin
                for whitespace:=1 to 25 do write(' '); 
            end
            else begin
                weekIsOver[monthIndex]:=false;
                while not (weekIsOver[monthIndex]) and not (monthIsOver[monthIndex]) do begin
                        weekday:=getDayOfTheWeek(year,month,dayOfTheMonth[month]);
                        {Is this week over yet?}
                        if (weekday=0)
                        then begin
                            weekIsOver[monthIndex]:=true;
                            if (dayOfTheMonth[month]=1)
                            then write(dayOfTheMonth[month]:21)
                            else write(dayOfTheMonth[month]:3);
                            write(separator);
                        end
                        else
                            if (dayOfTheMonth[month]=1)
                            then write(dayOfTheMonth[month]:3*weekday)
                            else write(dayOfTheMonth[month]:3);
                        {Is this month over yet?}
                        if dayOfTheMonth[month]=daysInMonth[month]
                        then begin
                            monthIsOver[monthIndex]:=true;
                            if (weekday<>0) then for whitespace:=weekday*3 to 24 do write(' ');
                        end
                        else dayOfTheMonth[month]:=dayOfTheMonth[month]+1;
                    end;
            end;
        end;
        writeln;
    until (monthIsOver[1] and monthIsOver[2] and monthIsOver[3]);
end;

procedure printCalendar(year:integer);
var quarter: integer;
begin
    for quarter:=1 to 4 do begin
        case quarter of
            1:  writeln('Jan':11, 'Feb':25, 'Mar':25);
            2:  writeln('Apr':11, 'May':25, 'Jun':25);
            3:  writeln('Jul':11, 'Aug':25, 'Sep':25);
            4:  writeln('Oct':11, 'Nov':25, 'Dec':25);
        end;
        writeln(' Mo Tu We Th Fr Sa Su','Mo Tu We Th Fr Sa Su':25,'Mo Tu We Th Fr Sa Su':25);
        printQuarter(year,quarter);
        writeln;
    end;
end;

var year: integer;
begin
    repeat
        write('Introducir año: ');
        readln(year);
        if (year<1)
        then write('No es valido.');
    until (1<=year) and (year<=MAXINT);
    printCalendar(year);
end.