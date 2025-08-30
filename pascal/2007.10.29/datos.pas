program datos (input, output);
{Autor      Emilio Devesa
 Archivo    datos.pas
 Espec      Mostrar datos del alumno alineados y centrados
 Fecha      29/10/2007 (fecha de propuesta)
 Entrega    29/10/2007 (fecha límite de entrega)
 Notas      Compilar con --extended-pascal
}

const
    desplaz = 10;

var
    nombre: string(15);
    apellido: string(20);
    ano: integer;
    edad: integer;
    sexo: string(5);
    domicilio: string(50); 
 
begin
     
    write ('Nombre: ');
    readln ( nombre );
     
    write ('Apellidos: ');
    readln ( apellido );
     
    write ('Edad: ');
    readln ( edad );
     
    write ('Varon o Mujer: ');
    readln ( sexo );
     
    write ('Curso: ');
    readln ( ano );
     
    write ('domicilio: ');
    readln ( domicilio );

    writeln ('Pulse ENTER');
    readln;
     
    writeln ('Datos del alumno:');
    writeln;
    writeln ('':desplaz, 'Nombre:   ', nombre: 50);
    writeln ('':desplaz, 'Apellidos:', apellido: 50); 
    writeln ('':desplaz, 'Edad:     ', edad: 50);
    writeln ('':desplaz, 'Sexo:     ', sexo: 50);
    writeln ('':desplaz, 'Domicilio:', domicilio: 50);
    writeln ('':desplaz, 'Curso:    ', ano: 50); 
    readln;
 
end. 
