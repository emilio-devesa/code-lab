module types;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    types.pas
    Provides common type and constant definitions
}


export  types = (
            TAB,
            F_CASTILLAN,
            F_GALICIAN,
            F_ENGLISH,
            F_HIGHSCORES,
            MAX_GAMES,
            tPalabra,
            tNumeroIntentos,
            tNombreJugador,
            tFechaJugada,
            tGameRecord,
            tHighscoresList,
            tCriteria,
            Word,
            Player,
            Attemps,
            DateTime,
            tFileName,
            tBinFile,
            tTextFile
);

const   TAB = chr(9);
        F_CASTILLAN = 'data/Castellano';
        F_GALICIAN = 'data/Gallego';
        F_ENGLISH = 'data/Ingles';
        F_HIGHSCORES = 'data/HistoricodeJugadas';
        MAX_GAMES = 100;

type    tPalabra = string (6);
        tNumeroIntentos = integer;  
        tNombreJugador = string (30);
        tFechaJugada = TimeStamp;
        tGameRecord = record
            Word: tPalabra;
            Player: tNombreJugador;
            Attemps: tNumeroIntentos;
            DateTime: tFechaJugada;
        end;
        tHighscoresList = record
            item: array [1..MAX_GAMES] of tGameRecord;
            size: integer;
        end;
        tCriteria = (Word, Player, Attemps, DateTime);
        tFileName = string (23);
        tBinFile = bindable file of tHighscoresList;
        tTextFile = bindable text;


end;


end.