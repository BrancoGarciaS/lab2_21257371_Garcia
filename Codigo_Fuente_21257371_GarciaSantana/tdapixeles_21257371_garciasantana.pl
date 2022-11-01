:- module(tdapixeles_21257371_garciasantana,[getX/2,getY/2,getColor/2,getD/2,pix1/2,
                      restPixs/2,getPixPorPosicion/5,pixs_estan_ordenados/3,
                      ordenarPixs/3,moverPixs/4]).
:- use_module(tdapixhex_21257371_garciasantana).
:- use_module(tdapixrgb_21257371_garciasantana).
:- use_module(tdapixbit_21257371_garciasantana).

% ############################################################################## %

% TDA pixeles y pixel general

% ############################################################################## %

% ############################################################################## %

% TDA pixel general (pixbit,pixhex,pixrgb)

% Selectores:

getX(Pixel,X):-
    % Dominio: pixel (de cualquier tipo: pixbit, pixhex, pixrgb), coordenada X
    %          del pixel (entero)
    % Goals: getX, obtener la coordenada en X de cualquiera de los pixeles
    % Aridad: 2
    % Tipo de predicado: regla
    getX_h(Pixel,X);
    getX_r(Pixel,X);
    getX_b(Pixel,X).

getY(Pixel,Y):-
    % Dominio: pixel (de cualquier tipo: pixbit, pixhex, pixrgb), coordenada Y
    %          del pixel (entero)
    % Goals: getY, obtener la coordenada en Y de cualquiera de los pixeles
    % Aridad: 2
    % Tipo de predicado: regla
    getY_h(Pixel,Y);
    getY_r(Pixel,Y);
    getY_b(Pixel,Y).

getColor(Pixel,Color):-
    % Dominio: pixel (de cualquier tipo: pixbit, pixhex, pixrgb), color del
    %          pixel (bit entero, string hexadecimal, lista rgb).
    % Goals: getColor, obtener el color de cualquiera de los pixeles
    % Aridad: 2
    % Tipo de predicado: regla
    getColor_h(Pixel,Color);
    getColor_r(Pixel,Color);
    getColor_b(Pixel,Color).

getD(Pixel,D):-
    % Dominio: pixel (de cualquier tipo: pixbit, pixhex, pixrgb), profundidad
    %          del pixel (entero)
    % Goals: getD, obtener la profundidad de cualquiera de los pixeles
    % Aridad: 2
    % Tipo de predicado: regla
    getD_h(Pixel,D);
    getD_r(Pixel,D);
    getD_b(Pixel,D), !.

% ############################################################################## %
%
% TDA Pixeles: lista compuesta de pixel (pixbit,pixhex,pixrgb)

/*

- Predicados:

Selectores:
pix1(Pixeles,Pix1).
restPixs(Pixeles,Pix1).
getPixPorPosicion(Pixeles,Pos_buscada,A,Pix_buscado,PixelesnoBuscados).

De pertenencia:
pixs_estan_ordenados(Pixeles,Pos_correspondiente,A).

*/

% ############################################################################## %
% Selectores de pixeles:

pix1([Pix1|_],Pix1). % Dominio: Lista de Pixeles, Cabeza de la lista (pixel 1)
                     % Goals: pix1 (lista), primer pixel de lista de pixeles
                     % Aridad: 2
                     % Tipo de predicado: hecho

restPixs([_|Resto],Resto). % Dominio: Lista de Pixeles, Resto de pixeles (cola)
                     % Goals: restPixs (lista), resto de pixeles de la lista
                     % Aridad: 2
                     % Tipo de predicado: hecho

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% - Clausulas para obtener un pixel por posici�n y los no coincidentes:
% Dominio: Pixeles, Posici�n buscada, A: Ancho imagen, Pixel buscado,
%          lista de pixeles no buscados
% Goals: getPixPorPosicion (listas), obtener el pixel buscado y adem�s
%        una lista de los no buscados
% Aridad: 5
% Tipo de predicado: regla

getPixPorPosicion(Pixeles,Pos_buscada,A,Pix_buscado,[Pix1|PixsNoBusc]):-
    % - Caso donde el pixel cabecera tiene posici�n distinta a la buscada
    % agregandose en la lista de pixeles no buscados.
    % Obtengo el primer pixel (Pix1) y el resto de pixeles (RestPixs)
    pix1(Pixeles, Pix1), restPixs(Pixeles, RestPixs),
    getX(Pix1,X), getY(Pix1,Y),
    % La posici�n correspondiente de un pixel viene dada por
    % el producto entre el ancho de la imagen y la coordenada
    % X, m�s la coordenada Y del pixel
    Pos_Pixel is A * X + Y,
    Pos_Pixel =\= Pos_buscada,
    getPixPorPosicion(RestPixs,Pos_buscada,A,Pix_buscado,PixsNoBusc).

getPixPorPosicion(Pixeles,Pos_buscada,A,Pix_buscado,RestPixs):-
    % - Caso donde el pixel cabecera tiene posici�n igual a la buscada.
    % En este caso se coloca el resto de pixeles en los pixeles no
    % buscados y se detiene la recursi�n.
    % Obtengo el primer pixel (Pix1) y el resto de pixeles (RestPixs)
    pix1(Pixeles, Pix_buscado), restPixs(Pixeles,RestPixs),
    getX(Pix_buscado,X), getY(Pix_buscado,Y),
    Pos_Pixel is A * X + Y,
    Pos_Pixel = Pos_buscada.

% ############################################################################## %

% Predicados de pertenencia:

% - Clausulas para ver si los pixeles est�n ordenados o no
% Dominio: Pixeles, Pos_Correspondiente (iterador de posiciones iniciado en 0),
%          A (ancho de la imagen)
% Goals: pixs_estan_ordenados (booleano), verificar si los pixeles de la
%        lista de pixeles, est� ordenado en terminos de sus coordenadas
% Aridad: 3

pixs_estan_ordenados([],_,_).
    % Caso base: comprobar que todos los pixeles est�n en orden
    % Tipo de predicado: regla

pixs_estan_ordenados(Pixeles,Pos_Correspondiente,A):-
    % Tipo de predicado: regla
    % Pos_correspondiente se ingresa como 0 y se va a ir incrementando en 1
    % La posici�n correspondiente (seg�n el orden establecido) de un pixel
    % viene dado por: ancho * x + y, en la lista de pixeles
    pix1(Pixeles,Pix1), restPixs(Pixeles,RestPixs),
    % Obtengo x e y del pixel 1:
    getX(Pix1,X), getY(Pix1,Y),
    Pos_Pixel is A * X + Y,
    % Si no se cumple la igualdad, se retorna false
    Pos_Pixel = Pos_Correspondiente,
    % Si se cumple se sigue incrementando el contador de posici�n
    % hasta recorrer todos los pixeles comprobando que est�n ordenados
    % o hasta encontrar un pixel desordenado que no cumpla la igualdad
    Pos_sgte is Pos_Correspondiente + 1,
    pixs_estan_ordenados(RestPixs,Pos_sgte,A).

% ############################################################################## %

% Predicados de pertenencia:
% - Clausulas para ver si los pixeles est�n ordenados o no
% Dominio: Pixeles, Pos_Correspondiente (iterador de posiciones iniciado en 0),
%          A (ancho de la imagen)
% Goals: pixs_estan_ordenados (booleano), verificar si los pixeles de la
%        lista de pixeles, est� ordenado en terminos de sus coordenadas
% Aridad: 3
pixs_estan_ordenados([],_,_):- !.
    % Caso base: comprobar que todos los pixeles est�n en orden
    % Tipo de predicado: regla
pixs_estan_ordenados(Pixeles,Pos_Correspondiente,A):-
    % Tipo de predicado: regla
    % Pos_correspondiente se ingresa como 0 y se va a ir incrementando en 1
    % La posici�n correspondiente (seg�n el orden establecido) de un pixel
    % viene dado por: ancho * x + y, en la lista de pixeles
    pix1(Pixeles,Pix1), restPixs(Pixeles,RestPixs),
    % Obtengo x e y del pixel 1:
    getX(Pix1,X), getY(Pix1,Y),
    Pos_Pixel is A * X + Y,
    % Si no se cumple la igualdad, se retorna false
    Pos_Pixel = Pos_Correspondiente,
    % Si se cumple se sigue incrementando el contador de posici�n
    % hasta recorrer todos los pixeles comprobando que est�n ordenados
    % o hasta encontrar un pixel desordenado que no cumpla la igualdad
    Pos_sgte is Pos_Correspondiente + 1,
    pixs_estan_ordenados(RestPixs,Pos_sgte,A).
% ############################################################################## %
% Otros Operadores de pixeles:
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% - Clausulas para ordenar pixeles o conservar el orden de estos
% (dependiendo si est�n ordenados o no en x e y)
% Dominio: Pixeles, Posici�n buscada, A: Ancho imagen, Pixel buscado,
%          lista de pixeles no buscados
% Goals: getPixPorPosicion (listas), obtener el pixel buscado y adem�s
%        una lista de los no buscados
% Aridad: 3
ordenarPixs([-1,C,Comp,NoComp],_,[-1,C,Comp,NoComp]):- !.
% - Caso donde los pixeles ingresados son de una imagen comprimida
% de la estructura: [-1,Color, <pixeles comprimidos>,<pixeles no
% comprimidos>], en dicho caso los pixeles no se alteran
ordenarPixs(Pixeles,A,Pixeles):-
    % - Caso donde los pixeles si est�n ordenados
    % Tipo de predicado: regla
    % si los pixeles est�n ordenados no se modifican
    pixs_estan_ordenados(Pixeles,0,A).
ordenarPixs(Pixeles,A,Pixeles_Ordenados):-
    % - Caso donde los pixeles no est�n ordenados
    % Tipo de predicado: regla
    % si los pixeles no est�n ordenados se mueven para
    % ordenarlos
    not(pixs_estan_ordenados(Pixeles,0,A)),
    moverPixs(Pixeles,0,A,Pixeles_Ordenados).
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% - Clausulas para mover los pixeles y asi ordenarlos en terminos de
% sus coordenadas x e y
% Dominio: Pixeles, Posici�n iterador (iniciado en 0), A: Ancho imagen,
%          Pixeles ordenados (lista)
% Goals: moverPixs, mover los pixeles para ordenarlos por coordenadas
% Aridad: 4
moverPixs(Pixeles,Posicion,A,[PixOrdenado|RestPixsOrd]):-
    % - Caso donde a�n hay pixeles por ordenar
    % Tipo de clausula: Regla
    % Se obtiene el pixel por posici�n, se agrega a la lista de pixeles
    % ordenados, y el resto de pixeles con dicho predicado pasa a ser
    % el nuevo argumento de pixeles en la llamada recursiva, adem�s
    % el iterador de posici�n incrementa en 1
    getPixPorPosicion(Pixeles,Posicion,A,PixOrdenado,RestPixs),
    SgtePos is Posicion + 1,
    moverPixs(RestPixs,SgtePos,A,RestPixsOrd).
moverPixs([],_,_,[]):-!.
    % - Caso base: se terminaron de mover todos los pixeles
