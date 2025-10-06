module game;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    game.pas
    Provides game operations and control
}


export  game = (
            Validar,
            Jugar
);

import  StandardInput;
        StandardOutput;
        types qualified;
        utils qualified;
        files qualified;
        highscores qualified;

procedure Validar (highscoresList: types.tHighscoresList);
procedure Jugar (highscoresList: types.tHighscoresList);


end;


function PalabraFichero (var f: types.tTextFile; pos: integer): types.tPalabra;
{
    Objetivo:   Lee una palabra de un fichero
    PreCD:      El fichero existe y ha sido ligado
}
var lineas, i: integer; palabra: types.tPalabra;
begin
    reset (f);
    lineas := utils.GetRandomInteger(100);
    for i := 0 to lineas do readln (f);     {avanzar lineas}
    for i := 1 to pos do begin
        palabra := '';
        while f^ <> types.TAB do begin
            palabra := palabra + f^;
            get (f);
        end;
        get (f);
        PalabraFichero := trim (palabra);
    end;  
end;

function PalabraLeida: types.tPalabra;
var idioma, largo: integer; f: types.tTextFile;
begin
    idioma := utils.ChooseLanguage;
    if idioma > 0
    then begin
        largo := utils.ChooseLength;
        if largo > 0
        then begin
            case idioma of
                1:  if files.TextFileExists (f, types.F_CASTILLAN) and_then files.TextFileIsBound (f, types.F_CASTILLAN)
                    then PalabraLeida := PalabraFichero (f, largo)
                    else PalabraLeida := '';
                2:  if files.TextFileExists (f, types.F_GALICIAN) and_then files.TextFileIsBound (f, types.F_GALICIAN)
                    then PalabraLeida := PalabraFichero (f, largo)
                    else PalabraLeida := '';
                3:  if files.TextFileExists (f, types.F_ENGLISH) and_then files.TextFileIsBound (f, types.F_ENGLISH)
                    then PalabraLeida := PalabraFichero (f, largo)
                    else PalabraLeida := '';
            end;
        end;
    end;
end;

function SonIguales (palabra1, palabra2: types.tPalabra): boolean;
{
    Objetivo:   Compara si dos palabras son iguales. Si no lo son, escribe
                las pistas para adivinarla en la salida estandar.
    PosCD:      Devuelve TRUE si son iguales o FALSE en caso contrario.
}
var i: integer; p1, p2: types.tPalabra;
begin
    p1 := '';
    p2 := '';
    for i := 1 to length (palabra1) do p1 := p1 + utils.EnMinuscula (palabra1[i]);
    for i := 1 to length (palabra2) do p2 := p2 + utils.EnMinuscula (palabra2[i]);
    if p1 = p2
    then SonIguales := true
    else begin
        SonIguales := false;
        writeln ('No es correcta');
        write ('Nuevas pistas: ');
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

function DescubrePalabra (palabra1: types.tPalabra): types.tNumeroIntentos;
{
    Objetivo:   Comparacion de la palabra original con la palabra introducida
                por el usuario hasta que se rinda o acierte
    PosCD:      Devuelve el numero de intentos necesarios para adivinar la
                palabra o 0 si el jugador se ha rendido
}
var continuar: boolean; palabra2: types.tPalabra; intentos: types.tNumeroIntentos;
begin
    continuar := true;
    intentos := 1;
    while continuar do begin
        write ('Introduzca palabra de ', length (palabra1):0, ' letras: ');
        readln (palabra2);
        palabra2 := trim (palabra2);
        if SonIguales (palabra1, palabra2)
        then begin
            writeln;
            utils.CenterText ('Felicidades! Palabra adivinada!');
            continuar := false;
        end
        else begin
            writeln;
            write ('Intento fallido. Confirme para continuar. ');
            if utils.Confirm
            then intentos := intentos + 1
            else begin
                intentos := 0;
                continuar := false;
            end;
        end;
    end;  {de while}
    DescubrePalabra := intentos;
end;

procedure GuardarRegistro (var highscoresList: types.tHighscoresList; p: types.tPalabra; i: types.tNumeroIntentos);
{
    Objetivo:   Pide los datos al usuario y los almacena en un fichero de
                historico externo.
}
var pos: integer; nombre: types.tNombreJugador; fecha: types.tFechaJugada;
    {preparado: boolean; f: types.tBinFile;}
    newRecord: types.tGameRecord;
begin
    newRecord.Word := p;
    newRecord.Attemps := i;
    write ('Escriba su nombre: ');
    readln (nombre);
    newRecord.Player := trim (nombre);
    GetTimeStamp(fecha);
    writeln ('La fecha es: ', Date(fecha), '.');
    newRecord.DateTime := fecha;
    highscores.Add(highscoresList, newRecord);
    highscores.Save(highscoresList);
    writeln;
    {writeln ('Preparando el fichero historico del juego...');
    if files.BinFileExists (f, files.F_HIGHSCORES) and_then files.BinFileIsBound (f, files.F_HIGHSCORES)
        then begin
            write ('Ya existe el fichero. Accediendo... ');
            writeln ('OK.');
            writeln;
            preparado := true;
        end
        else begin
            writeln ('Fichero no accesible.');
            writeln;
            preparado := false;
        end;
    end
    else begin
        if files.BinFileIsBound (f, files.F_HIGHSCORES)
        then begin
            write ('Creando un fichero vacio... ');
            rewrite (f);
            writeln ('OK');
            preparado := true;
        end
        else begin
            writeln ('Imposible crear un fichero vacio.');
            preparado := false;
        end;
    end;
    if preparado
    then begin
        reset (f);
        write ('Grabando...');
        if empty (f)
        then pos := 0
        else pos := LastPosition (f);
        seekupdate (f, pos);
        f^.Word := p;
        f^.Player := nombre;
        f^.Attemps := i;
        f^.DateTime := fecha;
        put (f);
        writeln ('OK');
    end
    else begin
        if utils.PrintError ('Can not save data')
        then writeln ('Skipping data save...')
        else begin
            writeln ('Execution aborted.');
            halt;
        end;
    end;}
end;

procedure Validar;
{
    Objetivo:   Proporciona un metodo de validacion del juego, revelando la
                palabra a descubrir antes de iniciar las preguntas.
}
var palabra: types.tPalabra; intentos: types.tNumeroIntentos;
begin
    writeln;
    writeln('-------------------------');
    writeln('  Validate');
    writeln('-------------------------');
    palabra := PalabraLeida;
    if palabra = ''
    then begin
        if utils.PrintError ('Can not open file.')
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
        writeln ('Palabra a descubrir: ', palabra);
        writeln;
        intentos := DescubrePalabra (palabra);
        GuardarRegistro (highscoresList, palabra, intentos);
    end;
end;

procedure Jugar;
var palabra: types.tPalabra; intentos: types.tNumeroIntentos;
{
    Objetivo:   Proporciona la experiencia de juego
}
begin
    writeln;
    writeln('-------------------------');
    writeln('  Play');
    writeln('-------------------------');
    palabra := PalabraLeida;
    if palabra = ''
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
        intentos := DescubrePalabra (palabra);
        GuardarRegistro (highscoresList, palabra, intentos);
    end;
end;

end.