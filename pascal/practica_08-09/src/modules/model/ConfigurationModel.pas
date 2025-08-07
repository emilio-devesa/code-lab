module ConfigurationModel;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    ConfigurationModel.pas
    Provides a model for configuration values
}

export  ConfigurationModel = (
            getSaveTheory,
            getSavePractice,
            setSaveTheory,
            setSavePractice
);

var     saveTheory, savePractice: boolean;

function getSaveTheory: boolean;
function getSavePractice: boolean;
procedure setSaveTheory(val: boolean);
procedure setSavePractice(val: boolean);

end;

function getSaveTheory;
begin
    getSaveTheory := saveTheory;
end;

function getSavePractice;
begin
    getSavePractice := savePractice;
end;

procedure setSaveTheory;
begin
    saveTheory := val;
end;

procedure setSavePractice;
begin
    savePractice := val;
end;

end.