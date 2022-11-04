:- module(tdapixeles_21257371_garciasantana,[getX/2,getY/2,getColor/2,getD/2,pix1/2,
                      restPixs/2,getPixPorPosicion/5,pixs_estan_ordenados/3,
                      ordenarPixs/3,moverPixs/4]).
:- use_module(tdapixhex_21257371_garciasantana).
:- use_module(tdapixrgb_21257371_garciasantana).
:- use_module(tdapixbit_21257371_garciasantana).

% ############################################################################## %

% TDA pixeles y pixel general

% ############################################################################## %

% TDA pixel (general)

% Dominio: P: pixel (pixbit, pixhex o pixrgb),
%          X: coordenada X del pixel(entero),
%          Y : coordenada Y del pixel(entero),
%          C: color del pixel, D: profundidad del pixel (entero)

% Predicados: getX(P, X). getY(P, Y).
%             getColor(P, C). getD(P, D).

% Metas: secundarias -> getX(P,X), getY(P,Y),
%                       getColor(P,C), getD(P,D). % reglas
%                       (ya que es constructor y selectores nivel
%                       general, que se involucran con los predicados
%                       del archivo de requerimientos).

% ---
% Selectores:

getX(Pixel,X):-
    % Dominio: pixel (de cualquier tipo: pixbit, pixhex, pixrgb), coordenada X
    %          del pixel (entero)
    % Goals: getX, obtener la coordenada en X de cualquiera de los pixeles
    % Descripción: este predicado se utiliza para obtener la coordenada X
    %              de cualquier tipo de pixel
    % Aridad: 2
    % Tipo de predicado: regla
    getX_h(Pixel,X);
    getX_r(Pixel,X);
    getX_b(Pixel,X), !.

getY(Pixel,Y):-
    % Dominio: pixel (de cualquier tipo: pixbit, pixhex, pixrgb), coordenada Y
    %          del pixel (entero)
    % Goals: getY, obtener la coordenada en Y de cualquiera de los pixeles
    % Descripción: este predicado se utiliza para obtener la coordenada Y
    %              de cualquier tipo de pixel
    % Aridad: 2
    % Tipo de predicado: regla
    getY_h(Pixel,Y);
    getY_r(Pixel,Y);
    getY_b(Pixel,Y), !.

getColor(Pixel,Color):-
    % Dominio: pixel (de cualquier tipo: pixbit, pixhex, pixrgb), color del
    %          pixel (bit entero, string hexadecimal, lista rgb).
    % Goals: getColor, obtener el color de cualquiera de los pixeles.
    % Descripción: este predicado se utiliza para obtener el color
    %              de cualquier tipo de pixel
    % Aridad: 2
    % Tipo de predicado: regla
    getColor_h(Pixel,Color);
    getColor_r(Pixel,Color);
    getColor_b(Pixel,Color), !.

getD(Pixel,D):-
    % Dominio: pixel (de cualquier tipo: pixbit, pixhex, pixrgb), profundidad
    %          del pixel (entero)
    % Goals: getD, obtener la profundidad de cualquiera de los pixeles.
    % Descripción: este predicado se utiliza para obtener la profundidad
    %              de cualquier tipo de pixel.
    % Aridad: 2
    % Tipo de predicado: regla
    getD_h(Pixel,D);
    getD_r(Pixel,D);
    getD_b(Pixel,D), !.

% ############################################################################## %

% TDA pixeles (lista de pixel pixrgb, pixhex o pixbit)

% Dominio: Pixs : lista de pixeles, P1: pixel 1 de la lista (pixel),
%          RPixs: resto de pixeles de la lista (list),
%          P: marcador de posición (entero iniciado en 0),
%          A: ancho de imagen (entero), Pix_busc: pixel buscado (pixel)
%          Pixs_no_busc: pixeles no buscados (list),
%          Pixs_ord: pixeles ordenados

% Predicados: pix1(Pixs,P1). restPixs(Pixs,RPixs).
%             getPixPorPosicion(Pixs,P,A,Pix_busc,Pixs_no_busc).
%             pixs_estan_ordenados(Pixs,P,A). ordenarPixs(Pixs,A,Pixs_ord).
%             moverPixs(Pixs,P,A,Pixs_ord).

% Metas: secundarias -> pix1(Pixs,P1), restPixs(Pixs,RPixs),
%             getPixPorPosicion(Pixs,P,A,Pix_busc,Pixs_no_busc),
%             pixs_estan_ordenados(Pixs,P,A), ordenarPixs(Pixs,A,Pixs_ord),
%             moverPixs(Pixs,P,A,Pixs_ord). % reglas
%             (ya que son selectores, predicados de pertenencia a nivel
%             general, que se involucran con los predicados
%             del archivo de requerimientos).
/*

- Predicados:

Selectores:
pix1(Pixs,P1).
restPixs(Pixs,RPixs).
getPixPorPosicion(Pixs,P,A,Pix_busc,Pixs_no_busc).

De pertenencia:
pixs_estan_ordenados(Pixs,P,A).

Otras operaciones:
ordenarPixs(Pixs,A,Pixs_ord).
moverPixs(Pixs,P,A,Pixs_ord).

*/

% ############################################################################## %
% Selectores de pixeles:

pix1([Pix1|_],Pix1). % Dominio: Lista de Pixeles, Cabeza de la lista (pixel 1)
                     % Goals: pix1 (lista), primer pixel de lista de pixeles
                     % Descripción: este predicado se usa para obtener la
                     %              cabeza (primer pixel) de la lista de pixeles
                     % Aridad: 2
                     % Tipo de predicado: hecho

restPixs([_|Resto],Resto). % Dominio: Lista de Pixeles, Resto de pixeles (cola)
                     % Goals: restPixs (lista), resto de pixeles de la lista
                     % Descripción: este predicado se usa para obtener
                     %              el resto de pixeles de la lista (sin
                     %              considerar el primero)
                     % Aridad: 2
                     % Tipo de predicado: hecho

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% - Clausulas para obtener un pixel por posición y los no coincidentes:
% Dominio: Pixeles, Posición buscada, A: Ancho imagen, Pixel buscado,
%          lista de pixeles no buscados
% Goals: getPixPorPosicion (listas), obtener el pixel buscado y además
%        una lista de los no buscados
% Descripción: este predicado se usa para obtener el pixel buscado dada
%              una posición a buscar, además de obtener el resto de
%              pixeles no buscados
% Aridad: 5
% Tipo de predicado: regla
% Tipo de recursión: recursión natural, ya que mientras se tenga un
% pixel cabecera que tenga posición distinta a la buscada, el resto
% de pixeles no buscados (la cola de dicha lista) está en un estado
% en espera.
getPixPorPosicion(Pixeles,Pos_buscada,A,Pix_buscado,[Pix1|PixsNoBusc]):-
    % - Caso donde el pixel cabecera tiene posición distinta a la buscada
    % agregandose en la lista de pixeles no buscados.
    % Obtengo el primer pixel (Pix1) y el resto de pixeles (RestPixs)
    pix1(Pixeles, Pix1), restPixs(Pixeles, RestPixs),
    getX(Pix1,X), getY(Pix1,Y),
    % La posición correspondiente de un pixel viene dada por
    % el producto entre el ancho de la imagen y la coordenada
    % X, más la coordenada Y del pixel
    Pos_Pixel is A * X + Y,
    Pos_Pixel =\= Pos_buscada,
    getPixPorPosicion(RestPixs,Pos_buscada,A,Pix_buscado,PixsNoBusc).

getPixPorPosicion(Pixeles,Pos_buscada,A,Pix_buscado,RestPixs):-
    % - Caso donde el pixel cabecera tiene posición igual a la buscada.
    % En este caso se coloca el resto de pixeles en los pixeles no
    % buscados y se detiene la recursión.
    % Obtengo el primer pixel (Pix1) y el resto de pixeles (RestPixs)
    pix1(Pixeles, Pix_buscado), restPixs(Pixeles,RestPixs),
    getX(Pix_buscado,X), getY(Pix_buscado,Y),
    Pos_Pixel is A * X + Y,
    Pos_Pixel = Pos_buscada, !.

% ############################################################################## %

% Predicados de pertenencia:

% - Clausulas para ver si los pixeles están ordenados o no
% Dominio: Pixeles, Pos_Correspondiente (iterador de posiciones iniciado en 0),
%          A (ancho de la imagen)
% Goals: pixs_estan_ordenados (booleano), verificar si los pixeles de la
%        lista de pixeles, está ordenado en terminos de sus coordenadas
% Descripción: ver si los pixeles están ordenados, a través de un
%              contador de posición correspondiente y el ancho de la
%              imagen
% Recorrido: true si los pixeles están ordenados, false si los pixeles
%            no están ordenados
% Aridad: 3

pixs_estan_ordenados([],_,_):- !.
    % Caso base: comprobar que todos los pixeles están en orden

pixs_estan_ordenados(Pixeles,Pos_Correspondiente,A):-
    % Tipo de predicado: regla
    % Pos_correspondiente se ingresa como 0 y se va a ir incrementando en 1
    % La posición correspondiente (según el orden establecido) de un pixel
    % viene dado por: ancho * x + y, en la lista de pixeles
    pix1(Pixeles,Pix1), restPixs(Pixeles,RestPixs),
    % Obtengo x e y del pixel 1:
    getX(Pix1,X), getY(Pix1,Y),
    Pos_Pixel is A * X + Y,
    % Si no se cumple la igualdad, se retorna false
    Pos_Pixel = Pos_Correspondiente,
    % Si se cumple se sigue incrementando el contador de posición
    % hasta recorrer todos los pixeles comprobando que están ordenados
    % o hasta encontrar un pixel desordenado que no cumpla la igualdad
    Pos_sgte is Pos_Correspondiente + 1,
    pixs_estan_ordenados(RestPixs,Pos_sgte,A).

% ##############################################################################
%
%  Otros Operadores de pixeles:
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
% - Clausulas para ordenar pixeles
% o conservar el orden de estos (dependiendo si están ordenados o no en x
% e y)
% Dominio: Pixeles, Posición buscada, A: Ancho imagen, Pixel
%          buscado, lista de pixeles no buscados
% Goals: getPixPorPosicion (listas), obtener el pixel buscado y además
%        una lista de los no buscados
% Descripción: este predicado ordena los pixeles de la lista de pixeles,
%              en caso de que estos estén desordenados
% Aridad: 3
ordenarPixs([-1,C,Comp,NoComp],_,[-1,C,Comp,NoComp]):- !.
% - Caso donde los pixeles ingresados son de una imagen comprimida
% de la estructura: [-1,Color, <pixeles comprimidos>,<pixeles no
% comprimidos>], en dicho caso los pixeles no se alteran
ordenarPixs(Pixeles,A,Pixeles):-
    % - Caso donde los pixeles si están ordenados
    % Tipo de predicado: regla
    % si los pixeles están ordenados no se modifican
    pixs_estan_ordenados(Pixeles,0,A).
ordenarPixs(Pixeles,A,Pixeles_Ordenados):-
    % - Caso donde los pixeles no están ordenados
    % Tipo de predicado: regla
    % si los pixeles no están ordenados se mueven para
    % ordenarlos
    not(pixs_estan_ordenados(Pixeles,0,A)),
    moverPixs(Pixeles,0,A,Pixeles_Ordenados).
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  %
% - Clausulas para mover los pixeles y asi ordenarlos en terminos de
% sus coordenadas x e y
% Dominio: Pixeles, Posición iterador (iniciado en 0), A: Ancho imagen,
%          Pixeles ordenados (lista)
% Goals: moverPixs, mover los pixeles para ordenarlos por coordenadas
% Descripción: mueve los pixeles de una imagen según su ancho y un
%              marcador de posición, para ordenarlos en torno a X e Y
% Aridad: 4
% Tipo de recursión: Natural, ya que mientras se van moviendo los
% pixeles, el resto de pixeles ordenados es un estado en espera hasta
% llegar al caso base
moverPixs([],_,_,[]):-!.
    % - Caso base: se terminaron de mover todos los pixeles
moverPixs(Pixeles,Posicion,A,[PixOrdenado|RestPixsOrd]):-
    % - Caso donde aún hay pixeles por ordenar
    % Tipo de clausula: Regla
    % Se obtiene el pixel por posición, se agrega a la lista de pixeles
    % ordenados, y el resto de pixeles con dicho predicado pasa a ser
    % el nuevo argumento de pixeles en la llamada recursiva, además
    % el iterador de posición incrementa en 1
    getPixPorPosicion(Pixeles,Posicion,A,PixOrdenado,RestPixs),
    SgtePos is Posicion + 1,
    moverPixs(RestPixs,SgtePos,A,RestPixsOrd).





























