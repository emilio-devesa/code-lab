module ConfigurationView;
{   Práctica 2008-2009
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md

    ConfigurationView.pas
    Provides a view for persistent configuration values
}

export ConfigurationView = (askToSaveGrades, show);

import StandardInput; StandardOutput;

procedure show(theoryIsSaved, practiceIsSaved: boolean);
procedure askToSaveGrades(var theoryIsSaved: boolean; var practiceIsSaved: boolean);

end;


procedure askToSaveGrades;
var response: char; validResponseSet: set of char value ['Y','y','N','n'];
begin
    write('Do you want to save the theory grade if passed? (Y/N): ');
    repeat
        readln(response);
    until (response in validResponseSet);
    theoryIsSaved := ((response = 'Y') or (response = 'y'));
    write('Do you want to save the practice grade if passed? (Y/N): ');
    repeat
        readln(response);
    until (response in validResponseSet);
    practiceIsSaved := ((response = 'Y') or (response = 'y'));
end;

procedure show;
begin
    if theoryIsSaved
    then writeln('Theory grades are saved.')
    else writeln('Theory grades are not saved.');
    if practiceIsSaved
    then writeln('Practice grades are saved.')
    else writeln('Practice grades are not saved.');
end;

end.