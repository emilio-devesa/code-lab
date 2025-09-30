program Main;
{   Practica 2009-2010
    Command Line program written in Pascal ISO 10206 (Extended Pascal).
    More info: README.md
}

import  StandardInput;
        StandardOutput;
        base qualified;

procedure EscribirCabecera;
{
    Objetivo:   Muestra el titulo del programa.
}
var asteriscos, titulo: string (80); i: integer;
begin
    titulo := 'PRACTICA PROGRAMACION: JUEGO << DESCUBRO PALABRAS >>';
    asteriscos := '';
    for i := 1 to length (titulo) do asteriscos := asteriscos + '*';
    base.CentrarTexto (asteriscos);
    base.CentrarTexto (titulo);
end;

procedure SubMenuJuego;
{
    Objetivo:   Muestra el submenu correspondiente al juego y lanza las
                operaciones pertinentes.
}
var opcion: char value 'a';
begin
    while opcion = 'a' do begin
        LimpiarPantalla;
        writeln;
        writeln;
        CentrarTexto ('Menu Jugar');
        writeln;
        writeln ('Seleccionar opcion: ');
        writeln;
        writeln ('1. Validar juego');
        writeln ('2. Jugar');
        writeln ('0. Volver al menu principal');
        writeln;
        write ('Opcion (0-2): ');
        readln (opcion);
        writeln;
        case opcion of
            '1': { Validar };
            '2': { Jugar };
            '0': ;
            otherwise begin
                write ('Opcion no valida. Pulse INTRO.');
                readln;
                opcion := 'a';
            end;
        end;
    end;
end;

procedure SubMenuVerPalabrasEnPantalla;
{
    Objetivo:   Muestra el submenu correspondiente a los listados de palabras
                y lanza las operaciones pertinentes.
}
var opcion: char value 'a';
begin
    while opcion = 'a' do begin
        LimpiarPantalla;
        writeln;
        writeln;
        CentrarTexto ('Menu Ver Palabras en Pantalla');
        writeln;
        writeln ('Seleccionar opcion: ');
        writeln;
        writeln ('1. Ver palabras de n letras de un fichero');
        writeln ('2. Ordenar palabras de un fichero');
        writeln ('3. Ver palabras de un fichero de 2 en 2');
        writeln ('0. Volver al menu principal');
        writeln;
        write ('Opcion (0-3): ');
        readln (opcion);
        writeln;
        case opcion of
            '1': { Listado 1 };
            '2': { OrdenarTexto };
            '3': { Listado 2};
            '0': ;
            otherwise begin
                write ('Opcion no valida. Pulse INTRO.');
                readln;
                opcion := 'a';
            end;
        end;
    end;
end;

procedure Menu;
{
    Objetivo:   Arranca el menu principal con las diferentes opciones del
                juego y de la presentacion de resultados.
}
var opcion: char value 'a';
begin
    while opcion <> '0' do begin
        LimpiarPantalla;
        EscribirCabecera;
        writeln;
        writeln;
        CentrarTexto ('Menu Principal');
        writeln;
        writeln ('Seleccionar opcion: ');
        writeln;
        writeln ('1) Jugar o Validar');
        writeln ('2) Consultar historico de partidas');
        writeln ('3) Ver palabras en pantalla');
        writeln ('0) Salir del programa');
        writeln;
        write ('Opcion (0-3): ');
        readln (opcion);
        writeln;
        case opcion of
            '1': SubMenuJuego;
            '2': { OrdenarHistorico };
            '3': SubMenuVerPalabrasEnPantalla;
            '0': ;
            otherwise begin
                write ('Opcion no valida. Pulse INTRO.');
                readln;
                opcion := 'a';
            end;
        end;
    end;
end;

begin
    Menu;
    base.LimpiarPantalla;
end.
