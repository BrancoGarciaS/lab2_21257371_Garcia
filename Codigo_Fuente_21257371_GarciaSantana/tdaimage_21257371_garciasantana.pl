:- module(tdaimage_21257371_garciasantana, [getAncho/2, getLargo/2, getPixeles/2]).
:- use_module(requerimientos_tdaimage_21257371_garciasantana).
% ############################################################################## %

% TDA image - Predicados de uso general

% Dominio: I: imagen, A : ancho de la imagen (entero),
%          L: largo de la imagen (Entero), Pixeles: lista pixel

% Predicados: getAncho(I, A). getLargo(I, L). getPixeles(I, Pixeles).

% Metas: secundarias -> getAncho(I, A), getLargo(I, L), getPixeles(I, Pixeles).
%                       (ya que son selectores nivel
%                       general, que se involucran con los predicados
%                       del archivo de requerimientos).


% ############################################################################## %

% Selectores de imagen:

getAncho(I, Ancho):-
    % Dominio: I (imagen), Ancho (de la imagen)
    % Descripción: predicado para seleccionar ancho de la imagen
    % Goals: getAncho, obtener el Ancho de la imagen
    % Aridad: 2
    % Tipo de predicado: regla
    image(Ancho,_,_,I).

getLargo(I, Largo):-
    % Dominio: I (imagen), Largo (de la imagen)
    % Descripción: predicado para seleccionar largo de la imagen
    % Goals: getLargo, obtener el Largo de la imagen
    % Aridad: 2
    % Tipo de predicado: regla
    image(_,Largo,_,I).

getPixeles(I, Pixeles):-
    % Dominio: I (imagen), Pixeles (Lista de pixeles de la imagen)
    % Descripción: predicado para seleccionar los pixeles de la imagen
    % Goals: getPixeles, obtener la lista de pixeles de la imagen
    % Aridad: 2
    % Tipo de predicado: regla
    image(_,_,Pixeles,I).

% ############################################################################## %
















