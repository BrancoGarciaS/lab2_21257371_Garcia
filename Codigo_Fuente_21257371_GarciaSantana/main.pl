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
% -------------------------------------------------------------------- %
% Constructores de pixeles:
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

% -------------------------------------------------------------------- %
% Selectores de imagen:

getPixeles(I, Pixeles):-
    image(_,_,Pixeles,I).

getAncho(I, Ancho):-
    image(Ancho,_,_,I).

getLargo(I, Largo):-
    image(_,Largo,_,I).

% -------------------------------------------------------------------- %
% Selectores de pixel:

getX(P,N):-
    pixbit-d(N,_,_,_,P);
    pixhex-d(N,_,_,_,P);
    pixrgb-d(N,_,_,_,_,_,P).

getY(P,N):-
    pixbit-d(_,N,_,_,P);
    pixhex-d(_,N,_,_,P);
    pixrgb-d(_,N,_,_,_,_,P).

getD(P,D):-
   pixbit-d(_,_,_,D,P);
   pixhex-d(_,_,_,D,P);
   pixrgb-d(_,_,_,D,P).

getColor(P,C):-
    pixbit-d(_,_,C,_,P);
    pixhex-d(_,_,C,_,P);
    pixrgb-d(_,_,C,_,P).

% -------------------------------------------------------------------- %

% Requerimiento 2:
image(Ancho, Alto, [Pixel1|Resto], [Ancho, Alto, [Pixel1|Resto]]):-
    integer(Ancho),
    integer(Alto).

% Requerimiento 3:

imageIsBitmap(I):-
    image(_,_,[Pix1|_], I),
    pixbit-d(_,_,_,_,Pix1).

% Requerimiento 4:

imageIsPixmap(I):-
    image(_,_,[Pix1|_], I),
    pixrgb-d(_,_,_,_,_,_,Pix1).

% Requerimiento 5:

imageIsHexmap(I):-
    image(_,_,[Pix1|_],I),
    pixhex-d(_,_,_,_,Pix1).

% Requerimiento 6:

% ------------------------------------------------------------------------------ %
% Requerimiento 7:
/*
Dominio:
I1: imagen a operar
I2: imagen volteada horizontalmente

Predicados:
imageFlipV(I1,I2).
invX([X,Y,C,D], Largo, [X,Yh,C,D]). Y: y volteado horizontalmente
invert_V(P,L,Pixs_V). P: pixs, L: largo, Pixs_V: pixs volteados horizontalmente

Metas: principales: imageFlipH
*/
imageFlipH(I1,I2):-
    getAncho(I1,A),
    getLargo(I1,L),
    getPixeles(I1,P),
    invert_H(P,A,Pixs_H),
    image(A,L,Pixs_H,I2).

% Clausula para invertir horizontalmente un pixel: (Y es horizontal)
invY([X,Y,C,D], Ancho, [X,Yh,C,D]):-
    % y_invertido = (ancho - 1) - y_pixel_a_invertir
    % Argumentos: Pixel (Entrada), Ancho imagen, Pixel volteado (Salida)
    Yh is Ancho - 1 - Y.

% Clausulas para invertir horizontalmente todos los pixeles:
invert_H([],_,[]). % caso base: si se recorren todos los pixeles,
% la lista de salida queda vacía
invert_H([Pix1|Rest], Largo, [InvertidoH|RestInv]):-
    % se invierte horizontalmente el pixel cabecera 'guardandose'
    % en la cabeza de la lista de pixeles invertidos
    invY(Pix1, Largo, InvertidoH),
    % se vuelve a realizar el mismo procedimiento con el resto
    % de pixeles, hasta llegar al hecho caso base.
    invert_H(Rest, Largo, RestInv).
% ------------------------------------------------------------------------------ %


























































