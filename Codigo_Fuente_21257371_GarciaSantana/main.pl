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
% ------------------------------------------------------------------------------ %
/*
Dominio:
I1: imagen a operar
I2: imagen volteada verticalmente

Predicados:
imageFlipV(I1,I2).
invX([X,Y,C,D], Largo, [Xv,Y,C,D]). Xv: x volteado verticalmente
invert_V(P,L,Pixs_V). P: pixs, L: largo, Pixs_V: pixs volteados verticalmente

Metas: Principales: imageFlipV
*/
imageFlipV(I1,I2):-
    getAncho(I1,A),
    getLargo(I1,L),
    getPixeles(I1,P),
    invert_V(P,L,Pixs_V),
    image(A,L,Pixs_V,I2).

% Clausula (Regla) para invertir verticalmente un pixel: (X es vertical)
invX([X,Y,C,D], Largo, [Xv,Y,C,D]):-
    % x_invertido = (largo - 1) - x_pixel_a_invertir
    Xv is Largo - 1 - X.

% Clausulas para invertir verticalmente todos los pixeles:
invert_V([],_,[]). % HECHO - caso base: si se recorren todos los pixeles,
% la lista de salida queda vacía
invert_V([Pix1|Rest], Largo, [InvertidoV|RestInv]):-
    % REGLA - para invertir verticalmente una lista de pixeles.
    % Se invierte verticalmente el pixel cabecera 'guardandose'
    % en la cabeza de la lista de pixeles invertidos
    invX(Pix1, Largo, InvertidoV),
    % se vuelve a realizar el mismo procedimiento con el resto
    % de pixeles, hasta llegar al hecho caso base.
    invert_V(Rest, Largo, RestInv).
% ------------------------------------------------------------------------------ %
/*
Dominio:
I1: imagen a operar
X1: primer parametro en X para recortar la imagen
Y1: primer parametro en Y para recortar la imagen
X2: segundo parametro en X para recortar la imagen
Y2: segundo parametro en Y para recortar la imagen
I2: imagen volteada verticalmente

X0: marcador de posicion en X para ajuste de coordenadas de pixeles no recortados
Y0: marcador de posicion en Y para ajuste de coordenadas de pixeles no recortados

Predicados:
imageCrop(I1,X1,Y1,X2,Y2,I2).
entrex1x2y1y2(Pixel,X1,X2,Y1,Y2).
recortarpixs(Pixs,X1,X2,Y1,Y2,X0,Y0,PixsCrop).

Metas: Principales: imageCrop
*/

% Clausula para recortar imagen: (REGLA)
imageCrop(I1,X1,Y1,X2,Y2,I2):-
    integer(X1),
    integer(Y1),
    integer(X2),
    integer(Y2),
    getPixeles(I1,Pixs),
    recortarpixs(Pixs,X1,X2,Y1,Y2,0,0,PixsCrop),
    NewA is Y2 - Y1  + 1, % nuevo Ancho
    NewL is X2 - X1 + 1, % nuevo Largo
    image(NewA,NewL,PixsCrop,I2).

% Clausula para ver si un pixel está entre el intervalo X e Y
% que no será recortado (REGLA):
entrex1x2y1y2(Pixel,X1,X2,Y1,Y2):-
    getX(Pixel,X),
    getY(Pixel,Y),
    X >= X1,
    X =< X2,
    Y >= Y1,
    Y =< Y2.

% Clausulas para recortar pixeles:
recortarpixs([],_,_,_,_,_,_,[]). % HECHO - Caso base: cuando se
% recorrieron todos los pixeles, recortando y dejandolos en base
% a si sus coordenadas están dentro del intervalo de recorte

recortarpixs([Pix1|Rest],X1,X2,Y1,Y2,X0,Y0,[[X0,Y0,C,D]|Rest2]):-
    % Caso donde el pixel está dentro del cuadrante a recortar:
    % se incluye en el conjunto de pixeles de salida
    entrex1x2y1y2(Pix1,X1,X2,Y1,Y2),
    % Obtengo la información del pixel a conservar: color y profundidad
    getColor(Pix1,C),
    getD(Pix1,D),
    % X0 e Y0 serán iteradores para ir moviendo las coordenadas
    % dentro del cuadrante de recorte y ajustarlas para el pixel
    % a conservar
    Limite is Y2 - Y1,
    % si el Y momentaneo alcanzó el límite de recorte,
    % se avanza X en 1, e Y se reinicia en 0
    Y0 = Limite,
    Xsgte is X0 + 1,
    recortarpixs(Rest,X1,X2,Y1,Y2,Xsgte,0,Rest2).

recortarpixs([Pix1|Rest],X1,X2,Y1,Y2,X0,Y0,[[X0,Y0,C,D]|Rest2]):-
    % Caso donde el pixel está dentro del cuadrante a recortar:
    % se incluye en el conjunto de pixeles de salida
    entrex1x2y1y2(Pix1,X1,X2,Y1,Y2),
    % Obtengo la información del pixel a conservar: color y profundidad
    getColor(Pix1,C),
    getD(Pix1,D),
    % X0 e Y0 serán iteradores para ir moviendo las coordenadas
    % dentro del cuadrante de recorte y ajustarlas para el pixel
    % a conservar
    Limite is Y2 - Y1,
    % si el Y momentaneo no ha alcanzado el límite de recorte,
    % solo se incrementa en 1
    Y0 \== Limite,
    Ysgte is Y0 + 1,
    recortarpixs(Rest,X1,X2,Y1,Y2,X0,Ysgte,Rest2).

recortarpixs([Pix1|Rest],X1,X2,Y1,Y2,X0,Y0,Rest2):-
    % si el pixel no está dentro del cuadrante de recorte
    % no se incluye en la lista de pixeles conservados
    not(entrex1x2y1y2(Pix1,X1,X2,Y1,Y2)),
    recortarpixs(Rest,X1,X2,Y1,Y2,X0,Y0,Rest2).

% ------------------------------------------------------------------------------ %

























































