module listados;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    base.pas
    Provides common utilities and definitions for constants and types
}


export  listados = (
        OrdenarHistorico, 
        Listado1, 
        Listado2, 
        OrdenarTexto
);

import  StandardInput;
        StandardOutput;
        base;

procedure OrdenarHistorico;
procedure Listado1;
procedure Listado2;
procedure OrdenarTexto;


end;


procedure OrdenarHistorico;
{
    Objetivo:   Aglutina las operaciones de ordenación del fichero historico
                bajo un único procedimiento
    PosCD:      El fichero f contiene los datos del historico ya ordenados
}
type tArchivo = file [0..MAXINT] of tRegistroHistorico;
var criterio: integer; f_his: tFHistorico; f: tArchivo;

    function esCampoMenor (r1, r2: tRegistroHistorico): boolean;
    {
        Objetivo:   Devuelve TRUE si el campo criterio del primer registro es
                    menor que el del segundo o FALSE en caso contrario.
    }
    var fecha1, fecha2: integer;
    begin
        case criterio of
            1: EsCampoMenor := r1.PalabraPorDescubrir < r2.PalabraPorDescubrir;
            2: EsCampoMenor := r1.NombreJugador < r2.NombreJugador;
            3: EsCampoMenor := r1.NumeroIntentos < r2.NumeroIntentos;
            4: begin
                fecha1 := ConvertirFechaEnEntero (r1.FechaJugada);
                fecha2 := ConvertirFechaEnEntero (r2.FechaJugada);
                EsCampoMenor := fecha1 < fecha2;
            end;
        end;
    end;

    procedure CopiarRegistro (var de, a: tArchivo; var fin: boolean);
    {
        Objetivo:   Copia un registro de "de" hasta "a" y comprueba si el campo
                    usado como criterio es menor en el registro siguiente que
                    en el registro copiado.
    }
    begin
        if not eof (de)
        then begin
            read (de, a^);
            if eof (de)
            then fin := true
            else fin := EsCampoMenor (de^, a^);
            put (a);
        end
        else fin := true;
    end;

    procedure CopiarSubFicheros (var de, a: tArchivo; var fin: boolean);
    {
        Objetivo:   Copia un subarchivo desde "de" hasta "a".
    }
    begin
        fin := false;
        while not fin do CopiarRegistro (de, a, fin);
    end;
    
    procedure DividirArchivo (var f, f1, f2: tArchivo);
    {
        Objetivo:   Divide un archivo f en los archivos f1 y f2 copiando de
                    forma natural los subarchivos ordenados de f
                    alternativamente a f1 y f2.
    }
    var num_fichero: 1..2; fin_subf: boolean;
    begin
        reset (f);
        rewrite (f1);
        rewrite (f2);
        num_fichero := 1;
        while not eof (f) do begin
            case num_fichero of
                1: CopiarSubFicheros (f, f1, fin_subf);
                2: CopiarSubFicheros (f, f2, fin_subf);
            end;
            num_fichero := 3 - num_fichero;
        end;
    end;
    
    procedure Mezclar (var f, f1, f2: tArchivo; var n: integer);
    {
        Objetivo:   Mezcla los subficheros correspondientes ordenados en f1 y
                    f2 dentro de un archivo f. n es el numero de subarchivos
                    ordenados producidos en f.
    }
    var fin1, fin2: boolean;
    begin
        reset (f1);
        reset (f2);
        rewrite (f);
        n := 0;
        while not (eof(f1) or eof(f2)) do begin
            fin1 := false;
            fin2 := false;
            repeat
                if EsCampoMenor (f1^, f2^)
                then CopiarRegistro (f1, f, fin1)
                else CopiarRegistro (f2, f, fin2);
            until fin1 or fin2;
            if fin1
            then CopiarSubFicheros (f2, f, fin2)
            else CopiarSubFicheros (f1, f, fin1);
            n := n + 1;
        end;
        while not eof (f1) do begin
            CopiarSubFicheros (f1, f, fin1);
            n := n + 1;
        end;
        while not eof (f2) do begin
            CopiarSubFicheros (f2, f, fin2);
            n := n + 1;
        end;
    end;

    procedure Ordenar (var f: tArchivo);
    var f1, f2: tArchivo; num_subf: integer;
    begin
        num_subf := 0;
        repeat
            DividirArchivo (f, f1, f2);
            Mezclar (f, f1, f2, num_subf);
        until num_subf = 1;
    end;
  
  
    function EscogeCriterio: integer;
    {
        Objetivo: Devuelve el numero del campo de un registro del tipo
                    tRegistroHistorico por el cual se realizara la ordenacion
                    posterior, empezando en el 1 para el campo
                    PalabraPorDescubrir y 4 para el campo FechaJugada.
                    La opcion 0 retorna al menu principal del programa.
    }
    var respuesta: char value 'a';
    begin
        while respuesta = 'a' do begin
            LimpiarPantalla;
            writeln;
            writeln;
            CentrarTexto ('Consultar Historico de Partidas');
            writeln;
            writeln ('Criterios de ordenacion:');
            writeln;
            writeln ('1. Palabra a descubrir, en orden alfabetico');
            writeln ('2. Nombre del jugador, en orden alfabetico');
            writeln ('3. Intentos, de menor a mayor');
            writeln ('4. Fecha, de mas antiguo a mas reciente');
            writeln ('0. Volver al menu principal');
            writeln;
            write ('Opcion (0-4): ');
            readln (respuesta);
            writeln;
            case respuesta of
                '1': EscogeCriterio := 1;
                '2': EscogeCriterio := 2;
                '3': EscogeCriterio := 3;
                '4': EscogeCriterio := 4;
                '0': EscogeCriterio := 0;
                otherwise begin
                    write ('Opcion no valida. Pulse INTRO.');
                    readln;
                    respuesta := 'a';
                end;
            end;
            writeln;
        end;
    end;  
    
    procedure CopiarArchivoTemporal (var f1: tFHistorico; var f2: tArchivo);
    {
        Objetivo:   Copia el fichero f1 a un fichero f2 para trabajar
                    comodamente con archivos temporales durante la ordenacion.
        PreCD:      f1 esta enlazado y es accesible
    }
    begin
        reset (f1);
        rewrite (f2);
        repeat
            f2^:= f1^;
            get (f1);
            put (f2);
        until eof (f1);
    end;

    procedure MostrarFicheroOrdenado (var f: tArchivo);
    {
        Objetivo:   Muestra el contenido de un archivo binario.
    }
    var r: tRegistroHistorico; fin, i: integer; cAux: string (80);
    begin
        reset (f);
        if empty (f)
        then writeln ('El historico esta vacio.')
        else begin
            fin := lastposition (f);
            writeln ('Palabra       Nombre        Intentos       Fecha');
            for i := 0 to fin do begin
                seekread (f, i);
                r := f^;
                writestr (cAux, r.PalabraPorDescubrir, ' - ', r.NombreJugador);
                if r.NumeroIntentos = 0
                then writestr (cAux, cAux, ' - rendido')
                else writestr (cAux, cAux, ' - ', r.NumeroIntentos:0);
                writestr (cAux, cAux, ' - ', r.FechaJugada);
                writeln (cAux);
            end;
        end;
    end;

begin
    if ExisteFHistorico (F_HISTORICO) and_then LigaFHistorico (f_his, F_HISTORICO)
    then begin
        criterio := EscogeCriterio;
        if criterio <> 0
        then begin
            rewrite (f);
            CopiarArchivoTemporal (f_his, f);
            Ordenar (f);
            MostrarFicheroOrdenado (f);
            writeln;
            write ('Se volvera al menu principal. Pulse INTRO.');
            readln;
        end;
    end
    else begin
        if MostrarError ('Imposible abrir el fichero.')
        then begin
            write ('Se volvera al menu principal. Pulse INTRO.');
            readln;
        end
        else begin
            writeln ('El programa se detendra a continuacion.');
            halt;
        end;
    end;
end;

procedure Listado1;
{
    Objetivo:   Muestra por pantalla las palabras de una determinada longitud
                y un determinado idioma elegidos por el usuario
}
var i, j: integer; f: tFTexto; accesible: boolean;

    procedure MuestraPalabras (var f: tFTexto; longitud: integer);
    {
        Objetivo:   Del fichero f lee las palabras de longitud i y las envia a
                    la salida estandar.
        PreCD:      f existe y es accesible
    }
    var linea: string (17); i: integer;
    begin
        reset (f);
        i := 0;
        while not eof (f) do begin
            readln (f, linea);
            case longitud of
                1: writeln (substr (linea,  1, 4));
                2: writeln (substr (linea,  6, 5));
                3: writeln (substr (linea, 12, 6));
            end;
            i := i + 1;
            if (i mod 20 = 0) and (i < 100)
            then begin
                writeln;
                write ('Pulse INTRO para continuar...');
                readln;
                writeln;
            end;
        end;
        writeln;
        write ('Pulse INTRO para volver al menu principal.');
        readln;
    end;

begin
    i := IdiomaFichero;
    j := LongitudPalabra;
    case i of
        1:  if ExisteFTexto (F_CASTELAN) and_then LigaFTexto (f, F_CASTELAN)
            then begin
                MuestraPalabras (f, j);
                accesible := true;
            end
            else accesible := false;
        2:  if ExisteFTexto (F_GALEGO) and_then LigaFTexto (f, F_GALEGO)
            then begin
                MuestraPalabras (f, j);
                accesible := true;
            end
            else accesible := false;
        3:  if ExisteFTexto (F_INGLES) and_then LigaFTexto (f, F_INGLES)
            then begin
                MuestraPalabras (f, j);
                accesible := true;
            end
            else accesible := false;
    end;
    if not accesible
    then begin
        if MostrarError ('No se puede acceder al fichero.')
        then begin
            write ('Se volvera al menu principal. Pulse INTRO.');
            readln;
        end
        else begin
            writeln ('El programa se detendra a continuacion.');
            halt;
        end;
    end;
end;

procedure Listado2;
{
    Objetivo:   Muestra por pantalla 2 palabras por linea de una determinada
                longitud y un determinado idioma elegidos por el usuario
}
var i: integer; f: tFTexto; accesible: boolean;

    procedure MuestraDosPalabras (var f: tFTexto);
    {
        Objetivo:   Del fichero f con nombre n, lee las palabras y las vuelca a
                    la salida estandar de 2 en 2 hasta llenar la pantalla y
                    espera a que el usuario ordene continuar
        PreCD:      f existe y es accesible
    }
    var cAux: string (21); p1,p2,p3: tPalabra; pon2: boolean; i: integer;
    begin
        reset (f);
        pon2 := true;
        i := 0;
        while not eof (f) do begin
            readln (f, cAux);
            p1 := substr (cAux, 1, 4);
            p2 := substr (cAux, (5 + length (TABULACION)), 5);
            p3 := substr (cAux, (10 + (2*length (TABULACION))), 6);
            if pon2
            then begin
                writeln (p1, TABULACION, p2);
                write (p3, TABULACION);
                pon2 := false;
            end
            else begin
                writeln (p1);
                writeln (p2, TABULACION, p3);
                pon2 := true;
            end;
            i := i + 2;
            if i = 26
            then begin
                writeln;
                writeln;
                write ('Pulse INTRO para continuar...');
                readln;
                writeln;
                pon2 := true;
                i := 0;
            end;
        end;
        writeln;
        writeln;
        write ('Pulse INTRO para volver al menu principal.');
        readln;
    end;

begin
    i := IdiomaFichero;
    case i of
        1:  if ExisteFTexto (F_CASTELAN) and_then LigaFTexto (f, F_CASTELAN)
            then begin
                MuestraDosPalabras (f);
                accesible := true;
            end
            else accesible := false;
        2:  if ExisteFTexto (F_GALEGO) and_then LigaFTexto (f, F_GALEGO)
            then begin
                MuestraDosPalabras (f);
                accesible := true;
            end
            else accesible := false;
        3:  if ExisteFTexto (F_INGLES) and_then LigaFTexto (f, F_INGLES)
            then begin
                MuestraDosPalabras (f);
                accesible := true;
            end
            else accesible := false;
    end;
    if not accesible
    then begin
        if MostrarError ('No se puede acceder al fichero.')
        then begin
            write ('Se volvera al menu principal. Pulse INTRO.');
            readln;
        end
        else begin
            writeln ('El programa se detendra a continuacion.');
            halt;
        end;
    end;
end;

procedure OrdenarTexto;
{
    Objetivo:   Aglutina las operaciones de ordenación de un fichero de texto
                bajo un único procedimiento mediante un algoritmo de burbuja,
                por ser pocos elementos.
}
type tVector = array [1..300] of tPalabra value [otherwise ''];
var f: tFTexto; vector: tVector; i: integer; accesible: boolean;

    procedure RellenarVector (var f: tFTexto; var vector: tVector);
    {
        Objetivo:   Lee linea a linea el fichero de texto, extrae las palabras
                    que contenga la linea y las almacena en el vector tVector.
        PreCD:      f existe y es accesible
        PreCD:      El vector solo contiene cadenas vacias
    }
    var cAux: string (21); p: tPalabra; i: integer;
    begin
        i := 1;
        reset (f);
        while (not eof (f)) and (i < 300) do begin
            readln (f, cAux);
            p := substr (cAux, 1, 4);
            vector[i] := p;
            p := substr (cAux, (5 + length (TABULACION)), 5);
            vector[i+1] := p;
            p := substr (cAux, (10 + (2*length (TABULACION))), 6);
            vector[i+2] := p;
            i := i + 3;
        end;
    end;

    procedure OrdenarVector (var vector: tVector);
    {
        Objetivo:   Implementa las comparaciones del algoritmo de burbuja para
                    ordenar los elementos del array.
        PosCD:      Los elementos del vector quedan ordenados alfabeticamente.
    }
    var i,j: integer; temp: tPalabra;
    begin
        for i := 1 to 300 do begin
            for j := 1 to 300 do begin
                if vector[i] < vector[j]
                then begin
                    temp := vector [j];
                    vector[j] := vector[i];
                    vector[i] := temp;
                end;
            end;
        end;
    end;

    procedure MostrarVector (var vector: tVector);
    {
        Objetivo:   Recorre el vector volcando en la salida estandar todos sus
                    elementos, linea a linea. Al llenar la pantalla, se detiene
                    mientras el usuario no ordena continuar.
    }
    var i: integer;
    begin
        for i := 1 to 300 do begin
            writeln (vector[i]);
            if (i mod 20 = 0) and (i < 300)
            then begin
                writeln;
                write ('Pulse INTRO para continuar...');
                readln;
                writeln;
            end;
        end;
        writeln;
        write ('Pulse INTRO para volver al menu principal');
        readln;
        writeln;
    end;

    procedure OrdenarPalabras (var f: tFTexto; var vector: tVector);
    begin
        RellenarVector (f, vector);
        OrdenarVector (vector);
        MostrarVector (vector);
    end;
  
begin
    i := IdiomaFichero;
    case i of
        1:  if ExisteFTexto (F_CASTELAN) and_then LigaFTexto (f, F_CASTELAN)
            then begin
                OrdenarPalabras (f, vector);
                accesible := true;
            end
            else accesible := false;
        2:  if ExisteFTexto (F_GALEGO) and_then LigaFTexto (f, F_GALEGO)
            then begin
                OrdenarPalabras (f, vector);
                accesible := true;
            end
            else accesible := false;
        3:  if ExisteFTexto (F_INGLES) and_then LigaFTexto (f, F_INGLES)
            then begin
                OrdenarPalabras (f, vector);
                accesible := true;
            end
            else accesible := false;
    end;
    if not accesible
    then begin
        if MostrarError ('No se puede acceder al fichero.')
        then begin
        write ('Se volvera al menu principal. Pulse INTRO.');
        readln;
    end
    else begin
        writeln ('El programa se detendra a continuacion.');
        halt;
        end;
    end;
end;


end.