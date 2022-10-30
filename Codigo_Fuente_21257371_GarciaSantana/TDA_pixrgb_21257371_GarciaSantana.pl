:- module(tdapixrgb,[pixrgb/7,getX_r/2,getY_r/2,getColor_r/2,getD_r/2]).

% ############################################################################## %

% TDA pixrgb

% ############################################################################## %
/*
- Predicados:

Constructor:
pixrgb(X, Y, Red, Blue, Green, Profundidad, Pixel).

Selectores:
getX_r(P,X).
getY_r(P,Y).
getColor_r(P,C).
getD_r(P,D).
*/

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% CONSTRUCTOR:

pixrgb(X, Y, Red, Green, Blue, Profundidad, [X,Y,[Red,Green,Blue],Profundidad]):-
    % Dominio:
    % X: entero que representa la coordenada X del pixel
    % Y: entero que representa la coordenada Y del pixel
    % Red: canal rojo de un pixrgb-d
    % Green: canal verde de un pixrgb-d
    % Blue: canal azul de un pixrgb-d
    % Profundidad: profundidad de un pixel
    % Pixel pixrgb (construido en formato lista)
    % Goals: pixrgb (lista), construir un pixel tipo pixrgb-d
    % Aridad: 7
    % Tipo de predicado: regla
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
    integer(Profundidad),!.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% SELECTORES:
getX_r(P,X):- % Selector de coordenada X del pixel
    % Dominio: pixel (pixrgb), X (coordenada X a obtener del pixel)
    % Goals: getX_r, obtener coordenada X del pixel tipo pixrgb (entero)
    % Aridad: 2
    % Tipo de predicado: regla
    pixrgb(X,_,_,_,_,_,P),!.

getY_r(P,Y):- % Selector de coordenada Y del pixel
    % Dominio: pixel (pixrgb), Y (coordenada Y a obtener del pixel)
    % Goals: getY_r, obtener coordenada Y del pixel tipo pixrgb (entero)
    % Aridad: 2
    % Tipo de predicado: regla

    pixrgb(_,Y,_,_,_,_,P),!.

getColor_r(P,[R,G,B]):- % Selector de color del pixel
    % Dominio: pixel (pixrgb), Colores (a obtener del pixel en formato lista)
    % Goals: getColor_r, obtener coordenada colores RGB del pixel tipo pixrgb
    %        en formato lista [R,G,B] (lista de enteros)
    % Aridad: 2
    % Tipo de predicado: regla
    pixrgb(_,_,R,G,B,_,P),!.

getD_r(P,D):- % Selector de profundidad del pixel
   % Dominio: pixel (pixrgb), Colores (a obtener del pixel en formato lista)
   % Goals: getD_r, obtener profundidad (entero) del pixel tipo pixrgb
   % Aridad: 2
   % Tipo de predicado: regla
   pixrgb(_,_,_,_,_,D,P),!.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %





