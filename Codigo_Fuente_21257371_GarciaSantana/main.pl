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
pixbit(X, Y, Bit, Profundidad, [X,Y,Bit,Profundidad]):-
    integer(X),
    integer(Y),
    integer(Bit),
    Bit = 1; Bit = 0,
    integer(Profundidad).

pixhex(X, Y, Color, Profundidad, [X,Y,Color,Profundidad]):-
    integer(X),
    integer(Y),
    string(Color),
    integer(Profundidad).

pixrgb(X, Y, Red, Green, Blue, Profundidad, [X,Y,[Red,Green,Blue],Profundidad]):-
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

getX(P,X):-
    pixbit(X,_,_,_,P);
    pixhex(X,_,_,_,P);
    pixrgb(X,_,_,_,_,_,P).

getY(P,Y):-
    pixbit(_,Y,_,_,P);
    pixhex(_,Y,_,_,P);
    pixrgb(_,Y,_,_,_,_,P).

getColor([_,_,C,_],C).

getD(P,D):-
   pixbit(_,_,_,D,P);
   pixhex(_,_,_,D,P);
   pixrgb(_,_,_,_,_,D,P).

% -------------------------------------------------------------------- %
% Selectores de pixeles:

pix1([Pix1|_],Pix1).

restPixs([_|Resto],Resto).

% -------------------------------------------------------------------- %
% Otros Operadores de pixeles:

% Clausulas para ordenar pixeles o conservar el orden de esto (dependiendo
% si están ordenados o no en x e y)
% Caso donde los pixeles ingresados son de una imagen comprimida de la
% estructura: [-1,<pixeles comprimidos>, <pixeles no comprimidos>], en
% dicho caso los pixeles no se alteran
ordenarPixs([-1,Comp,NoComp],_,[-1,Comp,NoComp]).
ordenarPixs(Pixeles,A,Pixeles):-
    % si los pixeles están ordenados no se modifican
    pixs_estan_ordenados(Pixeles,0,A).
ordenarPixs(Pixeles,A,Pixeles_Ordenados):-
    % si los pixeles no están ordenados se mueven para
    % ordenarlos
    not(pixs_estan_ordenados(Pixeles,0,A)),
    moverPixs(Pixeles,0,A,Pixeles_Ordenados).

% Clausulas para ver si los pixeles están ordenados o no
pixs_estan_ordenados(Pixeles,Pos_Correspondiente,A):-
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
pixs_estan_ordenados([],_,_). % Caso base: comprobar que todos los pixeles están en orden

% Clausulas para obtener un pixel por posición
getPixPorPosicion(Pixeles,Pos_buscada,A,Pix_buscado,[Pix1|PixsNoBusc]):-
    % Obtengo el primer pixel (Pix1) y el resto de pixeles (RestPixs)
    pix1(Pixeles, Pix1), restPixs(Pixeles, RestPixs),
    getX(Pix1,X), getY(Pix1,Y),
    Pos_Pixel is A * X + Y,
    Pos_Pixel =\= Pos_buscada,
    getPixPorPosicion(RestPixs,Pos_buscada,A,Pix_buscado,PixsNoBusc).

getPixPorPosicion(Pixeles,Pos_buscada,A,Pix_buscado,RestPixs):-
    pix1(Pixeles, Pix_buscado), restPixs(Pixeles,RestPixs),
    getX(Pix_buscado,X), getY(Pix_buscado,Y),
    Pos_Pixel is A * X + Y,
    Pos_Pixel = Pos_buscada.

moverPixs(Pixeles,Posicion,A,[PixOrdenado|RestPixsOrd]):-
    getPixPorPosicion(Pixeles,Posicion,A,PixOrdenado,RestPixs),
    SgtePos is Posicion + 1,
    moverPixs(RestPixs,SgtePos,A,RestPixsOrd).
moverPixs([],_,_,[]).

% -------------------------------------------------------------------- %
% Requerimiento 2:
image(Ancho, Alto, Pixeles, [Ancho,Alto,Pixs]):-
    integer(Ancho),
    integer(Alto),
    % se ordenan en caso de ingresar pixeles desordenados en X e Y
    % en caso que la imagen no esté comprimida.
    % Si la imagen está comprimida, sus pixeles no se alteran
    ordenarPixs(Pixeles,Ancho,Pixs).

% -------------------------------------------------------------------- %
% Requerimiento 3:

imageIsBitmap(I):-
    image(_,_,Pixeles, I),
    pix1(Pixeles,Pix1),
    % al considerar la imagen como una estructura de pixeles
    % homogeneos, solo basta analizar que sea pixbit el primer pixel
    pixbit(_,_,_,_,Pix1).
% -------------------------------------------------------------------- %
% Requerimiento 4:

imageIsPixmap(I):-
    image(_,_,Pixeles, I),
    pix1(Pixeles,Pix1),
    % al considerar la imagen como una estructura de pixeles
    % homogeneos, solo basta analizar que sea pixrgb el primer pixel
    pixrgb(_,_,_,_,_,_,Pix1).
% -------------------------------------------------------------------- %
% Requerimiento 5:

imageIsHexmap(I):-
    image(_,_,Pixeles,I),
    pix1(Pixeles,Pix1),
    % al considerar la imagen como una estructura de pixeles
    % homogeneos, solo basta analizar que sea pixhex el primer pixel
    pixhex(_,_,_,_,Pix1).
% -------------------------------------------------------------------- %
% Requerimiento 6:

% La estructura para una imagen comprimida tiene la siguiente forma:
% [Ancho, Alto, [-1, <Pixeles Comprimidos>, <Pixeles No Comprimidos>]]
% donde -1 es un identificador en la zona de pixeles, para indicar
% que la imagen está comprimida, es por ello que solo basta verificar
% la existencia de este valor
imageIsCompressed(I):-
    % obtengo el primer pixel de la lista de pixeles
    getPixeles(I,Pixeles), pix1(Pixeles,Valor),
    number(Valor),
    Valor = -1.
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
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    getAncho(I1,A),
    getLargo(I1,L),
    getPixeles(I1,P),
    invert_H(P,A,Pixs_H),
    image(A,L,Pixs_H,I2).

% Clausula para invertir horizontalmente un pixel: (Y es horizontal)
invY(Pixel, Ancho, [X,Yh,C,D]):-
    % Argumentos: Pixel (Entrada), Ancho imagen, Pixel volteado (Salida)
    % Obtengo la información del pixel
    getX(Pixel,X), getY(Pixel,Y), getColor(Pixel,C), getD(Pixel,D),
    % y_invertido = (ancho - 1) - y_pixel_a_invertir
    Yh is Ancho - 1 - Y.

% Clausulas para invertir horizontalmente todos los pixeles:
invert_H([],_,[]). % caso base: si se recorren todos los pixeles,
% la lista de salida queda vacía
invert_H(Pixeles, Ancho, [InvertidoH|RestInv]):-
    % Obtengo primer pixel y el resto de pixeles
    pix1(Pixeles,Pix1), restPixs(Pixeles,Rest),
    % se invierte horizontalmente el pixel cabecera 'guardandose'
    % en la cabeza de la lista de pixeles invertidos
    invY(Pix1, Ancho, InvertidoH),
    % se vuelve a realizar el mismo procedimiento con el resto
    % de pixeles, hasta llegar al hecho caso base.
    invert_H(Rest, Ancho, RestInv).

% ------------------------------------------------------------------------------ %
% Requerimiento 8:
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
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    getAncho(I1,A),
    getLargo(I1,L),
    getPixeles(I1,P),
    invert_V(P,L,Pixs_V),
    image(A,L,Pixs_V,I2).

% Clausula (Regla) para invertir verticalmente un pixel: (X es vertical)
invX(Pixel, Largo, [Xv,Y,C,D]):-
    % Selecciono la información del pixel
    getX(Pixel,X), getY(Pixel,Y), getColor(Pixel,C), getD(Pixel,D),
    % x_invertido = (largo - 1) - x_pixel_a_invertir
    Xv is Largo - 1 - X.

% Clausulas para invertir verticalmente todos los pixeles:
invert_V([],_,[]). % HECHO - caso base: si se recorren todos los pixeles,
% la lista de salida queda vacía
invert_V(Pixeles, Largo, [InvertidoV|RestInv]):-
    % REGLA - para invertir verticalmente una lista de pixeles.
    % Obtengo el primer pixel y el resto
    pix1(Pixeles,Pix1), restPixs(Pixeles,Rest),
    % Se invierte verticalmente el pixel cabecera 'guardandose'
    % en la cabeza de la lista de pixeles invertidos
    invX(Pix1, Largo, InvertidoV),
    % se vuelve a realizar el mismo procedimiento con el resto
    % de pixeles, hasta llegar al hecho caso base.
    invert_V(Rest, Largo, RestInv).
% ------------------------------------------------------------------------------ %
% Requerimiento 9:
/*
Dominio:
I1: imagen a operar
X1: primer parametro en X para recortar la imagen
Y1: primer parametro en Y para recortar la imagen
X2: segundo parametro en X para recortar la imagen
Y2: segundo parametro en Y para recortar la imagen
I2: imagen recortada

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
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    % Primero se verifica que los puntos de corte sean enteros
    integer(X1), integer(Y1), integer(X2), integer(Y2),
    % Se verifica que los puntos estén dentro del límite de
    % la imagen (los X entre Largo y 0, los Y entre Ancho y 0
    getAncho(I1,Ancho), getLargo(I1,Largo),
    X1 < Largo, X1 >= 0, X2 < Largo, X2 >= 0,
    Y1 < Ancho, Y1 >= 0, Y2 < Largo, Y2 >= 0,
    % Ordeno las coordenadas de entrada en caso que vengan
    % desordenadas
    ordenX1X2Y1Y2(X1,X2,Y1,Y2,X_1,X_2,Y_1,Y_2),
    getPixeles(I1,Pixs),
    recortarpixs(Pixs,X_1,X_2,Y_1,Y_2,0,0,PixsCrop),
    NewA is Y_2 - Y_1  + 1, % nuevo Ancho
    NewL is X_2 - X_1 + 1, % nuevo Largo
    image(NewA,NewL,PixsCrop,I2).

% Clausula para retornar mayor y menor coordenada (en caso que vengan
% desordenadas)
ordenX1X2Y1Y2(X1,X2,Y1,Y2,X1,X2,Y1,Y2):-
    X1 =< X2, Y1 =< Y2.
ordenX1X2Y1Y2(X1,X2,Y1,Y2,X2,X1,Y2,Y1):-
    X1 > X2, Y1 > Y2.
ordenX1X2Y1Y2(X1,X2,Y1,Y2,X1,X2,Y2,Y1):-
    X1 =< X2, Y1 > Y2.
ordenX1X2Y1Y2(X1,X2,Y1,Y2,X2,X1,Y1,Y2):-
    X1 > X2, Y1 =< Y2.

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

recortarpixs(Pixeles,X1,X2,Y1,Y2,X0,Y0,[[X0,Y0,C,D]|Rest2]):-
    % - Caso donde el pixel está dentro del cuadrante a recortar:
    % se incluye en el conjunto de pixeles de salida, donde se alcancen
    % los límites de recorte en Y.
    % Obtengo primer y resto de pixeles:
    pix1(Pixeles,Pix1), restPixs(Pixeles,Rest),
    % Veo si el pixel está entre los puntos de corte
    entrex1x2y1y2(Pix1,X1,X2,Y1,Y2),
    % Obtengo la información del pixel a conservar: color y profundidad
    getColor(Pix1,C), getD(Pix1,D),
    % X0 e Y0 serán iteradores para ir moviendo las coordenadas
    % dentro del cuadrante de recorte y ajustarlas para el pixel
    % a conservar
    Limite is Y2 - Y1,
    % si el Y momentaneo alcanzó el límite de recorte,
    % se avanza X en 1, e Y se reinicia en 0
    Y0 = Limite,
    Xsgte is X0 + 1,
    recortarpixs(Rest,X1,X2,Y1,Y2,Xsgte,0,Rest2).

recortarpixs(Pixeles,X1,X2,Y1,Y2,X0,Y0,[[X0,Y0,C,D]|Rest2]):-
    % - Caso donde el pixel está dentro del cuadrante a recortar:
    % se incluye en el conjunto de pixeles de salida, donde no se
    % alcancen los límites en Y de recorte
    % Obtengo primer y resto de pixeles:
    pix1(Pixeles,Pix1), restPixs(Pixeles,Rest),
    entrex1x2y1y2(Pix1,X1,X2,Y1,Y2),
    % Obtengo la información del pixel a conservar: color y profundidad
    getColor(Pix1,C), getD(Pix1,D),
    % X0 e Y0 serán iteradores para ir moviendo las coordenadas
    % dentro del cuadrante de recorte y ajustarlas para el pixel
    % a conservar
    Limite is Y2 - Y1,
    % si el Y momentaneo no ha alcanzado el límite de recorte,
    % solo se incrementa en 1
    Y0 \== Limite,
    Ysgte is Y0 + 1,
    recortarpixs(Rest,X1,X2,Y1,Y2,X0,Ysgte,Rest2).

recortarpixs(Pixeles,X1,X2,Y1,Y2,X0,Y0,Rest2):-
    % - Caso: si el pixel no está dentro del cuadrante de recorte
    % no se incluye en la lista de pixeles conservados
    % Obtengo primer y resto de pixeles:
    pix1(Pixeles,Pix1), restPixs(Pixeles,Rest),
    not(entrex1x2y1y2(Pix1,X1,X2,Y1,Y2)),
    recortarpixs(Rest,X1,X2,Y1,Y2,X0,Y0,Rest2).

% ------------------------------------------------------------------------------ %
% Requerimiento 10:
/*
Dominio:
I1: imagen a operar (image pixmap)
I2: imagen volteada verticalmente

Predicados:
imageRGBToHex(I1, I2).
hexa(X, XtoStr).
canal_a_hex(Canal,Hexadecimal).
conv_a_hex([X,Y,[R,G,B],D],Pix_hexa).
pixsToHex(Pixeles, [PixsHex|RestHex])

Metas: Principales: imageRGBToHex
*/
imageRGBToHex(I1, I2):-
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    % Para poder llevarse a cabo el predicado, la imagen
    % debe ser pixmap (de pixeles pixrgb)
    imageIsPixmap(I1),
    getAncho(I1,A),
    getLargo(I1,L),
    getPixeles(I1,Pixeles),
    pixsToHex(Pixeles,PixsHex),
    image(A,L,PixsHex,I2).

% Clausulas para convertir numeros decimales a hexadecimales
hexa(X, XtoStr):- % REGLA
    % si es menor a 10, se convierte a string
    X < 10,
    number_string(X,XtoStr).
% HECHOS:
hexa(10,"A").
hexa(11,"B").
hexa(12,"C").
hexa(13,"D").
hexa(14,"E").
hexa(15,"F").

% Clausula para convertir el valor de un canal a hexadecimal
% String de salida -> "<resultado><resto>"
canal_a_hex(Canal,Hexadecimal):-
    H1 is Canal // 16,
    H2 is Canal mod 16,
    hexa(H1,Hexa1),
    hexa(H2,Hexa2),
    string_concat(Hexa1,Hexa2,Hexadecimal).

% Clausula para convertir un pixel a hexadecimal
conv_a_hex(Pixel,Pix_hexa):-
    % Obtengo la información del pixel
    getX(Pixel,X), getY(Pixel,Y),
    getColor(Pixel,[R,G,B]), getD(Pixel,D),
    % Convierto el valor de los canales a hexadecimal
    canal_a_hex(R,R_hex), canal_a_hex(G,G_hex),
    canal_a_hex(B,B_hex),
    % Concateno (uno) los strings de los canales a hexadecimal
    string_concat("#",R_hex,Parte1),
    string_concat(G_hex,B_hex,Parte2),
    string_concat(Parte1,Parte2,Str_hexa),
    % En Pix_hexa queda el pixel convertido
    pixhex(X,Y,Str_hexa,D,Pix_hexa).

% Clausulas para convertir a Hexadecimal todos los pixeles RGB:
pixsToHex([],[]). % HECHO - caso base: si se recorren todos los pixeles,
% convertiendose la lista de salida queda vacía
pixsToHex(Pixeles, [PixsHex|RestHex]):-
    % REGLA - para convertir a hexadecimal una lista de pixeles.
    % Se convierte a hexadecimal el pixel cabecera 'guardandose'
    % en la cabeza de la lista de pixeles hexadecimales
    pix1(Pixeles,Pix1), restPixs(Pixeles,Rest),
    conv_a_hex(Pix1, PixsHex),
    % se vuelve a realizar el mismo procedimiento con el resto
    % de pixeles, hasta llegar al hecho caso base.
    pixsToHex(Rest, RestHex).

% ------------------------------------------------------------------------------ %
% Requerimiento 11:
/*
Dominio:
I1: imagen a operar
Histograma

Predicados:
imageToHistogram(I,Histograma).
mismocolor(Pixeles,Color,Repeticion,[Pix1|Rest2]).
contarcolores(Pixeles,[[Color,Repeticion]|Cola]).

Recursión utilizada: natural(para contar las repeticiones de un color),
                     y de cola (para contar todos los colores de los pixeles)

Metas: Principales: imageToHistogram
*/

imageToHistogram(I,Histograma):-
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I))),
    getPixeles(I,Pixeles),
    contarcolores(Pixeles,Histograma).

% Clausulas para contar un color especifico en la lista de pixeles
% Dominio: Pixel X Color X Repeticion X Pixeles restantes (de otro color)
mismocolor([],_,0,[]). % HECHO - caso base: la repeticion inicia en 0
mismocolor([[_,_,Color,_]|Rest],Color,Repeticion, Rest2):- !,
    % Caso donde el pixel analizado coincide con el color a contar.
    % A traves de recursion natural, se deja un estado en espera, el cual
    % es el valor de Repeticion1 que almacenará las Repeticiones, llegando
    % al caso base que es cuando vale 0 (de ahí se devuelve e irá sumando)
    mismocolor(Rest,Color,Repeticion1,Rest2),
    Repeticion is Repeticion1 + 1.
mismocolor([Pix1|Rest],Color,Repeticion,[Pix1|Rest2]):-
    % Caso donde el color del pixel no coincida con el color buscado.
    % No se altera la cantidad de Repeticiones
    mismocolor(Rest,Color,Repeticion,Rest2).

% Clausulas para contar todos los colores de la lista de pixeles y
% almacenarlos en una lista
contarcolores([],[]). % HECHO - caso base: contar los colores de
% todos los pixeles y almacenar las cuentas en una lista
contarcolores(Pixeles,[[Color,Repeticion]|Cola]):-
    % Obtengo primer pixel
    pix1(Pixeles,Pix1),
    % Se toma en cuenta el color del pixel cabecera almacenando
    % esa información en la lista (salida) de conteo de colores
    getColor(Pix1,Color),
    % Se cuenta el color especifico del pixel cabecera
    % Desde la llamada se obtiene Repeticion el cual es un dato
    % que tambien se deja en la lista de conteo de colores
    mismocolor(Pixeles,Color,Repeticion,PixsRest),
    % Se vuelve a realizar la llamada recursiva, pero con los
    % pixeles restantes que no tienen el color contado
    contarcolores(PixsRest,Cola).
% ------------------------------------------------------------------------------ %
% Requerimiento 12:
/*
Dominio:
I1: imagen a operar
I2: imagen volteada verticalmente

Predicados:
imageRotate90(I1,I2).
rotXY([X,Y,C,D], Largo, [X,Yrot,C,D]). Yrot: Y rotado 90 grados a la derecha
rot90(P,L,Pixs_Rot). P: pixs, L: largo, Pixs_V: pixs rotados 90° a la derecha

Recursión utilizada: de cola (para rotar todos los pixeles), sin dejar
                     estados en espera

Metas: Principales: imageRotate90
*/
imageRotate90(I1,I2):-
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    getAncho(I1,A),
    getLargo(I1,L),
    getPixeles(I1,P),
    rot90(P,L,Pixs_Rot),
    % Al rotar 90 grados las dimensiones de la imagen
    % se invierten (Ancho y Alto)
    image(L,A,Pixs_Rot,I2).

% Clausula para rotar 90° a la derecha un pixel
rotXY(Pixel, Largo, [Y,Yrot,C,D]):-
    % Obtengo la información del pixel:
    getX(Pixel,X), getY(Pixel,Y), getColor(Pixel,C), getD(Pixel,D),
    % Para rotar el pixel, sus coordenadas siguen el siguiente patrón:
    % (x_original, y _original) -> (y_original, largo - 1 - x_original)
    % el resto de información se conserva
    Yrot is Largo - 1 - X.

% Clausulas para rotar 90° todos los pixeles de una lista
rot90([],_,[]). % HECHO - caso base: cuando se recorren todos los pixeles
% rotandose cada uno 90 grados.
rot90(Pixeles, Largo, [Pix1_2|Rest2]):-
    % Obtengo primer y resto de pixeles
    pix1(Pixeles,Pix1), restPixs(Pixeles,Rest),
    % Se rota el pixel cabecera y se incluye en la lista de pixeles rotados
    rotXY(Pix1, Largo, Pix1_2),
    % Se realiza el mismo procedimiento con el resto de pixeles
    rot90(Rest, Largo, Rest2).
% ------------------------------------------------------------------------------ %
% Requerimiento 13:
/*
Dominio:
I1: imagen a operar
I2: imagen comprimida

Predicados:
imageCompress(I1,I2).
maxcolor(Histograma,Max_ref,C_maxRef,A).
	Rep: repeticiones del color, Max_Ref: cantidad maxima de referencia
    C_maxRef: color más repetido de referencia, A: color más repetido
comprimir(Pixeles,ColorMasRep,PosInicial,Conservados,PosComprimidos,Comprimidos).
	PosInicial: inicia en 0, Conservados: pixeles conservados,
    PosComprimidos: posiciones de los pixeles a comprimir,
    Comprimidos: pixeles comprimidos.

Metas: Principales: imageCompress
*/
imageCompress(I,I2):-
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I))),
    imageToHistogram(I, Histograma),
    % Hallo el color más repetido del histograma
    % coloco un -1 como referencia de conteo, ya que los colores no pueden
    % tener una cantidad de repetición negativa y un color C de referencia
    maxcolor(Histograma,-1,_,ColorMasRep),
    % Realizo el proceso de compresión con dicho color más repetido y los
    % pixeles de la imagen
    getPixeles(I,Pixeles),
    comprimir(Pixeles,ColorMasRep,0,Conservados,PosComprimidos,Comprimidos),
    % con la informacion obtenida se construye la imagen comprimida
    % con los pixeles como una lista de la forma:
    % [-1, [<posiciones comprimidos>,<pixeles comprimidos>], <pixeles conservados>]
    % donde -1 servirá como identificador que la imagen está comprimida
    getAncho(I,A),
    getLargo(I,L),
    image(A,L,[-1,[PosComprimidos,Comprimidos],Conservados],I2).

% Clausulas para encontrar el color más repetido del histograma
maxcolor([],_,A,A).
maxcolor([[Color,Rep]|Cola], Max_ref,_,A):-
    Max_ref =< Rep,
    maxcolor(Cola, Rep, Color,A).
maxcolor([[_,Rep]|Cola],Max_ref,C_maxRef,A):-
    Max_ref > Rep,
    maxcolor(Cola,Max_ref,C_maxRef,A).

% Clausulas para separar pixeles comprimidos (con sus posiciones) y conservados
comprimir([],_,_,[],[],[]).
comprimir(Pixeles, C, Pos, Conserv, [Pos|RestPos],[Pix1|RestComp]):-
    % Caso donde el pixel cabecera coincide con el color a comprimir,
    % agregandolo a la lista de pixeles comprimidos, además de la
    % posición en la lista de posiciones de pixeles comprimidos
    % Obtengo primer y resto de pixeles, además del color del
    % pixel que debe coincidir con el color más repetido (del dom)
    pix1(Pixeles,Pix1), restPixs(Pixeles,RestPixs), getColor(Pix1,C),
    PosSgte is Pos + 1,
    comprimir(RestPixs, C, PosSgte, Conserv, RestPos, RestComp).
comprimir(Pixeles,C,Pos,[Pix1|RestConserv],PosComp,Comprimidos):-
    % Caso donde el pixel cabecera no coincide con el color a comprimir
    % se agrega el pixel en la lista de conservados
    pix1(Pixeles,Pix1), restPixs(Pixeles,RestPixs),
    % se avanza la posición y se repite el proceso con el resto de
    % pixeles
    PosSgte is Pos + 1,
    comprimir(RestPixs,C,PosSgte,RestConserv,PosComp,Comprimidos).
% ------------------------------------------------------------------------------ %
% Requerimiento 14:
/*
Dominio:
I1: imagen a operar
NewPixel: pixel a cambiar
I2: imagen con el pixel cambiado

Predicados:
imageChangePixel(I,NewPixel,I2).
reemplazarPix(Pixeles, NewPixel, NewPixels).
	NewPixels: pixeles con el pixel nuevo incluido
esCompatible(I,NewPixel).

Metas: Principales: imageChangePixel
*/
imageChangePixel(I,NewPixel,I2):-
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I))),
    % Para llevar a cabo este predicado el pixel a cambiar
    % debe ser compatible con el tipo de imagen
    esCompatible(I,NewPixel),
    % Obtengo la información de la imagen
    getAncho(I,A), getLargo(I,L), getPixeles(I,Pixeles),
    % Se debe verificar que las coordenadas del nuevo pixel
    % estén dentro del espacio que ocupa la imagen
    getX(NewPixel,X), getY(NewPixel,Y),
    X >= 0, Y >= 0, X < L, Y < A,
    % Reemplazo el nuevo pixel según sus coordenadas en el
    % arreglo de pixeles
    reemplazarPix(Pixeles, NewPixel, NewPixels),
    image(A,L,NewPixels, I2).

% Clausulas para reemplazar el pixel nuevo en la lista de pixeles
% Dominio: pixeles originales X pixel nuevo X pixeles modificados
reemplazarPix([],_,[]). % Hecho - Caso base: que la lista de pixeles
% se recorren completamente

reemplazarPix(Pixeles, [X,Y,C,D] , [[X,Y,C,D]|RestPixs]):-
    % Caso donde el pixel a cambiar cooincide con las coordenadas
	% X Y (atributo único de un pixel) con el pixel a reemplazar
    % Obtengo pixel cabecera y el resto de pixeles
    pix1(Pixeles,Pix1), restPixs(Pixeles, RestPixs),
    % obtengo la información del pixel cabecera que coincide
    % con las coordenadas del pixel nuevo
    getX(Pix1,X), getY(Pix1,Y).

% Caso donde el pixel a cambiar no cooincide con las coordenadas del pixel
% a reemplazar, se colocan los pixeles originales
reemplazarPix(Pixeles, NewPix, [Pix1|RestPixsNew]):-
    pix1(Pixeles,Pix1), restPixs(Pixeles,RestPixs),
    reemplazarPix(RestPixs, NewPix, RestPixsNew).

% Clausulas para ver que el pixel a cambiar es compatible con el
% tipo de imagen a operar
esCompatible(I,NewPixel):-
    % si el pixel es pixbit, la imagen debe ser bitmap
    pixbit(_,_,_,_,NewPixel), imageIsBitmap(I).
esCompatible(I,NewPixel):-
    % si el pixel es pixrgb, la imagen debe ser pixmap
    pixrgb(_,_,_,_,_,_,NewPixel), imageIsPixmap(I).
esCompatible(I,NewPixel):-
    % si el pixel es pixhex, la imagen debe ser hexmap
    pixhex(_,_,_,_,NewPixel), imageIsHexmap(I).

% ------------------------------------------------------------------------------ %
% Requerimiento 15:
/*
Dominio:
Pixel: pixrgb-d a operar
Pix_inv: pixrgb-d con sus canales RGB volteados

Predicados:
invertColorRGB(Pixel,Pix_inv)

Metas: Principales: imageInvertColorRGB
*/
imageInvertColorRGB(Pixel,Pix_inv):-
    % Verifico que el pixel sea pixrgb
    pixrgb(_,_,_,_,_,_,Pixel),
    % Obtengo la información del pixel original
    getX(Pixel,X), getY(Pixel,Y),
    getColor(Pixel,[R,G,B]), getD(Pixel,D),
    % Para invertir cada canal resto 255 con cada valor
    R_inv is 255 - R,
    G_inv is 255 - G,
    B_inv is 255 - B,
    % Construyo el nuevo pixel con los canales invertidos
    pixrgb(X,Y,R_inv,G_inv,B_inv,D,Pix_inv).
% ------------------------------------------------------------------------------ %
% Requerimiento 16:
/*
Dominio:
I: imagen a operar
Str: string representativo de los colores de la imagen

Predicados:
imageToString(I,Str)
a_string(Pixeles,LimY,StrIni,Sout)
	- LimY: limite en y para hacer salto de línea al alcanzarlo con un pixel
    - StrIni: string donde se irá guardando la conversión de todos los colores
    a string y los saltos de linea; inicia en ''
    - Sout: Argumento para dejar el string de salida
colorString(Color,ColorStr) -> convierte el color de un pixel a string

Metas: Principales: imageToString
*/
imageToString(I,Str):-
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I))),
    % Obtengo la información de la imagen
    getAncho(I,A),
    getPixeles(I,Pixeles),
    % Defino el límite en Y para decidir cuando colocar
    % salto de linea en el string
    LimY is A - 1,
    a_string(Pixeles,LimY,"",Str).

% Clausulas para pasar a formato string cada pixel de la lista
% de pixeles (para hacerlo se debe tener en cuenta los límites en Y
% de la imagen para saber cuando hacer salto de linea)
a_string([],_,S,S). % HECHO - Caso base: si se convirtió en string cada
% color de todos los pixeles, se "copia" el string trabajado e iniciado en ''
% en el string de salida
a_string([[_,LimY,C,_]|RestPixs], LimY, StrIni, Sout):-
    % Caso donde el pixel posee de coordenada Y el mismo valor
    % que el limite de la imagen en Y, en dicho caso se debe
    % convertir a string el color, concatenarlo con el string inicial
    % y unir todo a un salto de línea
    colorString(C,StringC),
    string_concat(StrIni,StringC,StrColors),
    string_concat(StrColors,'\n', StrSgte),
    % Se vuelve a repetir el proceso con el resto de pixeles,
    % actualizando el string inicial
    a_string(RestPixs,LimY, StrSgte,Sout).
a_string([[_,_,C,_]|RestPixs],LimY, StrIni,Sout):-
    % Caso donde el pixel no está en el límite Y, en dicho caso solo
    % se realiza un espacio mediante '\t' luego de convertir a string
    % el color y unirlo a la cadena de string inicial
    colorString(C,StringC),
    string_concat(StrIni,StringC,StrColors),
    string_concat(StrColors, '\t', StrSgte),
    % Se vuelve a repetir el proceso con el resto de pixeles,
    % actualizando el string inicial
    a_string(RestPixs,LimY, StrSgte,Sout).

% Clausulas para convertir los colores de un pixel a string
colorString(Color,Color):- % En caso de color hexadecimal de un pixhex-d
    string(Color).
colorString(Bit,Str):- % En caso del color bit de un pixbit-d
    integer(Bit),
    % La conversión a string del bit queda en "Str"
    number_string(Bit,Str).
colorString([R,G,B], Str):- % En caso de canales de color de un pixrgb-d
    integer(R), integer(G), integer(B),
    % Paso a string los 3 canales
    number_string(R, Rstr),number_string(G, Gstr),number_string(B, Bstr),
    % Uno cada canal con un espacio (para que en la representación
    % estén distanciados entre si)
    string_concat(Rstr," ", R_str), string_concat(Gstr, " ", G_str),
    string_concat(Bstr, " ", B_str),
    % Uno el valor Red con Green en un string
    string_concat(R_str,G_str,R_G_Str),
    % Uno el valor RG con Blue
    string_concat(R_G_Str, B_str, RGB_Str),
    % Luego uno el RGB string con dos parentesis para encerrar
    string_concat(RGB_Str, ")", RGB_P),
    % guardo el string final en el de argumento "Str" (salida)
    string_concat("(", RGB_P, Str).
% ------------------------------------------------------------------------------ %
% Requerimiento 17:
/*
Dominio:
I: imagen a operar
LI: lista de imagenes (image list)

Predicados:
imageDepthLayers(I,LI).
separarD(Pixeles,PixelesCopia,[ImageD|RestImages],A,L).
	- PixelesCopia: copia de los pixeles de la imagen
	- ImageD: será una imagen con todos sus pixeles de la misma profundidad
    rellenado con pixeles blancos (si no se encuentran pixeles de dicha
    profundidad)
    - A: ancho de la imagen
    - L: largo de la imagen
whitePixel(Pixel,D,PixelBlanco).
	- Pixel: pixel a convertir en blanco
    - D: profundidad
    - PixelBlanco: pixel a convertir en blanco con la profundidad
    especifica a colocar

Metas: Principales: imageDepthLayers.
*/
imageDepthLayers(I,LI):-
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    getAncho(I,A), getLargo(I,L),
    getPixeles(I,Pixeles),
    separarD(Pixeles,Pixeles,LI,A,L).

% Clausulas para construir imagenes a través de los pixeles, una copia de
% estos, más el ancho y largo de la imagen, almacenandose la operación en
% una lista de imagenesD
separarD([],_,[],_,_).
separarD(Pixeles,PixelesCopia,[ImageD|RestImages],A,L):-
    % Obtengo el primer pixel de la lista de pixeles y la profundidad
    % de este
    pix1(Pixeles,Pixel), getD(Pixel,D),
    % Obtengo los pixeles de misma y de diferente profundidad
    mismaprof(PixelesCopia, D, PixelesD, PixsDRest,0),
    image(A,L,PixelesD,ImageD),
    separarD(PixsDRest,PixelesCopia,RestImages,A,L).

% Clausulas para que con una profundidad se almacenen los pixeles
% de igual profundidad (reemplazando con pixeles blanco a los no coincidentes),
% además de guardar a los pixeles de diferente profundidad.
% pixeles originales X prof a buscar X Pixeles mismo D relleno blanco
%                                    X Pixeles sobrantes
% Defino variable marcadora para indicar cuando empiezo a agregar
% los pixeles no coincidentes en profundidad a la lista de pixeles
% sobrantes 0 cuando no se ha sobrepasado el primer pixel de los
% sobrantes. Si se sobrepasa se vuelve 1 y se empiezan a considerar
% el resto de sobrantes (en el caso que tengan diferente
% profundidad. (Esto es para no considerar pixeles de profundidades
% ya recorridas y colocarlos como sobrantes)
mismaprof([],_,[],[],_). % HECHO - Caso base: cuando se recorrieron
% todos los pixeles, recolectando los que tienen la misma profundidad
% a la buscada y dejando los que no en pixeles sobrantes (de diferente D)
mismaprof([[X,Y,C,D]|Rest],D,[[X,Y,C,D]|RestPixsD], PixsDifD,_):-
    Marcador is 1,
    % Caso cuando se encuentra por primera vez el pixel con dicha
    % profundidad en los pixeles no recorridos.
    % En caso de coincidir con la profundidad a buscar
    % se agrega el pixel a la lista de pixeles de igual profundidad
    mismaprof(Rest,D,RestPixsD,PixsDifD,Marcador).
mismaprof([Pixel|Rest],D,[PixBlancoD|RestPixsD],[Pixel|RestPixsDifD],1):-
    % En caso de que el pixel no coincida en la profundidad a buscar
    % se agrega a la lista de restantes, y se agrega un pixel blanco
    % a la lista de pixeles de igual profundidad
    whitePixel(Pixel,D,PixBlancoD),
    mismaprof(Rest,D,RestPixsD,RestPixsDifD,1).
mismaprof([Pixel|Rest],D,[PixBlancoD|RestPixsD],RestPixsDifD,0):-
    % en caso de que el pixel no coincida en la profundidad a buscar
    % y aun no se ha encontrado un primer pixel con la
    % profundidad buscada, no se agrega a la lista de restantes y
    % se agrega un pixel blanco a los pixeles de igual profundidad
    whitePixel(Pixel,D,PixBlancoD),
    mismaprof(Rest,D,RestPixsD,RestPixsDifD,0).

% Clausulas para cambiar la profundidad de un pixel y pasarlo a blanco
whitePixel(Pixel,D,PixelBlanco):- % CASO pixbit-d
    pixbit(_,_,_,_,Pixel),
    getX(Pixel,X), getY(Pixel,Y),
    pixbit(X,Y,1,D,PixelBlanco).
whitePixel(Pixel,D,PixelBlanco):- % CASO pixhex-d
    pixhex(_,_,_,_,Pixel),
    getX(Pixel,X), getY(Pixel,Y),
    pixhex(X,Y,'#FFFFFF',D,PixelBlanco).
whitePixel(Pixel,D,PixelBlanco):- % CASO pixrgb-d
    pixrgb(_,_,_,_,_,_,Pixel),
    getX(Pixel,X), getY(Pixel,Y),
    pixrgb(X,Y,255,255,255,D,PixelBlanco).
% ------------------------------------------------------------------------------ %
% Requerimiento 18:
/*
Dominio:
I: imagen comprimida
I2: imagen descomprimida

Predicados:
imageDecompress(I,I2).
recuperarPixs(Pixeles,I,PixelesDescomp).
	- Pixeles: pixeles de la imagen comprimida
    del formato <-1, Comprimidos, PixelesNoComprimidos>
	Formato Comprimidos: <Pos_Comp, PixelesComprimidos>
	Pos_Comp: posiciones de los pixeles comprimidos
        PixelesComprimidos: los pixeles comprimidos
	- I: iterador de posición (inicia en 0)
    - PixelesDescomp: pixeles comprimidos y no comprimidos unidos
    en una nueva lista de pixeles

Metas: Principales: imageDecompress.
*/
imageDecompress(I,I2):-
    % para descomprimir la imagen debe estar comprimida
    imageIsCompressed(I),
    % Obtengo la información de la imagen
    getPixeles(I,Pixeles), getAncho(I,A), getLargo(I,L),
    % Descomprimo los pixeles
    recuperarPixs(Pixeles,0,PixelesDescomp),
    % Creo la nueva imagen con los pixeles descomprimidos
    image(A,L,PixelesDescomp,I2).

% Contador I inicia en 0
% HECHO - caso base: cuando ya se recorrieron todos los pixeles comprimidos,
% conservados y las posiciones de la lista de posiciones
recuperarPixs([_,[[],[]],[]],_,[]).
recuperarPixs([_,[[I|RestPos],[Comp1|RestComp]],Conserv], I,
              [Comp1|RestRecuperados]):-
    % - Caso donde contador I coincide con la primera posicion de comprimidos
    % En este caso se agrega el primer pixel comprimido a los recuperados
    Isgte is I + 1,
    recuperarPixs([_,[RestPos,RestComp],Conserv],Isgte,RestRecuperados).
recuperarPixs([_,[Pos,Comprimidos],[Conserv1|RestConserv]], I,
              [Conserv1|RestRecuperados]):-
    % - Caso donde el contador no coincide con la posicion de comprimidos
    % En este caso se agrega el primer pixel conservado a
    % los pixeles recuperados
    Isgte is I + 1,
    recuperarPixs([_,[Pos,Comprimidos],RestConserv],Isgte,RestRecuperados).




































