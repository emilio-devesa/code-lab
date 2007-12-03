program comentarios (input, output);
{Autor      Emilio Devesa
 Archivo    comentarios.pas
 Objetivo   Mostrar el formato y el contenido de los comentarios
 Fecha      3/12/2007
 Versión    1.0
 Notas      Los comentarios deben ser:
                - coherentes: siempre con el mismo formato
                - oportunos: tienen que estar cuando y donde proceda
}
{***********************************************}
const
    IVA = 0.16; {esto es el iva} {¡¡ superfluo !!}

type
    tNombArchivo = string(255);
    tNombPersona = string(50);

var
    nombre,                     {nombre de pila}
    appNombre : tNombPersona;   {apellidos, nombre}
    
{** function
*   ExtraeNombre ( nombre : tNombPersona ):tNombPersona;
*   Objeto
*       Extrae el nombre de pila de la cadena apellidos, nombre
*   CPrev
*       El argumento está completo y bien formado
*       El nombre sigue a los apellidos
*       Hay una coma y un espacio después del segundo apellido
*   CPost
*       Devuelve el nombre
*       Ejemplo
*         argumento: Ruipérez Puente, Alfonso
*         resultado: Alfonso
*}
function ExtraeNombre(nombre: tNombPersona):tNombPersona;
var posComa : integer;
begin
    posComa := index (nombre, ',');
    ExtraeNombre := substr(nombre, poscoma + 2);
end;

begin
    writeln('Escriba su nombre: apellidos, nombre ');
    readln(appNombre);
    nombre := ExtraeNombre(appNombre);
    writeln('Su nombre es: ', nombre);
end.
{***********************************************}
