:- module(tdapixbit_21257371_garciasantana,[pixbit/5,getX_b/2,getY_b/2,
                                             getColor_b/2,getD_b/2]).

% ############################################################################## %

% TDA pixbit

% Dominio: X: coordenada X del pixel(entero), Y : coordenada Y del pixel(entero),
%          Bit: color bit del pixbit (entero), D: profundidad del
%          pixel (entero), P: pixel pixbit (list pixbit).

% Predicados: pixbit(X, Y, Bit, D, P). getX_b(P, X). getY_b(P, Y).
%             getColor_b(P, Bit). getD_b(P, D).

% Metas: secundarias -> pixbit(X, Y, Bit, D, P), getX_b(P,X), getY_b(P,Y),
%                       getColor_b(P,Bit), getD_b(P,D). % reglas
%                       (ya que es constructor y selectores nivel
%                       general, que se involucran con los predicados
%                       del archivo de requerimientos).

% ############################################################################## %
/*

- Predicados:

Constructor:
pixbit(X, Y, Bit, D, P).

Selectores:
getX_b(P,X).
getY_b(P,Y).
getColor_b(P,Bit).
getD_b(P,D).

*/

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %

% CONSTRUCTOR:
% Constructor de pixbit:
pixbit(X, Y, Bit, Profundidad, [X,Y,Bit,Profundidad]):-
    % Dominio: X (coordenada X del pixel), Y (coordenada Y del pixel),
    %		  Bit (Color Bit del pixel), Profundidad, Pixel en formato lista
    % Descripción: predicado que permite crear una representación de pixel pixbit
    % Goals: pixbit (lista), construir un pixel tipo pixbit-d
    % Aridad: 5
    % Tipo de predicado: regla
    integer(X),
    integer(Y),
    integer(Bit),
    Bit = 1, % Caso donde el bit es 1
    integer(Profundidad), !.

pixbit(X, Y, Bit, Profundidad, [X,Y,Bit,Profundidad]):-
    % Dominio: X (coordenada X del pixel), Y (coordenada Y del pixel),
    %		  Bit (Color Bit del pixel), Profundidad, Pixel en formato lista
    % Goals: pixbit (lista), construir un pixel tipo pixbit-d
    % Aridad: 5
    % Tipo de predicado: regla
    integer(X),
    integer(Y),
    integer(Bit),
    Bit = 0, % Caso donde el bit es 0
    integer(Profundidad), !.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% SELECTORES:

getX_b(P,X):- % Selector de coordenada X del pixel
    % Dominio: pixel (pixbit), X (coordenada X a obtener del pixel)
    % Descripción: permite obtener la coordenada X del pixbit
    % Goals: getX_b, obtener coordenada X del pixel tipo pixbit
    % Aridad: 2
    % Tipo de predicado: regla
    pixbit(X,_,_,_,P).

getY_b(P,Y):- % Selector de coordenada Y del pixel
    % Dominio: pixel (pixbit), Y (coordenada Y a obtener del pixel) entero
    % Descripción: permite obtener la coordenada Y del pixbit
    % Goals: getY_b, obtener coordenada Y del pixel tipo pixbit
    % Aridad: 2
    % Tipo de predicado: regla
    pixbit(_,Y,_,_,P).

getColor_b(P,C):- % Selector de color del pixel
    % Dominio: pixel (pixbit), Color (a obtener del pixel) entero
    % Descripción: permite obtener el color del pixbit
    % Goals: getColor_b, obtener color bit del pixel tipo pixbit
    % Aridad: 2
    % Tipo de predicado: regla
    pixbit(_,_,C,_,P).

getD_b(P,D):- % Selector de profundidad del pixel
    % Dominio: pixel (pixbit), Profundidad (a obtener del pixel) entero
    % Descripción: permite obtener la profundidad del pixbit
    % Goals: getD_b, obtener profundidad del pixel tipo pixbit
    % Aridad: 2
    % Tipo de predicado: regla
    pixbit(_,_,_,D,P).

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %















