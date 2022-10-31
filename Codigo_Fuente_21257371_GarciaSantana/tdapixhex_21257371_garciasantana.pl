:- module(tda_pixhex_21257371_GarciaSantana,[pixhex/5,getX_h/2,getY_h/2,getColor_h/2,getD_h/2]).
% ##############################################################################

% TDA pixhex

% ############################################################################## %
/*

- Predicados:

Constructor:
pixhex(X, Y, Color, Profundidad, Pixel).

Selectores:
getX_h(P,X).
getY_h(P,Y).
getColor_h(P,C).
getD_h(P,D).

*/

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% CONSTRUCTOR:
% Constructor de pixhex:
pixhex(X, Y, Color, Profundidad, [X,Y,Color,Profundidad]):-
    % Dominio: X (entero-coordenadaX del pixel), Y (entero-coordenadaY del pixel),
    %		  Color (Color string del pixel), Profundidad (entero),
    %		  Pixhex en formato lista
    % Goals: pixhex (lista), construir un pixel tipo pixhex-d
    % Aridad: 5
    % Tipo de predicado: regla
    integer(X),
    integer(Y),
    string(Color),
    integer(Profundidad),!.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% SELECTORES:

getX_h(P,X):- % Selector de coordenada X del pixel
    % Dominio: pixel (pixhex), X (entero-coordenada X a obtener del pixel)
    % Goals: getX_h, obtener coordenada X del pixel tipo pixhex
    % Aridad: 2
    % Tipo de predicado: regla
    pixhex(X,_,_,_,P),!.

getY_h(P,Y):- % Selector de coordenada Y del pixel
    % Dominio: pixel (pixhex), Y (entero-coordenada Y a obtener del pixel)
    % Goals: getY_h, obtener coordenada Y del pixel tipo pixhex
    % Aridad: 2
    % Tipo de predicado: regla
    pixhex(_,Y,_,_,P),!.

getColor_h(P,C):- % Selector de color del pixel
    % Dominio: pixel (pixhex), Color (string a obtener del pixel)
    % Goals: getColor_h, obtener color hexadecimal del pixel tipo pixhex
    % Aridad: 2
    % Tipo de predicado: regla
    pixhex(_,_,C,_,P),!.

getD_h(P,D):- % Selector de profundidad del pixel
   % Dominio: pixel (pixhex), Profundidad (entero - a obtener del pixel)
   % Goals: getD_h, obtener profundidad del pixel tipo pixhex
   % Aridad: 2
   % Tipo de predicado: regla
   pixhex(_,_,_,D,P),!.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %














