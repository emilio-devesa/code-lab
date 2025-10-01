module base;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    base.pas
    Provides common utilities and definitions for constants and types
}


export  base = (
            tPalabra, tNumeroIntentos,
            tNombreJugador, tFechaJugada, tRegistroHistorico,
            tNombreFichero, tFHistorico, tFTexto,
            TABULACION,
            F_CASTELAN, F_GALEGO, F_INGLES, F_HISTORICO,
            PedirConfirmacion, LimpiarPantalla, CentrarTexto,
            MostrarError, MostrarErrorFatal,
            ExisteFHistorico, LigaFHistorico,
            ExisteFTexto, LigaFTexto,
            IdiomaFichero, LongitudPalabra,
            EnMinuscula, EnMayuscula,
            ObtenerFechaComoString, ConvertirFechaEnEntero
);

import  StandardInput;
        StandardOutput;

const   F_CASTELAN = 'Castellano';
        F_GALEGO = 'Gallego';
        F_INGLES = 'Ingles';
        F_HISTORICO = 'HistoricodeJugadas';
        TABULACION = chr(9);

type    tPalabra = string (6);
        tNumeroIntentos = integer;  
        tNombreJugador = string (30);
        tFechaJugada = string (18);
        tRegistroHistorico = record
            PalabraPorDescubrir: tPalabra;
            NombreJugador: tNombreJugador;
            NumeroIntentos: tNumeroIntentos;
            FechaJugada: tFechaJugada;
        end;
        tNombreFichero = string (20);
        tFHistorico = bindable file [0..MAXINT] of tRegistroHistorico;
        tFTexto = bindable text;

function PedirConfirmacion: boolean;
procedure LimpiarPantalla;
procedure CentrarTexto (c: string);
function MostrarError (error: string): boolean;
procedure MostrarErrorFatal (error: string);
function ExisteFHistorico (nombre: tNombreFichero): boolean;
function LigaFHistorico (var f: tFHistorico; nombre: tNombreFichero): boolean;
function ExisteFTexto (nombre: tNombreFichero): boolean;
function LigaFTexto (var f: tFTexto; nombre: tNombreFichero): boolean;
function IdiomaFichero: integer;
function LongitudPalabra: integer;
function EnMinuscula (c: char): char;
function EnMayuscula (c: char): char;
function ObtenerFechaComoString: tFechaJugada;
function ConvertirFechaEnEntero (f: tFechaJugada): integer;


end;


function PedirConfirmacion;
{   
    Objetivo: Pide al usuario una confirmacion del tipo Si/No
    PosCD:    Devuelve TRUE si responde "Si" o FALSE en caso contrario
}
var respuesta: char value 'a';
begin
    while respuesta = 'a' do begin
        write ('Confirmar? (S/N): ');
        readln (respuesta);
        writeln;
        case respuesta of
            's': PedirConfirmacion := true;
            'S': PedirConfirmacion := true;
            'n': PedirConfirmacion := false;
            'N': PedirConfirmacion := false;
            otherwise respuesta := 'a';
        end;
    end;
end;

procedure LimpiarPantalla;
{   
    Objetivo: Limpia la salida estandar para una visualizacion mas comoda
}
var i: integer;
begin
    for i := 1 to 24 do writeln;
    writeln (chr(27), '[H', chr (27), '[J');
end;

procedure CentrarTexto;
{
    Objetivo: Muestra un texto centrado en la salida estandar
}
begin
    writeln (c:(40 + length(c) div 2));
end;

function MostrarError;
{   
    Objetivo: Pide al usuario una confirmacion de tipo Si/No ante un error
           salvable
    PosCD:    Devuelve TRUE si escoge continuar o FALSE en caso contrario
}
begin
    writeln ('Error: ', error);
    write ('Se necesita confirmacion para continuar. ');
    if PedirConfirmacion
    then MostrarError := true
    else MostrarError := false;
end;

procedure MostrarErrorFatal;
{   
    Objetivo: Muestra un mensaje de error grave y detiene la ejecuci�n
}
begin
    writeln ('ATENCION! Error Fatal: ', error);
    writeln ('El programa se va a cerrar.');
    writeln;
    halt;
end;

function ExisteFHistorico;
{
    Objetivo: Comprueba si existe un fichero con nombre tNombreFichero
    PreCD:    El fichero es externo (bindable)
    PosCD:    Devuelve TRUE si existe o FALSE en caso contrario
}
var b: bindingtype; f: tFHistorico;
begin
    unbind (f);         {desenlaza f de enlaces previos si los hay}
    b := binding (f);   {inicia b}
    b.name := nombre;
    bind (f, b);        {enlaza la variable f con el fichero argumento}
    b := binding (f);   {actualiza b}
    ExisteFHistorico := b.existing;
end;

function LigaFHistorico;
{
    Objetivo: Enlaza un fichero tFHistorico
    PreCD:    El fichero es externo (bindable)
    PosCD:    Devuelve TRUE si ha podido enlazarlo o sino FALSE
}
var b: bindingtype;
begin
    unbind (f);         {desenlaza f de enlaces previos si los hay}
    b := binding (f);   {inicia b}
    b.name := nombre;
    bind (f, b);        {enlaza la variable f con el fichero argumento}
    b := binding (f);   {actualiza b}
    LigaFHistorico := b.bound;
end;

function ExisteFTexto;
{
    Objetivo: Comprueba si existe un fichero con nombre tNombreFichero
    PreCD:    El fichero es externo (bindable)
    PosCD:    Devuelve TRUE si existe o FALSE en caso contrario
}
var b: bindingtype; f: tFTexto;
begin
    unbind (f);         {desenlaza f de enlaces previos si los hay}
    b := binding (f);   {inicia b}
    b.name := nombre;
    bind (f, b);        {enlaza la variable f con el fichero argumento}
    b := binding (f);   {actualiza b}
    ExisteFTexto := b.existing;
end;

function LigaFTexto;
{
    Objetivo: Enlaza un fichero tFTexto
    PreCD:    El fichero es externo (bindable)
    PosCD:    Devuelve TRUE si ha podido enlazarlo o sino FALSE
}
var b: bindingtype;
begin
    unbind (f);         {desenlaza f de enlaces previos si los hay}
    b := binding (f);   {inicia b}
    b.name := nombre;
    bind (f, b);        {enlaza la variable f con el fichero argumento}
    b := binding (f);   {actualiza b}
    LigaFTexto := b.bound;
end;

function IdiomaFichero;
{
    Objetivo: Se muestra un menu donde se escoge el idioma
    PosCD:    La opcion es 1 (castelan), 2 (galego) o 3 (ingles)
}
var opcion: char value 'a';
begin
    while opcion = 'a' do begin
        writeln ('Seleccionar idioma:');
        writeln ('1. Castellano');
        writeln ('2. Galego');
        writeln ('3. Ingles');
        write ('Opcion (1-3): ');
        readln (opcion);
        writeln;
        case opcion of
            '1': IdiomaFichero := 1;
            '2': IdiomaFichero := 2;
            '3': IdiomaFichero := 3;
            otherwise begin
                writeln ('Opcion no valida.');
                opcion := 'a';
            end;
        end;  {de case}
    end;  {de while}
end;

function LongitudPalabra;
{
    Objetivo: Se muestra un menu donde se escoge la longitud de palabras
    PosCD:    La opcion es 1 (4 letras), 2 (5 letras) o 3 (6 letras)
}
var opcion: char value 'a';
begin
  while opcion = 'a' do begin
    writeln ('Seleccionar longitud de palabras:');
    writeln ('1) Palabras de 4 letras');
    writeln ('2) Palabras de 5 letras');
    writeln ('3) Palabras de 6 letras');
    write ('Opcion (1-3): ');
    readln (opcion);
    writeln;
    case opcion of
        '1': LongitudPalabra := 1;
        '2': LongitudPalabra := 2;
        '3': LongitudPalabra := 3;
        otherwise begin
            writeln ('Opcion no valida.');
            opcion := 'a';
        end;
    end;  {de case}
  end;  {de while}
end;

function EnMinuscula;
{
    Objetivo: Convierte una letra mayuscula en minuscula si esta en el
              conjunto cM.
    PreCD:    La entrada es un caracter ASCII
    PosCD:    Devuelve una letra minuscula o el mismo caracter si ya era
              una minuscula o un simbolo.
}
type tCMayusculas = set of 'A' .. 'Z';
var cMay: tCMayusculas;
begin
    if c in cMay
    then EnMinuscula := chr(ord(c)+32)
    else EnMinuscula := c;
end;

function EnMayuscula;
{
    Objetivo: Convierte una letra minuscula en mayuscula si esta en el
              conjunto cm.
    PreCD:    La entrada es un caracter ASCII
    PosCD:    Devuelve una letra mayuscula o el mismo caracter si ya era
              una mayuscula o un simbolo.
}
type tCMinusculas = set of 'a' .. 'z';
var cmin: tCMinusculas;
begin
    if c in cmin
    then EnMayuscula := chr(ord(c)-32)
    else EnMayuscula := c;
end;

function ObtenerFechaComoString;
{
    Objetivo: Toma la fecha del sistema y devuelve un string tFechaJugada.
    PosCD:    El formato de salida es 'dd mes_con_letras aaaa'.
}
var tiempo: TimeStamp; mes: string (10) value ''; cAux: tFechaJugada;
begin
    cAux := '';
    GetTimeStamp (tiempo);
    case tiempo.month of
        1: mes := 'enero';
        2: mes := 'febrero';
        3: mes := 'marzo';
        4: mes := 'abril';
        5: mes := 'mayo';
        6: mes := 'junio';
        7: mes := 'julio';
        8: mes := 'agosto';
        9: mes := 'septiembre';
        10: mes := 'octubre';
        11: mes := 'noviembre';
        12: mes := 'diciembre';
    end;
    writestr (cAux, tiempo.day:1, ' ', mes, ' ', tiempo.year:0);
    ObtenerFechaComoString := cAux;
end;

function ConvertirFechaEnEntero;
{
    Objetivo: Transforma un dato tFechaJugada (string) al formato aaaammdd.
    PreCD:    f tiene el formato 'dd mes_con_letras aaaa'.
    PosCD:    Devuelve un integer que se corresponde con aaaammdd.
}
var aaaa: string (4); mm: string (10); dd: string (2); i,j,k: integer;
begin
    dd := substr (f,1,2);                      {los 2 primeros char = dd}
    aaaa := substr (f, (length(f)-4), 4);      {los 4 ultimos char = aaaa}
    mm := substr (f, 4, (length(f)-8));        {la palabra del medio = mm}
    if (mm = 'enero')       then j := 1;
    if (mm = 'febrero')     then j := 2;
    if (mm = 'marzo')       then j := 3;
    if (mm = 'abril')       then j := 4;
    if (mm = 'mayo')        then j := 5;
    if (mm = 'junio')       then j := 6;
    if (mm = 'julio')       then j := 7;
    if (mm = 'agosto')      then j := 8;
    if (mm = 'septiembre')  then j := 9;
    if (mm = 'octubre')     then j := 10;
    if (mm = 'noviembre')   then j := 11;
    if (mm = 'diciembre')   then j := 12;
    readstr (dd, k);
    readstr (aaaa, i);
    ConvertirFechaEnEntero := ((i*100)+j)*100 + k;
end;


end.