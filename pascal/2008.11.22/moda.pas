module moda;    {archivo: moda.pas}

export  {sección de exportación}
    i1 = (VerOculto, PorOculto, PonOculto); {la interfaz i1}
    i2 = (MIL, Positivo);
    i3 = (MIL, Positivo, VerOculto, PorOculto, PonOculto);

import  {sección de importación (viene después de exportación)}
    standardoutput; {para VerOculto}

const MIL = 1000;   {sección de constantes}

type Positivo = 1..MAXINT value 1;  {sección de tipos}

procedure VerOculto;    {declaración de procedimientos y funciones}
procedure PonOculto(o: positivo);
function PorOculto(n: integer):integer;

end;    {final de la interfaz del módulo}

{principio de la implementación}
var oculto: positivo;

procedure PonOculto;
begin
    oculto := o;
end;

procedure VerOculto;    {aquí, sin parámetros}
begin
    write(oculto:0);
end;

function PorOculto; {aquí, sin parámetros}
begin
    PorOculto := oculto * n;
end;

to begin do begin   {lo que se hace antes de empezar}
    writeln('Inicio de ''moda''');
    oculto := 1;
end;

to end do   {lo que se hace antes de descargar el módulo}
    write ('Fin del ''moda''');

end.    {el punto termina el módulo}