program CalcularNIF (input, output);
{Titulo     CalcularNIF
 Autor      Emilio Devesa
 Archivo    CalcularNIF.pas
 Objetivo   Calcular la letra de un NIF correspondiente a un DNI dado
 Fecha      19/Sep/2010
 Notas:     Compilacion con:
            $ gpc --extended-pascal -o CalcularNIF CalcularNIF.pas
            Ejecucion con:
            $ ./CalcularNIF
}

{ ############################## }
        {Interfaz}
{ ############################## }
const CADENA = 'TRWAGMYFPDXBNJZSQVHLCKE';
type tDNI = 00000000 .. 99999999;

{ ############################## }
        {Implementacion}
{ ############################## }
function LeeDNI: tDNI;
{Objetivo: Lee por la entrada estandar un DNI
 PosCD: La salida es tDNI
}
var dato: string (8); numero: tDNI;
begin
    write ('Escribe tu DNI: ');
    readln (dato);
    readstr (dato, numero);
    LeeDNI := numero;
end;

procedure CalcularNIF (DNI: tDNI);
{Objetivo: Calcula la letra del NIF y muestra todo en pantalla.}
var letra: char; resto: integer;
begin
    resto := (DNI mod 23) + 1;
    letra := substr(CADENA, resto, 1);
    writeln ('Tu NIF es ', DNI:0, letra);
end;

{ ############################## }
        {Carga y cierre}
{ ############################## }
begin
    CalcularNIF (LeeDNI);
end.