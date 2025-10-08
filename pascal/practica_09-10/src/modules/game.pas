module game;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    game.pas
    Provides game operations and control
}


export  game = (
            PlayGame
);

import  StandardInput;
        StandardOutput;
        types qualified;
        utils qualified;
        files qualified;
        highscores qualified;
        dictionary qualified;

procedure PlayGame (highscoresList: types.tHighscoresList; withValidation: boolean);


end;

function Equals (palabra1, palabra2: types.tWord): boolean;
var i: integer; p1, p2: types.tWord;
begin
    p1 := '';
    p2 := '';
    for i := 1 to length (palabra1) do p1 := p1 + utils.EnMinuscula (palabra1[i]);
    for i := 1 to length (palabra2) do p2 := p2 + utils.EnMinuscula (palabra2[i]);
    if p1 = p2
    then Equals := true
    else begin
        Equals := false;
        writeln ('Wrong guess');
        write ('New clues: ');
        for i := 1 to length (p2) do begin
            if (index(p2, p2[i]) = i) and_then (index(p1, p2[i]) > 0)
            then begin
                if (index(p1, p2[i]) = i)
                then write (utils.EnMayuscula(p2[i]))
                else write (utils.EnMinuscula(p2[i]))
            end
            else write ('?');
        end;
    end;
end;

function GuessWord (hiddenWord: types.tWord): types.tAttemps;
var play: boolean; userInput: types.tWord; numOfAttemps: types.tAttemps;
begin
    play := true;
    numOfAttemps := 1;
    while play do begin
        write ('Type a word with ', length (hiddenWord):0, ' letters: ');
        readln (userInput);
        userInput := trim (userInput);
        if Equals (hiddenWord, userInput)
        then begin
            writeln;
            utils.CenterText ('Congratulations! You guessed the word!');
            play := false;
        end
        else begin
            writeln;
            write ('Wrong guess. Confirm to continue. ');
            if utils.Confirm
            then numOfAttemps := numOfAttemps + 1
            else begin
                numOfAttemps := 0;
                play := false;
            end;
        end;
    end;
    GuessWord := numOfAttemps;
end;

procedure SaveGame (var highscoresList: types.tHighscoresList; hiddenWord: types.tWord; numOfAttemps: types.tAttemps);
var  newGame: types.tGameRecord; DateTime: types.tDateTime;
begin
    newGame.Word := hiddenWord;
    newGame.Attemps := numOfAttemps;
    write('Type your name: ');
    readln (newGame.Player);
    GetTimeStamp(DateTime);
    newGame.DateTime := DateTime;
    highscores.Add(highscoresList, newGame);
    if highscores.Save(highscoresList)
    then writeln('Highscores saved successfully')
    else writeln('Error saving highscores');
    writeln;
end;

procedure PlayGame;
var language: types.tLanguage; length: integer value 0; finished: boolean value false; hiddenWord: types.tWord; numOfAttemps: types.tAttemps;
begin
    writeln;
    writeln('-------------------------');
    if withValidation
    then writeln('  Validate')
    else writeln('  Play');
    writeln('-------------------------');
    language := utils.ChooseLanguage;
    if language = types.NoLang
    then finished := true;
    
    if not finished
    then length := utils.ChooseLength;
    if length = 0
    then finished := true;

    if not finished
    then begin
        hiddenWord := dictionary.GetWord(language, length);
        if hiddenWord = ''
        then begin
            if utils.PrintError ('Can not open the file')
            then begin
                write ('Returning to Main Menu. Press ENTER.');
                readln;
            end
            else begin
                writeln ('Execution aborted');
                halt;
            end;
        end
        else begin
            writeln;
            if withValidation
            then writeln ('Hidden word: ', hiddenWord);
            numOfAttemps := GuessWord (hiddenWord);
            SaveGame(highscoresList, hiddenWord, numOfAttemps);
        end;
    end;
end;

end.