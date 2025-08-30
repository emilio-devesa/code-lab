program akermann (input, output);

var i, j: integer;

function a(m, n: integer): integer;
begin
    if m = 0
    then a := n + 1
    else if n = 0
        then a := a(m-1, 1)
        else a := a(m-1, a(m, n-1));
end;

begin
    for i := 0 to 4 do
        for j := 0 to 5 do writeln('A(', i:0, ', ', j:0, ') = ', a(i, j):0);
end.