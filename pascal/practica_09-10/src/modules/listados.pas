module listados;
{   Práctica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal)
    More info: README.md
    
    base.pas
    Provides common utilities and definitions for constants and types
}


export  listados = (
        PrintAllWords, 
        PrintTwoWordsInARow, 
        SortWords
);

import  StandardInput;
        StandardOutput;
        types qualified;
        utils qualified;
        files qualified;

procedure PrintAllWords;
procedure PrintTwoWordsInARow;
procedure SortWords;


end;


procedure PrintAllWords;
{
    Objetivo:   Muestra por pantalla las palabras de una determinada longitud
                y un determinado idioma elegidos por el usuario
}
var i, j: integer; f: files.tTextFile; accesible: boolean;

    procedure MuestraPalabras (var f: files.tTextFile; longitud: integer);
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
                write ('Press ENTER...');
                readln;
                writeln;
            end;
        end;
        writeln;
        write ('Press ENTER to return to Main Menu.');
        readln;
    end;

begin
    i := utils.ChooseLanguage;
    j := utils.ChooseLength;
    case i of
        1:  if files.TextFileExists (f, files.F_CASTILLAN) and_then files.TextFileIsBound (f, files.F_CASTILLAN)
            then begin
                MuestraPalabras (f, j);
                accesible := true;
            end
            else accesible := false;
        2:  if files.TextFileExists (f, files.F_GALICIAN) and_then files.TextFileIsBound (f, files.F_GALICIAN)
            then begin
                MuestraPalabras (f, j);
                accesible := true;
            end
            else accesible := false;
        3:  if files.TextFileExists (f, files.F_ENGLISH) and_then files.TextFileIsBound (f, files.F_ENGLISH)
            then begin
                MuestraPalabras (f, j);
                accesible := true;
            end
            else accesible := false;
    end;
    if not accesible
    then begin
        if utils.PrintError ('Can not open the file.')
        then begin
            write ('Returning to Main Menu. Press ENTER.');
            readln;
        end
        else begin
            writeln ('Execution aborted');
            halt;
        end;
    end;
end;

procedure PrintTwoWordsInARow;
{
    Objetivo:   Muestra por pantalla 2 palabras por linea de una determinada
                longitud y un determinado idioma elegidos por el usuario
}
var i: integer; f: files.tTextFile; accesible: boolean;

    procedure MuestraDosPalabras (var f: files.tTextFile);
    {
        Objetivo:   Del fichero f con nombre n, lee las palabras y las vuelca a
                    la salida estandar de 2 en 2 hasta llenar la pantalla y
                    espera a que el usuario ordene continuar
        PreCD:      f existe y es accesible
    }
    var cAux: string (21); p1,p2,p3: types.tPalabra; pon2: boolean; i: integer;
    begin
        reset (f);
        pon2 := true;
        i := 0;
        while not eof (f) do begin
            readln (f, cAux);
            p1 := substr (cAux, 1, 4);
            p2 := substr (cAux, (5 + length (types.TAB)), 5);
            p3 := substr (cAux, (10 + (2*length (types.TAB))), 6);
            if pon2
            then begin
                writeln (p1, types.TAB, p2);
                write (p3, types.TAB);
                pon2 := false;
            end
            else begin
                writeln (p1);
                writeln (p2, types.TAB, p3);
                pon2 := true;
            end;
            i := i + 2;
            if i = 26
            then begin
                writeln;
                writeln;
                write ('Press ENTER...');
                readln;
                writeln;
                pon2 := true;
                i := 0;
            end;
        end;
        writeln;
        writeln;
        write ('Press ENTER to return to main Menu.');
        readln;
    end;

begin
    i := utils.ChooseLanguage;
    case i of
        1:  if files.TextFileExists (f, files.F_CASTILLAN) and_then files.TextFileIsBound (f, files.F_CASTILLAN)
            then begin
                MuestraDosPalabras (f);
                accesible := true;
            end
            else accesible := false;
        2:  if files.TextFileExists (f, files.F_GALICIAN) and_then files.TextFileIsBound (f, files.F_GALICIAN)
            then begin
                MuestraDosPalabras (f);
                accesible := true;
            end
            else accesible := false;
        3:  if files.TextFileExists (f, files.F_ENGLISH) and_then files.TextFileIsBound (f, files.F_ENGLISH)
            then begin
                MuestraDosPalabras (f);
                accesible := true;
            end
            else accesible := false;
    end;
    if not accesible
    then begin
        if utils.PrintError ('Can not open the file.')
        then begin
            write ('Returning to Main Menu. Press ENTER.');
            readln;
        end
        else begin
            writeln ('Execution aborted');
            halt;
        end;
    end;
end;

procedure SortWords;
{
    Objetivo:   Aglutina las operaciones de ordenación de un fichero de texto
                bajo un único procedimiento mediante un algoritmo de burbuja,
                por ser pocos elementos.
}
type tVector = array [1..300] of types.tPalabra value [otherwise ''];
var f: files.tTextFile; vector: tVector; i: integer; accesible: boolean;

    procedure RellenarVector (var f: files.tTextFile; var vector: tVector);
    {
        Objetivo:   Lee linea a linea el fichero de texto, extrae las palabras
                    que contenga la linea y las almacena en el vector tVector.
        PreCD:      f existe y es accesible
        PreCD:      El vector solo contiene cadenas vacias
    }
    var cAux: string (21); p: types.tPalabra; i: integer;
    begin
        i := 1;
        reset (f);
        while (not eof (f)) and (i < 300) do begin
            readln (f, cAux);
            p := substr (cAux, 1, 4);
            vector[i] := p;
            p := substr (cAux, (5 + length (types.TAB)), 5);
            vector[i+1] := p;
            p := substr (cAux, (10 + (2*length (types.TAB))), 6);
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
    var i,j: integer; temp: types.tPalabra;
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
                write ('Press ENTER...');
                readln;
                writeln;
            end;
        end;
        writeln;
        write ('Press ENTER to return to Main Menu');
        readln;
        writeln;
    end;

    procedure OrdenarPalabras (var f: files.tTextFile; var vector: tVector);
    begin
        RellenarVector (f, vector);
        OrdenarVector (vector);
        MostrarVector (vector);
    end;
  
begin
    i := utils.ChooseLanguage;
    case i of
        1:  if files.TextFileExists (f, files.F_CASTILLAN) and_then files.TextFileIsBound (f, files.F_CASTILLAN)
            then begin
                OrdenarPalabras (f, vector);
                accesible := true;
            end
            else accesible := false;
        2:  if files.TextFileExists (f, files.F_GALICIAN) and_then files.TextFileIsBound (f, files.F_GALICIAN)
            then begin
                OrdenarPalabras (f, vector);
                accesible := true;
            end
            else accesible := false;
        3:  if files.TextFileExists (f, files.F_ENGLISH) and_then files.TextFileIsBound (f, files.F_ENGLISH)
            then begin
                OrdenarPalabras (f, vector);
                accesible := true;
            end
            else accesible := false;
    end;
    if not accesible
    then begin
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


end.