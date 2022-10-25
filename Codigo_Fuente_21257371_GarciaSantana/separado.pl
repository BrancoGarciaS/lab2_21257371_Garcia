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

% ############################################################################## %
% TDA pixbit
% ############################################################################## %
/*
- Predicados:

Constructor:
pixbit(X, Y, Bit, Profundidad, Pixel).

Selectores:
getX(P,X).
getY(P,Y).
getColor(P,C).
getD(P,D).
*/

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% CONSTRUCTOR:
% Constructor de pixbit:
pixbit(X, Y, Bit, Profundidad, [X,Y,Bit,Profundidad]):-
    % Dominio: X (coordenada X del pixel), Y (coordenada Y del pixel),
    %		  Bit (Color Bit del pixel), Profundidad, Pixel en formato lista
    integer(X),
    integer(Y),
    integer(Bit),
    Bit = 1; Bit = 0,
    integer(Profundidad).

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% SELECTORES:

getX(P,X):- % Selector de coordenada X del pixel
    % Dominio: pixel (pixbit), X (coordenada X a obtener del pixel)
    pixbit(X,_,_,_,P).

getY(P,Y):- % Selector de coordenada Y del pixel
    % Dominio: pixel (pixbit), Y (coordenada Y a obtener del pixel)
    pixbit(_,Y,_,_,P).

getColor(P,C):- % Selector de color del pixel
    % Dominio: pixel (pixbit), Color (a obtener del pixel)
    pixbit(_,_,C,_,P).

getD(P,D):- % Selector de profundidad del pixel
   pixbit(_,_,_,D,P).

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %


% ############################################################################## %
% TDA pixhex
% ############################################################################## %
/*
- Predicados:

Constructor:
pixhex(X, Y, Color, Profundidad, Pixel).

Selectores:
getX(P,X).
getY(P,Y).
getColor(P,C).
getD(P,D).
*/

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% CONSTRUCTOR:
% Constructor de pixhex:
pixhex(X, Y, Color, Profundidad, [X,Y,Color,Profundidad]):-
    % Dominio: X (coordenada X del pixel), Y (coordenada Y del pixel),
    %		  Color (Color string del pixel), Profundidad,
    %		  Pixhex en formato lista
    integer(X),
    integer(Y),
    string(Color),
    integer(Profundidad).

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% SELECTORES:

getX(P,X):- % Selector de coordenada X del pixel
    % Dominio: pixel (pixhex), X (coordenada X a obtener del pixel)
    pixhex(X,_,_,_,P).

getY(P,Y):- % Selector de coordenada Y del pixel
    % Dominio: pixel (pixhex), Y (coordenada Y a obtener del pixel)
    pixhex(_,Y,_,_,P).

getColor(P,C):- % Selector de color del pixel
    % Dominio: pixel (pixhex), Color (a obtener del pixel)
    pixhex(_,_,C,_,P).

getD(P,D):- % Selector de profundidad del pixel
   pixhex(_,_,_,D,P).

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %

% ############################################################################## %
% TDA pixrgb
% ############################################################################## %
/*
- Predicados:

Constructor:
pixrgb(X, Y, Red, Blue, Green, Profundidad, Pixel).

Selectores:
getX(P,X).
getY(P,Y).
getColor(P,C).
getD(P,D).
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

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% SELECTORES:
getX(P,X):- % Selector de coordenada X del pixel
    % Dominio: pixel (pixrgb), X (coordenada X a obtener del pixel)
    pixrgb(X,_,_,_,_,_,P).

getY(P,Y):- % Selector de coordenada Y del pixel
    % Dominio: pixel (pixrgb), Y (coordenada Y a obtener del pixel)
    pixrgb(_,Y,_,_,_,_,P).

getColor(P,[R,G,B]):- % Selector de color del pixel
    % Dominio: pixel (pixrgb), Colores (a obtener del pixel en formato lista)
    pixrgb(_,_,R,G,B,_,P).

getD(P,D):- % Selector de profundidad del pixel
   pixrgb(_,_,_,_,_,D,P).

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %









































