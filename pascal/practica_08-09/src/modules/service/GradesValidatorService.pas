module GradesValidatorService;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    GradeValidatorService.pas
    Provides functions to validate grades
}

export  GradesValidatorService = (
            validate
);

import  Definitions qualified;

function validate(input: Definitions.tGradeString; var val: real): boolean;


end;


function validate;
var isValid: boolean value true;
    i, decimalPos, decimalCount: integer value -1;
begin
    val := -1.0;
    decimalPos := -1;
    { Check valid digits }
    for i := 1 to Length(input) do isValid := isValid and (input[i] in ['0'..'9', '.']);
    { Check decimal point }
    for i := 1 to Length(input) do begin
        if (input[i] = '.')
        then begin
            if (decimalPos < 0)
            then decimalPos := i
            else isValid := false; { More than one decimal point }
        end;
    end;
    { Check decimals }
    if (isValid)
    then begin
        if (decimalPos in [0 .. (Length(input))])
        then decimalCount := Length(input) - decimalPos;
        if decimalCount > 1
        then isValid := false; { More than one decimal number }
    end;
    { Read String as real }
    if (isValid)
    then readstr(input, val);
    { Return }
    validate := (isValid) and ((val >= 0.0) and (val <= 10.0));
end;


end.