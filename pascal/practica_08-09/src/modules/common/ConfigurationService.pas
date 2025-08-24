module ConfigurationService;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).

    ConfigurationService.pas
    Provides functions to check configuration values
}

export  ConfigurationService = (
            checkIsTheorySaved,
            checkIsPracticeSaved
);

import  ConfigurationModel qualified;


function checkIsTheorySaved: boolean;
function checkIsPracticeSaved: boolean;


end;


function checkIsTheorySaved;
begin
    checkIsTheorySaved := ConfigurationModel.getSaveTheory;
end;

function checkIsPracticeSaved;
begin
    checkIsPracticeSaved := ConfigurationModel.getSavePractice;
end;


end.

