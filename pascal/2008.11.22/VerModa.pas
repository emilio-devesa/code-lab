program VerModa (input, output);

import
    i1;
    i2 qualified only (Positivo => tPositivo);
    {de i2 sólo se importa Positivo y lo renombra a tPositivo}

type tPositivo = 0..MAXINT value 0; {choca con el importado}

var n: tPositivo;

procedure VerTPositivo;
var k: i2.tPositivo;    {la cualificación evita el choque}
begin
    writeln('tPositivo n = ', n:0);
    writeln('i2.tPositivo k = ', k:0)
end;

begin
    writeln('Valor inicial de oculto: ', PorOculto(1):0);
    PonOculto (123);
    Writeln('Valor actual de oculto: ', PorOculto(1):0);
    writeln('5 * Oculto = ', PorOculto(5):0);
    VerTPositivo
end.