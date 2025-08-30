program alumnoFecha (input, output);
{Autor      Emilio Devesa
 Archivo    alumnoFecha.pas
 Objetivo   Este programa se hace para ver registros
 Espec      Lo que este programa debe hacer es recoger datos de alumnos y su fecha
            de nacimiento y luego mostrarlo en pantalla
 Fecha      3/12/2007
 Entrega    10/12/2007
 Notas      La compilación será en gpc en el lenguaje pascal ISO 10206
            con la directiva --extended-pascal
}

type
    tFecha = record
        dia: 1..31;
        mes: 1..12;
        anio: 1..2047;
    end;
    tAlumno = record
        nombre: string (30);
        nacidoEl: tFecha;
    end;
    tfAlumnos = file of tAlumno;

procedure LeeDatos (var a: tAlumno);
begin
    with a do begin
        write ('Nombre: ');
        readln (nombre);
        if nombre <> ''
        then with nacidoEl do begin
            write ('Dia: ');
            readln (dia);
            write ('Mes: ');
            readln (mes);
            write ('Año: ');
            readln (anio);
        end;
    end;
end;

procedure VerDatos (var fAlumnos: tfAlumnos);
begin
    reset(fAlumnos);
    writeln('NOMBRE': 30, 'DD': 3, '-', 'MM':2, '-', 'AA');
    while not eof(fAlumnos) do
        with fAlumnos^ do begin
            write(nombre: 30);
            with nacidoEl do begin
                write (nacidoEl.dia: 3, '-');
                writeln (nacidoEl.mes:2, '-', nacidoEl.anio:0);
            end;
            get(fAlumnos)
        end;
end;

procedure inicio;
var opc: char; fAlumnos: tfAlumnos; a: tAlumno;
begin
    rewrite (fAlumnos);
    repeat
        writeln ('1) Ingresar alumnos.');
        writeln ('2) Ver alumnos.');
        writeln ('0) Salir.');
        repeat
            write('Escoger opcion: ');
            readln(opc)
        until ('0' <= opc) and (opc <= '2');      
        case opc of
            '1': repeat
                LeeDatos(a);
                if a.nombre <> '' 
                then write(fAlumnos, a);
            until a.nombre = ''; 
            '2': VerDatos(fAlumnos);
            '0':; {sentencia nula}
        end;
    until opc = '0'
end;

begin
    inicio;
end.
