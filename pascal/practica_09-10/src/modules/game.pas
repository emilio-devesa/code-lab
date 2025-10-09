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

procedure PlayGame (withValidation: boolean);


end;

function Equals (a, b: types.tWord): boolean;
var i: integer; aux1, aux2: types.tWord;
begin
    aux1 := '';
    aux2 := '';
    for i := 1 to length (a) do aux1 := aux1 + utils.ToLowercase (a[i]);
    for i := 1 to length (b) do aux2 := aux2 + utils.ToLowercase (b[i]);
    if EQ(aux1, aux2)
    then Equals := true
    else begin
        Equals := false;
        writeln ('Wrong guess');
        write ('New clues: ');
        for i := 1 to length (aux2) do begin
            if (index(aux2, aux2[i]) = i) and_then (index(aux1, aux2[i]) > 0)
            then begin
                if (index(aux1, aux2[i]) = i)
                then write (utils.ToUppercase(aux2[i]))
                else write (utils.ToLowercase(aux2[i]))
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

procedure SaveGame (hiddenWord: types.tWord; numOfAttemps: types.tAttemps);
var  newGame: types.tGameRecord; DateTime: types.tDateTime;
begin
    newGame.Word := hiddenWord;
    newGame.Attemps := numOfAttemps;
    write('Type your name: ');
    readln (newGame.Player);
    GetTimeStamp(DateTime);
    newGame.DateTime := DateTime;
    highscores.Add(newGame);
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
                writeln ('Returning to Main Menu.');
                utils.WaitForEnter;
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
            SaveGame(hiddenWord, numOfAttemps);
        end;
    end;
end;

end.