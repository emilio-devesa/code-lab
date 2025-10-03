module types;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    types.pas
    Provides common type and constant definitions
}


export  types = (
            TAB,
            tPalabra,
            tNumeroIntentos,
            tNombreJugador,
            tFechaJugada,
            tGameRecord
);

const   TAB = chr(9);

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


end;


end.