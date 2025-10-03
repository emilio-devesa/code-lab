module highscores;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    highscores.pas
    Provides procedures to print highscores with different sorting criteria
}


export  highscores = (
        SortByWord,
        SortByPlayer,
        SortByAttempts,
        SortByDate
);

import  StandardInput;
        StandardOutput;
        types qualified;
        utils qualified;
        files qualified;

procedure SortByWord;
procedure SortByPlayer;
procedure SortByAttempts;
procedure SortByDate;


end;


procedure Sort (criteria: integer);
{
    Objetivo:   Aglutina las operaciones de ordenación del fichero historico
                bajo un único procedimiento
    PosCD:      El fichero f contiene los datos del historico ya ordenados
}
type tArchivo = file [0..MAXINT] of types.tGameRecord;
var f_his: files.tBinFile; f: tArchivo;

    function EsCampoMenor (r1, r2: types.tGameRecord): boolean;
    begin
        case criteria of
            1: EsCampoMenor := r1.Word < r2.Word;
            2: EsCampoMenor := r1.Player < r2.Player;
            3: EsCampoMenor := r1.Attemps < r2.Attemps;
            4: EsCampoMenor := LE(date(r1.DateTime), date(r2.DateTime));
            {begin
                fecha1 := utils.ConvertirFechaEnEntero (r1.FechaJugada);
                fecha2 := utils.ConvertirFechaEnEntero (r2.FechaJugada);
                EsCampoMenor := fecha1 < fecha2;
            end;}
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
  
  
  
    
    procedure CopiarArchivoTemporal (var f1: files.tBinFile; var f2: tArchivo);
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
    var r: types.tGameRecord; fin, i: integer; cAux: string (80);
    begin
        reset (f);
        if empty (f)
        then writeln ('El historico esta vacio.')
        else begin
            fin := lastposition (f);
            writeln;
            writeln ('Word', types.TAB, types.TAB, 'Player', types.TAB, types.TAB, 'Attemps', types.TAB, types.TAB, 'Date');
            for i := 0 to fin do begin
                seekread (f, i);
                r := f^;
                writestr (cAux, r.Word,  types.TAB, types.TAB, r.Player);
                if r.Attemps = 0
                then writestr (cAux, cAux, 'rendido')
                else writestr (cAux, cAux,  types.TAB, types.TAB, r.Attemps:0);
                writestr (cAux, cAux,  types.TAB, date(r.DateTime));
                writeln (cAux);
            end;
        end;
    end;

begin
    if files.BinFileExists (f_his, files.F_HIGHSCORES) and_then files.BinFileIsBound (f_his, files.F_HIGHSCORES)
    then begin
        rewrite (f);
        CopiarArchivoTemporal (f_his, f);
        Ordenar (f);
        MostrarFicheroOrdenado (f);
        writeln;
        write ('Returning to Main Menu. Press ENTER.');
        readln;
    end
    else begin
        if utils.PrintError ('Can not open the file.')
        then begin
            write ('Returning to Main Menu. Press ENTER');
            readln;
        end
        else begin
            writeln ('Execution aborted');
            halt;
        end;
    end;
end;


procedure SortByWord;
begin
    Sort(1);
end;

procedure SortByPlayer;
begin
    Sort(2);
end;

procedure SortByAttempts;
begin
    Sort(3);
end;

procedure SortByDate;
begin
    Sort(4);
end;


end.