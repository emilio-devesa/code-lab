module ConfigurationPersistence;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    ConfigurationPersistence.pas
    Provides file persistence for the configuration values using a binary file.
}

export ConfigurationPersistence = (
        saveToFile,
        loadFromFile
);

import  StandardInput;
        StandardOutput;
        ConfigurationModel qualified;

const   configFileName = '.config';

type    tFile = bindable file of boolean;

function saveToFile: boolean;
function loadFromFile: boolean;

end;

function fileExists(var aFile: tFile; aName: String): boolean;
var b: bindingtype;
begin
    unbind(aFile);
    b := binding(aFile);
    b.name := aName;
    bind(aFile, b);
    b := binding(aFile);
    fileExists := b.existing;
end;

function fileIsBound(var aFile: tFile; aName: String): boolean;
var b: bindingtype;
begin
    unbind(aFile);
    b := binding(aFile);
    b.name := aName;
    bind(aFile, b);
    b := binding(aFile);
    fileIsBound := b.bound;
end;

function saveToFile;
var configFile: tFile;
begin
    if (fileIsBound(configFile, configFileName))
    then begin
        rewrite(configFile);
        write(configFile, ConfigurationModel.getSaveTheory);
        write(configFile, ConfigurationModel.getSavePractice);
        saveToFile := true;
    end
    else saveToFile := false;
end;

function loadFromFile;
var configFile: tFile; save: boolean;
begin
    if (fileExists(configFile, configFileName)) and_then (fileIsBound(configFile, configFileName))
    then begin
        reset(configFile);
        read(configFile, save);
        ConfigurationModel.setSaveTheory(save);
        read(configFile, save);
        ConfigurationModel.setSavePractice(save);
        loadFromFile := true;
    end
    else loadFromFile := false;
end;

end.