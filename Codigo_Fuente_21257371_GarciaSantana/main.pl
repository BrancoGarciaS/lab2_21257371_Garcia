% X: entero que representa la coordenada X del pixel
% Y: entero que representa la coordenada Y del pixel
% Bit: color bit de un pixbit-d
% Color: color string de un pixhex-d
% Red: canal rojo de un pixrgb-d
% Green: canal verde de un pixrgb-d
% Blue: canal azul de un pixrgb-d
% Profundidad: profundidad de un pixel
/*
 Predicados:
 pixbit-d(X,Y,Bit,Profundidad, [X,Y,Bit,Profundidad])

*/

pixbit-d(X, Y, Bit, Profundidad, [X,Y,Bit,Profundidad]):-
    integer(X),
    integer(Y),
    integer(Bit),
    Bit = 1; Bit = 0,
    integer(Profundidad).

pixhex-d(X, Y, Color, Profundidad, [X,Y,Color,Profundidad]):-
    integer(X),
    integer(Y),
    string(Color),
    integer(Profundidad).

pixrgb-d(X, Y, Red, Green, Blue, Profundidad, [X,Y,Red,Green,Blue,Profundidad]):-
    integer(X),
    integer(Y),
    integer(Red),
    Red >= 0,
    Red =< 255,
    integer(Green),
    Green >= 0,
    Green =< 255,
    integer(Blue),
    Blue >= 0,
    Blue =< 255,
    integer(Profundidad).

image(Ancho, Alto, [P|C], [Ancho, Alto, [P|C]]):-
    integer(Ancho),
    integer(Alto).

%GetPix1(_,_,Pixel, Pix1):-
getPixeles(I, Pixeles):-
    image(_,_,Pixeles,I).

imageIsBitmap(I):-
    image(_,_,[Pix1|_], I),
    pixbit-d(_,_,_,_,Pix1).

imageIsPixmap(I):-
    image(_,_,[Pix1|_], I),
    pixrgb-d(_,_,_,_,_,_,Pix1).

imageIsHexmap(I):-
    image(_,_,[Pix1|_],I),
    pixhex-d(_,_,_,_,Pix1).
