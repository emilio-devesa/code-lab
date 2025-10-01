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
        base qualified;

procedure Validar;
procedure Jugar;


end;


function NumeroAleatorio: integer;
{
    Objetivo:   Genera un numero aleatorio positivo de 2 cifras
    PosCD:      El resultado siempre es n >= 0 y n <= 99
}
var tiempo: TimeStamp; semilla: integer;
begin
    GetTimeStamp (tiempo);
    semilla := tiempo.MicroSecond;
    NumeroAleatorio := (semilla * 54321) mod 100;
end;

function PalabraFichero (var f: base.tFTexto; pos: integer): base.tPalabra;
{
    Objetivo:   Lee una palabra de un fichero
    PreCD:      El fichero existe y ha sido ligado
}
var lineas, i: integer; palabra: base.tPalabra;
begin
    reset (f);
    lineas := NumeroAleatorio;
    for i := 0 to lineas do readln (f);     {avanzar lineas}
    for i := 1 to pos do begin
        palabra := '';
        while f^ <> base.TABULACION do begin
            palabra := palabra + f^;
            get (f);
        end;
        get (f);
        PalabraFichero := trim (palabra);
    end;  
end;

function PalabraLeida: base.tPalabra;
{
    Objetivo:   Liga el fichero correspondiente al idioma seleccionado y
                llama a la funcion PalabraFichero para extraer una palabra de
                la longitud deseada.
                Devuelve una cadena vacia si no se pudo acceder al fichero.
}
var idioma, largo: integer; f: base.tFTexto; palabra: base.tPalabra;
begin
    idioma := base.IdiomaFichero;
    largo := base.LongitudPalabra;
    case idioma of
        1:  if base.ExisteFTexto (base.F_CASTELAN) and_then base.LigaFTexto (f, base.F_CASTELAN)
            then PalabraLeida := PalabraFichero (f, largo)
            else PalabraLeida := '';
        2:  if base.ExisteFTexto (base.F_GALEGO) and_then base.LigaFTexto (f, base.F_GALEGO)
            then PalabraLeida := PalabraFichero (f, largo)
            else PalabraLeida := '';
        3:  if base.ExisteFTexto (base.F_INGLES) and_then base.LigaFTexto (f, base.F_INGLES)
            then PalabraLeida := PalabraFichero (f, largo)
            else PalabraLeida := '';
    end;
end;

function SonIguales (palabra1, palabra2: base.tPalabra): boolean;
{
    Objetivo:   Compara si dos palabras son iguales. Si no lo son, escribe
                las pistas para adivinarla en la salida estandar.
    PosCD:      Devuelve TRUE si son iguales o FALSE en caso contrario.
}
var i: integer; p1, p2: base.tPalabra;
begin
    p1 := '';
    p2 := '';
    for i := 1 to length (palabra1) do p1 := p1 + base.EnMinuscula (palabra1[i]);
    for i := 1 to length (palabra2) do p2 := p2 + base.EnMinuscula (palabra2[i]);
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
                then write (base.EnMayuscula(p2[i]))
                else write (base.EnMinuscula(p2[i]))
            end
            else write ('?');
        end;
    end;
end;

function DescubrePalabra (palabra1: base.tPalabra): base.tNumeroIntentos;
{
    Objetivo:   Comparacion de la palabra original con la palabra introducida
                por el usuario hasta que se rinda o acierte
    PosCD:      Devuelve el numero de intentos necesarios para adivinar la
                palabra o 0 si el jugador se ha rendido
}
var continuar: boolean; palabra2: base.tPalabra; intentos: base.tNumeroIntentos;
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
            base.CentrarTexto ('Felicidades! Palabra adivinada!');
            continuar := false;
        end
        else begin
            writeln;
            write ('Intento fallido. Confirme para continuar. ');
            if base.PedirConfirmacion
            then intentos := intentos + 1
            else begin
                intentos := 0;
                continuar := false;
            end;
        end;
    end;  {de while}
    DescubrePalabra := intentos;
end;

procedure GuardarRegistro (var p: base.tPalabra; i: base.tNumeroIntentos);
{
    Objetivo:   Pide los datos al usuario y los almacena en un fichero de
                historico externo.
}
var pos: integer; nombre: base.tNombreJugador; fecha: base.tFechaJugada;
    preparado: boolean; f: base.tFHistorico;
begin
    write ('Escriba su nombre: ');
    readln (nombre);
    nombre := trim (nombre);
    fecha := base.ObtenerFechaComoString;
    writeln ('La fecha es: ', fecha, '.');
    writeln;
    writeln ('Preparando el fichero historico del juego...');
    if base.ExisteFHistorico (base.F_HISTORICO)
    then begin
        if base.LigaFHistorico (f, base.F_HISTORICO)
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
        if base.LigaFHistorico (f, base.F_HISTORICO)
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
        f^.PalabraPorDescubrir := p;
        f^.NombreJugador := nombre;
        f^.NumeroIntentos := i;
        f^.FechaJugada := fecha;
        put (f);
        writeln ('OK');
    end
    else begin
        if base.MostrarError ('El guardado de datos informo de un problema.')
        then writeln ('Saltando guardado de datos...')
        else begin
            writeln ('El programa se detendra a continuacion.');
            halt;
        end;
    end;
end;

procedure Validar;
{
    Objetivo:   Proporciona un metodo de validacion del juego, revelando la
                palabra a descubrir antes de iniciar las preguntas.
}
var palabra: base.tPalabra; intentos: base.tNumeroIntentos;
begin
    base.CentrarTexto ('Opcion Validar');
    palabra := PalabraLeida;
    if palabra = ''
    then begin
        if base.MostrarError ('No se puede acceder al fichero.')
        then begin
            write ('Se volvera al menu principal. Pulse INTRO.');
            readln;
        end
        else begin
            writeln ('El programa se detendra a continuacion.');
            halt;
        end;
    end
    else begin
        writeln ('Palabra a descubrir: ', palabra);
        writeln;
        intentos := DescubrePalabra (palabra);
        GuardarRegistro (palabra, intentos);
    end;
end;

procedure Jugar;
var palabra: base.tPalabra; intentos: base.tNumeroIntentos;
{
    Objetivo:   Proporciona la experiencia de juego
}
begin
    base.CentrarTexto ('Opcion Jugar');
    palabra := PalabraLeida;
    if palabra = ''
    then begin
        if base.MostrarError ('No se puede acceder al fichero.')
        then begin
            write ('Se volvera al menu principal. Pulse INTRO.');
            readln;
        end
        else begin
            writeln ('El programa se detendra a continuacion.');
            halt;
        end;
    end
    else begin
        writeln;
        intentos := DescubrePalabra (palabra);
        GuardarRegistro (palabra, intentos);
    end;
end;

end.