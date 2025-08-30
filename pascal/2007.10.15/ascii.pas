program ascii (input, output);
var i: integer;

begin
    for i := 0 to ord (maxchar) do
        case i of
            0, 7, 8, 10, 13: write  (i:3 , ' ');
            otherwise write (i:3, chr (i), ' ');
        end;
    writeln;
end.