module types;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    types.pas
    Provides common type and constant definitions
}


export  types = (
            TAB,
            PAGE_SIZE,
            F_CASTILLIAN,
            F_GALICIAN,
            F_ENGLISH,
            F_HIGHSCORES,
            MAX_GAMES,
            tLanguage,
            NoLang,
            Castillian,
            Galician,
            English,
            tWord,
            tPlayer,
            tAttemps,
            tDateTime,
            tGameRecord,
            tHighscoresList,
            tCriteria,
            Word,
            Player,
            Attemps,
            DateTime,
            tWordList,
            tFileName,
            tBinFile,
            tTextFile
);

const   TAB = chr(9);
        PAGE_SIZE = 18;
        F_CASTILLIAN = 'data/Castellano';
        F_GALICIAN = 'data/Gallego';
        F_ENGLISH = 'data/Ingles';
        F_HIGHSCORES = 'data/HistoricodeJugadas';
        MAX_GAMES = 100;

type    tLanguage = (NoLang, Castillian, Galician, English);
        tWord = string (6);
        tAttemps = integer value 0;  
        tPlayer = string (30);
        tDateTime = TimeStamp;
        tGameRecord = record
            Word: tWord;
            Player: tPlayer;
            Attemps: tAttemps;
            DateTime: tDateTime;
        end;
        tHighscoresList = record
            item: array [1..MAX_GAMES] of tGameRecord;
            size: integer value 0;
        end;
        tCriteria = (Word, Player, Attemps, DateTime);
        tWordList = record
            item: array [1..100] of tWord;
            size: integer value 0;
        end;
        tFileName = string (23);
        tBinFile = bindable file of tHighscoresList;
        tTextFile = bindable text;


end;


end.