:- module(requerimientos_funcionales_21257371_garciasantana,[image/4, imageIsBitmap/1,
          imageIsPixmap/1, imageIsHexmap/1,imageIsCompressed/1,imageFlipH/2,invert_H/3,
          invY/3,imageFlipV/2,invert_V/3,invX/3,imageCrop/6,ordenX1X2Y1Y2/8,
          recortarpixs/8,entrex1x2y1y2/5,imageRGBToHex/2, pixsToHex/2, conv_a_hex/2,
          canal_a_hex/2, hexa/2, imageToHistogram/2, contarcolores/2, mismocolor/4,
          imageRotate90/2, rot90/3, rotXY/3, imageCompress/2, maxcolor/4, comprimir/5,
          imageChangePixel/3, reemplazarPix/3, esCompatible/2, imageInvertColorRGB/2,
          imageToString/2, a_string/4, colorString/3, imageDepthLayers/2, mismaprof/4,
          buscarD/4, ajustarPixsD/7, iterar/5, whitePixel/4, imageDecompress/2,
          recuperarPixs/4, descomprime/4]).
:- use_module(tdapixeles_21257371_garciasantana).
:- use_module(tdapixhex_21257371_garciasantana).
:- use_module(tdapixrgb_21257371_garciasantana).
:- use_module(tdapixbit_21257371_garciasantana).
:- use_module(tdaimage_21257371_garciasantana).

% ############################################################################## %

% Predicados Requeridos

% ############################################################################## %

% Requerimiento 2:
image(Ancho, Alto, Pixeles, [Ancho,Alto,Pixs]):- % Predicado constructor
    % Dominio: Ancho (de la imagen), Alto(de la imagen),
    %          Pixeles (de la imagen), Imagen (lista de ancho, alto, pixeles)
    % Goals: image, construir una imagen
    % Aridad: 4
    % Tipo de predicado: regla
    integer(Ancho),
    integer(Alto),
    % se ordenan en caso de ingresar pixeles desordenados en X e Y
    % en caso que la imagen no esté comprimida.
    % Si la imagen está comprimida, sus pixeles no se alteran
    ordenarPixs(Pixeles,Ancho,Pixs).
% ------------------------------------------------------------------------------ %
% Requerimiento 3:
imageIsBitmap(I):- % Predicado de pertenencia
    % Dominio: Imagen (I)
    % Goals: imageIsBitmap, predicado para indicar si una imagen es bitmap
    %       (en ese caso, se entrega la estructura de esta) y
    %        no lo es muestra false
    % Aridad: 1
    % Tipo de predicado: regla
    image(_,_,Pixeles, I), % Obtengo los pixeles de la imagen
    pix1(Pixeles,Pix1), % Obtengo el primer pixel de la imagen
    % al considerar la imagen como una estructura de pixeles
    % homogeneos, solo basta analizar que sea pixbit el primer pixel
    pixbit(_,_,_,_,Pix1),!.

% ------------------------------------------------------------------------------ %
% Requerimiento 4:
imageIsPixmap(I):- % Predicado de pertenencia
    % Dominio: Imagen (I)
    % Goals: imageIsPixmap, predicado para indicar si una imagen es pixmap
    %       (en ese caso, se entrega la estructura de esta) y
    %        si no lo es se muestra un false
    % Aridad: 1
    % Tipo de predicado: regla
    image(_,_,Pixeles, I), % Obtengo los pixeles de la imagen
    pix1(Pixeles,Pix1), % Obtengo el primer pixel de la imagen
    % al considerar la imagen como una estructura de pixeles
    % homogeneos, solo basta analizar que sea pixrgb el primer pixel
    pixrgb(_,_,_,_,_,_,Pix1),!.
% ------------------------------------------------------------------------------ %
% Requerimiento 5:
imageIsHexmap(I):- % Predicado de pertenencia
    % Dominio: Imagen (I)
    % Goals: imageIsHexmap, predicado para indicar si una imagen es hexmap
    %       (en ese caso, se entrega la estructura de esta) y
    %        si no lo es se muestra un false
    % Aridad: 1
    % Tipo de predicado: regla
    image(_,_,Pixeles,I), % Obtengo los pixeles de la imagen
    pix1(Pixeles,Pix1), % Obtengo el primer pixel de la imagen
    % al considerar la imagen como una estructura de pixeles
    % homogeneos, solo basta analizar que sea pixhex el primer pixel
    pixhex(_,_,_,_,Pix1),!.
% ------------------------------------------------------------------------------ %
% Requerimiento 6:
imageIsCompressed(I):- % Predicado de pertenencia
    % Dominio: Imagen (I)
    % Goals: imageIsCompressed, predicado para indicar si una imagen está
    %        comprimida (en ese caso, se entrega la estructura de la imagen
    %        comprimida) y si no lo está se muestra un false
    % Aridad: 1
    % Tipo de predicado: regla
    % - La estructura para una imagen comprimida tiene la siguiente forma:
    % [Ancho, Alto, [-1, <Pixeles Comprimidos>, <Pixeles No Comprimidos>]]
    % donde -1 es un identificador en la zona de pixeles, para indicar
    % que la imagen está comprimida, es por ello que solo basta verificar
    % la existencia de este valor

    % obtengo el primer pixel de la lista de pixeles, que en realidad sería
    % un entero -1
    getPixeles(I,Pixeles), pix1(Pixeles,Valor),
    number(Valor), % Verifico que sea un número
    Valor = -1,!.
% ------------------------------------------------------------------------------ %
% Requerimiento 7:

/* imageFlipH:
- Dominio:
I1: imagen a operar
I2: imagen invertida horizontalmente
- Predicados:
imageFlipH(I1,I2).
invY([X,Y,C,D], Largo, [X,Yh,C,D]). Y: y invertido horizontalmente
invert_H(P,L,Pixs_H). P: pixs, L: largo, Pixs_H: pixs invertidos
horizontalmente
- Meta principal: imageFlipH, predicado para voltear
horizontalmente una imagen
- Aridad: 2
- Tipo de predicado: regla
- Estrategia: primero se trabaja con un pixel, luego con el resto de
pixeles y finalmente con la imagen
- Tipo de Recursión: natural, el predicado para invertir horizontalmente
los pixeles invert_H deja estados en espera.
*/
imageFlipH(I1,I2):- % Predicado modificador
    % La imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    % Obtengo la información de la imagen
    getAncho(I1,A),
    getLargo(I1,L),
    getPixeles(I1,P),
    % Invierto horizontalmente los pixeles
    invert_H(P,A,Pixs_H),
    % Creo otra imagen con los pixeles invertidos horizontalmente
    image(A,L,Pixs_H,I2), !.
% ---------------
% Clausulas para invertir horizontalmente todos los pixeles:
% - Dominio: Pixeles, Ancho, PixelesInvertidos (lista)
% - Goals: invert_H, invertir horizontalmente una lista de pixeles
% - Aridad: 3
% - Tipo de predicado: regla
% - Tipo de recursión: natural, ya que hay estados en espera mientras se
% va construyendo la lista de pixeles invertidos
invert_H([],_,[]):- !. % caso base: si se recorren todos los pixeles,
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
% ---------------
invY(Pixel, Ancho, [X,Yh,C,D]):-
    % - Dominio: Pixel (Entrada), Ancho imagen, Pixel volteado (Salida)
    % - Goals: invY, invertir horizontalmente un pixel (Y es horizontal)
    % - Aridad: 3
    % - Tipo de predicado: regla
    % Obtengo la información del pixel
    getX(Pixel,X), getY(Pixel,Y), getColor(Pixel,C), getD(Pixel,D),
    % y_invertido = (ancho - 1) - y_pixel_a_invertir
    Yh is Ancho - 1 - Y.
% ------------------------------------------------------------------------------
% Requerimiento 8:

/* imageFlipV:
- Dominio:
I1: imagen a operar
I2: imagen volteada verticalmente
- Predicados:
imageFlipV(I1,I2).
invX([X,Y,C,D], Largo, [Xv,Y,C,D]). Xv: x volteado verticalmente
invert_V(P,L,Pixs_V). P: pixs, L: largo, Pixs_V: pixs volteados verticalmente
- Meta Principal: imageFlipV, predicado para invertir verticalmente
una imagen
- Aridad: 2
- Tipo de predicado: regla
- Estrategia: primero se trabaja con un pixel, luego con el resto de
pixeles y finalmente con la imagen
- Tipo de Recursión: natural, el predicado para invertir verticalmente
los pixeles invert_V deja estados en espera.

*/
imageFlipV(I1,I2):- % Predicado modificador
    % La imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    % Obtengo la información de la imagen
    getAncho(I1,A),
    getLargo(I1,L),
    getPixeles(I1,P),
    % Invierto Verticalmente los pixeles
    invert_V(P,L,Pixs_V),
    % Construyo la nueva imagen I2 con los pixeles invertidos verticalmente
    image(A,L,Pixs_V,I2), !.
% ---------------
% Clausulas para invertir verticalmente todos los pixeles:
% - Dominio: Pixeles, Largo, PixelesInvertidos (lista)
% - Goals: invert_V, invertir verticalmente una lista de pixeles
% - Aridad: 3
% - Tipo de predicado: regla
% - Tipo de recursión: natural, ya que hay estados en espera mientras se
% va construyendo la lista de pixeles invertidos
invert_V([],_,[]):- !. % caso base: si se recorren todos los pixeles,
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
% ---------------
invX(Pixel, Largo, [Xv,Y,C,D]):-
    % - Dominio: Pixel (Entrada), Largo de imagen, Pixel volteado (Salida)
    % - Goals: invX, invertir verticalmente un pixel (X es vertical)
    % - Aridad: 3
    % - Tipo de predicado: regla
    % Selecciono la información del pixel
    getX(Pixel,X), getY(Pixel,Y), getColor(Pixel,C), getD(Pixel,D),
    % x_invertido = (largo - 1) - x_pixel_a_invertir
    Xv is Largo - 1 - X.
% ------------------------------------------------------------------------------ %
% Requerimiento 9:
/*
- Dominio:
I1: imagen a operar
X1: primer parametro en X para recortar la imagen (entero)
Y1: primer parametro en Y para recortar la imagen (entero)
X2: segundo parametro en X para recortar la imagen (entero)
Y2: segundo parametro en Y para recortar la imagen (entero)
I2: imagen recortada
- Predicados:
imageCrop(I1,X1,Y1,X2,Y2,I2).
entrex1x2y1y2(Pixel,X1,X2,Y1,Y2).
recortarpixs(Pixs,X1,X2,Y1,Y2,X0,Y0,PixsCrop).
- Meta principal: imageCrop, recortar una imagen respecto a 4 puntos
de corte en x e y
- Aridad: 6
- Tipo de predicado: regla
- Estrategia: primero se ordenaron los parametros de corte, luego se
comprueba si el pixel está posicionado dentro del intervalo de recorte
- Tipo de Recursión: Natural, ya que predicado recortarPixs deja estados
en espera
*/
imageCrop(I1,X1,Y1,X2,Y2,I2):- % Predicado modificador
    % La imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    % Se verifica que los puntos de corte sean enteros
    integer(X1), integer(Y1), integer(X2), integer(Y2),
    % Se verifica que los puntos estén dentro del límite de
    % la imagen (los X entre Largo y 0, los Y entre Ancho y 0
    getAncho(I1,Ancho), getLargo(I1,Largo), getPixeles(I1,Pixs),
    X1 < Largo, X1 >= 0, X2 < Largo, X2 >= 0,
    Y1 < Ancho, Y1 >= 0, Y2 < Ancho, Y2 >= 0,
    % Ordeno las coordenadas de entrada en caso de requerirse
    ordenX1X2Y1Y2(X1,X2,Y1,Y2,X_1,X_2,Y_1,Y_2),
    % Recorto los pixeles que estén fuera de los parametros de corte
    recortarpixs(Pixs,X_1,X_2,Y_1,Y_2,0,0,PixsCrop),
    % Actualizo el ancho y largo (diferencia entre los parametros de corte)
    % creando la nueva imagen (I2)
    NewA is Y_2 - Y_1  + 1, % nuevo Ancho
    NewL is X_2 - X_1 + 1, % nuevo Largo
    image(NewA,NewL,PixsCrop,I2), !.
% ---------------
% Clausula para retornar mayor y menor coordenada (en caso que vengan
% desordenadas)
% - Dominio: X1, X2, Y1, Y2 (Parametros de recorte)
%            X_1, X_2, Y_1, Y_2 (Parametros de recorte ordenados)
%            donde X_1 < X_2, Y_1 < Y_2
% - Goals: ordenX1X2Y1Y2, ordenar parametros de recorte
% - Aridad: 8
% - Tipo de predicado: regla
ordenX1X2Y1Y2(X1,X2,Y1,Y2,X1,X2,Y1,Y2):- X1 =< X2, Y1 =< Y2.
ordenX1X2Y1Y2(X1,X2,Y1,Y2,X2,X1,Y2,Y1):- X1 > X2, Y1 > Y2.
ordenX1X2Y1Y2(X1,X2,Y1,Y2,X1,X2,Y2,Y1):- X1 =< X2, Y1 > Y2.
ordenX1X2Y1Y2(X1,X2,Y1,Y2,X2,X1,Y1,Y2):- X1 > X2, Y1 =< Y2.
% ---------------
% Clausulas para recortar lista de pixeles:
% - Dominio: Pixeles, X1, X2, Y1, Y2 (Parametros de recorte),
%            X0: marcador (iniciado en 0) de posicion en X para
%                ajuste de coordenadas de pixeles no recortados,
%            Y0: marcador (iniciado en 0) de posicion en Y para
%                ajuste de coordenadas de pixeles no recortados,
%            PixsCrop: pixeles recortados
% - Goals: recortar cada pixel fuera de los parametros de recorte
%          de la lista de pixeles
% - Aridad: 8
% - Tipo de predicado: regla
% - Tipo de recursión: natural, ya que mientras se recorta se dejan
%                      estados en espera (rest2)
recortarpixs([],_,_,_,_,_,_,[]):-!. % Caso base: cuando se
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
% ---------------
% Clausulas para recortar lista de pixeles:
% - Dominio: Pixeles, X1, X2, Y1, Y2 (Parametros de recorte),
%            X0: marcador (iniciado en 0) de posicion en X para
%                ajuste de coordenadas de pixeles no recortados,
%            Y0: marcador (iniciado en 0) de posicion en Y para
%                ajuste de coordenadas de pixeles no recortados,
%            PixsCrop: pixeles recortados
% - Goals: entrex1x2y1y2, para ver si un pixel está dentro de los
%          parametros de recorte (intervalo X e Y) y no va a ser
%          recortado
% - Aridad: 5
% - Tipo de predicado: regla
entrex1x2y1y2(Pixel,X1,X2,Y1,Y2):- % Predicado de pertenencia
    getX(Pixel,X), getY(Pixel,Y),
    X >= X1, X =< X2, Y >= Y1, Y =< Y2.
% ------------------------------------------------------------------------------ %
% Requerimiento 10:
/*
- Dominio:
I1: imagen a operar (image pixmap)
I2: imagen volteada verticalmente
- Predicados:
imageRGBToHex(I1, I2).
hexa(X, XtoStr).
canal_a_hex(Canal,Hexadecimal).
conv_a_hex([X,Y,[R,G,B],D],Pix_hexa).
pixsToHex(Pixeles, [PixsHex|RestHex])
- Metas: imageRGBToHex, convertir una imagen de pixeles RGB a hexadecimal
- Aridad: 2
- Tipo de predicado: regla
- Estrategia: primero se diseñó predicado para convertir a hexadecimal
un pixel rgb, luego otro para convertir a todos de la lista de pixeles
- Tipo de Recursión: Natural, ya que predicado recortarPixs deja estados
en espera
*/
imageRGBToHex(I1, I2):- % Tipo: otras operaciones
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    % Para poder llevarse a cabo el predicado, la imagen
    % debe ser pixmap (de pixeles pixrgb)
    imageIsPixmap(I1),
    % Obtengo la información de la imagen
    getAncho(I1,A), getLargo(I1,L), getPixeles(I1,Pixeles),
    % Convierto todos los pixeles a hexadecimal
    pixsToHex(Pixeles,PixsHex),
    % Construyo una nueva imagen I2 con los pixeles en hexadecimal
    image(A,L,PixsHex,I2), !.
% ---------------
% - Dominio: Pixeles, PixelesHex
% - Goals: pixsToHex, convertir a hexadecimal todos los pixeles RGB
% - Aridad: 2
% - Tipo de predicado: regla
% - Tipo de recursión: recursión natural, ya que se dejan estados en
%   espera mientras se va construyendo la lista de pixeles hexadecimales
pixsToHex([],[]):- !. % Caso base: si se recorren todos los pixeles,
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
% ---------------
% - Dominio: Pixel, Pix_hexa (pixel convertido a hexadecimal)
% - Goals: conv_a_hex, convertir un pixel a hexadecimal
% - Aridad: 2
% - Tipo de predicado: regla
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
% ---------------
% - Dominio: Canal rgb (entero), Hexadecimal (string)
% - Goals: convertir el valor de un canal rgb a notación hexadecimal
% - Aridad: 2
canal_a_hex(Canal,Hexadecimal):-
    % String hexadecimal -> "<resultado: canal//16><resto>"
    H1 is Canal // 16, H2 is Canal mod 16,
    hexa(H1,Hexa1), hexa(H2,Hexa2),
    string_concat(Hexa1,Hexa2,Hexadecimal).
% ---------------
% - Dominio: X Numero decimal (entero), XtoStr Numero hexadecimal (string)
% - Goals: Convertir el valor de un número decimal a hexadecimal
% - Aridad: 2
hexa(X, XtoStr):- % Tipo de predicado: regla
    % si es menor a 10, se convierte a string
    X < 10, number_string(X,XtoStr).
% Tipo de predicado: hecho
hexa(10,"A").
hexa(11,"B").
hexa(12,"C").
hexa(13,"D").
hexa(14,"E").
hexa(15,"F").
% ------------------------------------------------------------------------------ %
% Requerimiento 11:
/*
- Dominio:
I1: imagen a operar
Histograma
- Metas: imageToHistogram, mostrar el histograma (frecuencias de color) de
una imagen
- Predicados:
imageToHistogram(I,Histograma).
mismocolor(Pixeles,Color,Repeticion,[Pix1|Rest2]).
contarcolores(Pixeles,[[Color,Repeticion]|Cola]).
- Aridad: 2
- Tipo de predicado: regla
- Recursión utilizada: natural(para contar las repeticiones de un color)
- Estrategia: primero cuento un color, luego el resto de colores
*/
imageToHistogram(I,Histograma):- % Tipo: Otras operaciones
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I))),
    % Se obtiene los pixeles de la imagen
    getPixeles(I,Pixeles),
    % Se cuentan los colores de los pixeles obteniendose el histograma
    contarcolores(Pixeles,Histograma), !.
% ---------------
% - Dominio: Pixeles, Histograma ([[Color1,Repeticion], ....])
% - Goals: contarcolores, contar todos los colores de la lista
% de pixeles y almacenarlos en una lista
% - Aridad: 2
% - Tipo de predicado: Regla
% - Recursión utilizada: natural, pues al contar se dejan estados en espera
contarcolores([],[]):-!. % caso base: contar los colores de
% todos los pixeles y almacenar las cuentas en una lista
contarcolores(Pixeles,[[Color,Repeticion]|Cola]):-
    % Obtengo primer pixel y su color, almacenando esa información en
    % la lista de conteo de colores
    pix1(Pixeles,Pix1), getColor(Pix1,Color),
    % Se cuenta el color especifico del pixel cabecera
    % Desde la llamada se obtiene Repeticion el cual es un dato
    % que tambien se deja en la lista de conteo de colores
    mismocolor(Pixeles,Color,Repeticion,PixsRest),
    % Se vuelve a realizar la llamada recursiva, pero con los
    % pixeles restantes que no tienen el color contado
    contarcolores(PixsRest,Cola).
% ---------------
% - Dominio: Pixel X Color X Repeticion X Pixeles restantes (de otro color)
% - Goals: contar un color especifico en la lista de pixeles
% - Aridad: 4
mismocolor([],_,0,[]):- !. % caso base: la repeticion inicia en 0
mismocolor([[_,_,Color,_]|Rest],Color,Repeticion, Rest2):- !,
    % - Tipo de predicado: regla
    % Caso donde el pixel analizado coincide con el color a contar.
    % A traves de recursion natural, se deja un estado en espera, el cual
    % es el valor de Repeticion1 que almacenará las Repeticiones, llegando
    % al caso base que es cuando vale 0 (de ahí se devuelve e irá sumando)
    mismocolor(Rest,Color,Repeticion1,Rest2),
    Repeticion is Repeticion1 + 1.
mismocolor([Pix1|Rest],Color,Repeticion,[Pix1|Rest2]):-
    % - Tipo de predicado: regla
    % Caso donde el color del pixel no coincida con el color buscado.
    % No se altera la cantidad de Repeticiones
    mismocolor(Rest,Color,Repeticion,Rest2).
% ------------------------------------------------------------------------------ %
% Requerimiento 12:
/*
- Dominio:
I1: imagen a operar
I2: imagen volteada verticalmente
- Metas: imageRotate90, rotar 90 grados a la derecha una imagen
- Predicados:
imageRotate90(I1,I2).
rotXY([X,Y,C,D], Largo, [X,Yrot,C,D]). Yrot: Y rotado 90 grados a la derecha
rot90(P,L,Pixs_Rot). P: pixs, L: largo, Pixs_V: pixs rotados 90° a la derecha
- Aridad: 2
- Tipo de predicado: regla
- Recursión utilizada: natural (para rotar todos los pixeles)
- Estrategia: primero creo predicado para rotar un pixel, luego otro
para rotar todo el resto de la lista de pixeles
*/
imageRotate90(I1,I2):- % Predicado modificador
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I1))),
    % Obtengo información de la imagen I1
    getAncho(I1,A), getLargo(I1,L), getPixeles(I1,P),
    % Roto 90 grados a la derecha todos los pixeles
    rot90(P,L,Pixs_Rot),
    % Al rotar 90 grados las dimensiones de la imagen
    % se invierten (Ancho y Alto) en la nueva imagen I2
    image(L,A,Pixs_Rot,I2), !.
% ---------------
% - Dominio: Pixeles, Largo, Pixeles rotados 90 grados
% - Goals: rot90, para rotar 90° todos los pixeles de una lista
% - Aridad: 3
% - Tipo de predicado: regla
rot90([],_,[]):- !. % Caso base: cuando se recorren todos los pixeles
% rotandose cada uno 90 grados.
rot90(Pixeles, Largo, [Pix1_2|Rest2]):-
    % Obtengo primer y resto de pixeles
    pix1(Pixeles,Pix1), restPixs(Pixeles,Rest),
    % Se rota el pixel cabecera y se incluye en la lista de pixeles rotados
    rotXY(Pix1, Largo, Pix1_2),
    % Se realiza el mismo procedimiento con el resto de pixeles
    rot90(Rest, Largo, Rest2).
% ---------------
% - Dominio: Pixel, Largo, Pixeles Rotados
% - Goals: rotXY, para rotar 90° a la derecha un pixel
% - Aridad: 3
% - Tipo de predicado: regla
rotXY(Pixel, Largo, [Y,Yrot,C,D]):-
    % Obtengo la información del pixel:
    getX(Pixel,X), getY(Pixel,Y), getColor(Pixel,C), getD(Pixel,D),
    % Para rotar el pixel, sus coordenadas siguen el siguiente patrón:
    % (x_original, y _original) -> (y_original, largo - 1 - x_original)
    % el resto de información se conserva
    Yrot is Largo - 1 - X.
% ------------------------------------------------------------------------------ %
% Requerimiento 13:
/*
- Dominio:
I1: imagen a operar
I2: imagen comprimida
- Metas: imageCompress, comprimir una imagen
- Predicados:
imageCompress(I1,I2).
maxcolor(Histograma,Max_ref,C_maxRef,A).
	Rep: repeticiones del color, Max_Ref: cantidad maxima de referencia
    C_maxRef: color más repetido de referencia, A: color más repetido
comprimir(Pixeles, C, Pos, Conserv, Comprimidos).
	Pos: inicia en 0, Conserv: pixeles conservados,
    Comprimidos: información pixeles comprimidos.
- Aridad: 2
- Tipo de predicado: regla
- Recursión utilizada: natural (para comprimir los pixeles)
- Estrategia: primero creo predicado para hallar el color más frecuente
del histograma, luego creo otro para comprimir los pixeles en base a ese color
*/
imageCompress(I,I2):- % Tipo: otras operaciones
    % La imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I))),
    imageToHistogram(I, Histograma), % Obtengo histograma de la imagen
    % Hallo el color más repetido del histograma
    % coloco un -1 como referencia de conteo, ya que los colores no pueden
    % tener una cantidad de repetición negativa
    maxcolor(Histograma,-1,_,ColorMasRep),
    % Realizo el proceso de compresión con dicho color más repetido y los
    % pixeles de la imagen
    getPixeles(I,Pixeles),
    comprimir(Pixeles,ColorMasRep,0,Conservados,Comprimidos),
    % con la informacion obtenida se construye la imagen comprimida
    % con los pixeles como una lista de la forma:
    % [-1, <color comp>, [<pos comp>,< D pixs comp>], <pixeles conservados>]
    % donde -1 servirá como identificador que la imagen está comprimida
    getAncho(I,A), getLargo(I,L),
    image(A,L,[-1,ColorMasRep,Comprimidos,Conservados],I2), !.
% ---------------
% - Dominio: Histograma, Max_ref: Cantidad máxima de referencia
%            (inicia en -1), C_maxRef: color más repetido de referencia,
%            A: repetición de conteo final (de salida)
% - Goals: maxcolor, para encontrar el color más repetido del histograma
% - Aridad: 4
maxcolor([],_,A,A). % Tipo de predicado: hecho.
                    % Caso base: cuando se recorre todo el histograma
maxcolor([[Color,Rep]|Cola], Max_ref,_,A):- % Tipo de predicado: Regla
    % Si se encuentra un color más repetido que el máximo referencial
    % se actualiza el Maximo referencial y el color más repetido
    Max_ref < Rep, maxcolor(Cola, Rep, Color,A).
maxcolor([[_,Rep]|Cola],Max_ref,C_maxRef,A):- % Tipo de predicado: Regla
    % Si no se encuentra un color más repetido, se pasa al siguiente color
    % del histograma
    Max_ref >= Rep, maxcolor(Cola,Max_ref,C_maxRef,A).
% ---------------
% - Dominio: Pixeles, C: color a comprimir, Pos: marcador de posición
%            (iniciado en 0), Conserv: pixeles conservados,
%            Comprimidos: (lista) posiciones pixeles comprimidos y profundidad.
% - Goals: comprimir, para separar pixeles comprimidos
% - Aridad: 5
% - Tipo de predicado: regla (Otras operaciones)
% - Tipo de recursión: natural, ya que mientras se construyen las listas
%                      de pixeles conservados y comprimidos se dejan estados
%                      en espera
comprimir([],_,_,[],[]):- !.
           % Caso base: cuando se recorrieron los pixeles
comprimir(Pixeles, C, Pos, Conserv, [[Pos,D]|RestComp]):-
    % - Caso donde el pixel cabecera coincide con el color a comprimir,
    % agregando su profundidad a la lista de comprimidos, además de la
    % posición.
    % Obtengo primer y resto de pixeles, además del color del
    % pixel que debe coincidir con el color más repetido (del dom)
    pix1(Pixeles,Pix1), restPixs(Pixeles,RestPixs), getColor(Pix1,C),
    getD(Pix1,D), PosSgte is Pos + 1,
    comprimir(RestPixs, C, PosSgte, Conserv, RestComp).
comprimir(Pixeles, C, Pos, [Pix1|RestConserv], Comprimidos):-
    % - Caso donde el pixel cabecera no coincide con el color a comprimir.
    % se agrega el pixel en la lista de conservados
    pix1(Pixeles,Pix1), restPixs(Pixeles,RestPixs),
    % se avanza la posición y se repite el proceso con el resto de
    % pixeles
    PosSgte is Pos + 1,
    comprimir(RestPixs,C,PosSgte, RestConserv, Comprimidos).
% ------------------------------------------------------------------------------ %
% Requerimiento 14:
/*
- Dominio:
I1: imagen a operar
NewPixel: pixel nuevo por el cual cambiar
I2: imagen con el pixel cambiado
- Metas: imageChangePixel, cambiar el pixel de una imagen en una coordenada
especifica, por uno nuevo
- Predicados:
imageChangePixel(I,NewPixel,I2).
reemplazarPix(Pixeles, NewPixel, NewPixels).
	NewPixels: pixeles con el pixel nuevo incluido
esCompatible(I,NewPixel).
- Aridad: 3
- Tipo de predicado: regla
- Recursión utilizada: natural (para cambiar pixel)
- Estrategia: reemplazar el pixel a través de su atributo único:
sus coordenadas
*/
imageChangePixel(I,NewPixel,I2):- % Predicado modificador
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
    image(A,L,NewPixels, I2), !.
% ---------------
% - Dominio: pixeles originales X pixel nuevo X pixeles modificados
% - Goals: reemplazarPix, para reemplazar el pixel nuevo en la lista de pixeles
% - Aridad: 3
% - Tipo de predicado: regla (modificador)
% - Recursión utilizada: natural (para reemplazar pixel), dejando
% estados en espera mientras se construye el resto de pixeles con
% el nuevo sustituido
reemplazarPix([],_,[]):-
    !. % Caso base: que la lista de pixeles se recorren completamente
reemplazarPix(Pixeles, [X,Y,C,D] , [[X,Y,C,D]|RestPixs]):-
    % - Caso donde el pixel a cambiar cooincide con las coordenadas
	% X Y (atributo único de un pixel) con el pixel a reemplazar
    % Obtengo pixel cabecera y el resto de pixeles
    pix1(Pixeles,Pix1), restPixs(Pixeles, RestPixs),
    % Obtengo la información del pixel cabecera que coincide
    % con las coordenadas del pixel nuevo
    getX(Pix1,X), getY(Pix1,Y).
reemplazarPix(Pixeles, NewPix, [Pix1|RestPixsNew]):-
    % - Caso donde el pixel a cambiar no cooincide con las coordenadas
    % del pixel a reemplazar, se colocan los pixeles originales
    pix1(Pixeles,Pix1), restPixs(Pixeles,RestPixs),
    reemplazarPix(RestPixs, NewPix, RestPixsNew).
% ---------------
% - Dominio: I: imagen, NewPixel
% - Goals: esCompatible, para ver que el pixel a cambiar es compatible con el
% tipo de imagen a operar
% - Aridad: 2
% - Tipo de predicado: regla de pertenencia
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
- Dominio:
Pixel: pixrgb-d a operar
Pix_inv: pixrgb-d con sus canales RGB volteados
- Metas: imageInvertColorRGB, invertir los canales RGB de un pixrgb
- Predicados:
invertColorRGB(Pixel,Pix_inv)
- Aridad: 2
- Tipo de predicado: regla, modificador
- Estrategia: restar 255 con el valor de cada valor
*/
imageInvertColorRGB(Pixel,Pix_inv):- % Predicado modificador
    % Verifico que el pixel sea pixrgb
    pixrgb(_,_,_,_,_,_,Pixel),
    % Obtengo la información del pixel original
    getX(Pixel,X), getY(Pixel,Y),
    getColor(Pixel,[R,G,B]), getD(Pixel,D),
    % Para invertir cada canal resto 255 con cada valor
    R_inv is 255 - R, G_inv is 255 - G, B_inv is 255 - B,
    % Construyo el nuevo pixel con los canales invertidos
    pixrgb(X,Y,R_inv,G_inv,B_inv,D,Pix_inv), !.
% ------------------------------------------------------------------------------ %
% Requerimiento 16:
/*
- Dominio:
I: imagen a operar
Str: string representativo de los colores de la imagen
- Metas: imageToString, para pasar la imagen a una representación string
Predicados:
imageToString(I,Str)
a_string(Pixeles,LimY,StrIni,Sout)
	- LimY: limite en y para hacer salto de línea al alcanzarlo con un pixel
    - StrIni: string donde se irá guardando la conversión de todos los colores
    a string y los saltos de linea; inicia en ''
    - Sout: Argumento para dejar el string de salida
colorString(Color,ColorStr) -> convierte el color de un pixel a string
- Aridad: 2
- Tipo de predicado: regla, otras operaciones
- Tipo de recursión: natural, ya que mientras se va construyendo el
string, el string de salida no está definido, hasta llegar al caso base
- Estrategia: convertir a string el color de un pixel, luego hacer lo
mismo con todos los pixeles
*/
imageToString(I,Str):-
    % La imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I))),
    % Obtengo la información de la imagen
    getAncho(I,A), getPixeles(I,Pixeles),
    % Defino el límite en Y para decidir cuando colocar
    % salto de linea en el string
    LimY is A - 1,
    a_string(Pixeles,LimY,"",Str), !.
% ---------------
% - Dominio: Pixeles, LimY: limite en Y de la imagen,
%           StrIni: String iniciado en "", Str: String resultante
% - Goals: a_string, para pasar a formato string cada pixel de la lista
% de pixeles (para hacerlo se debe tener en cuenta los límites en Y
% de la imagen para saber cuando hacer salto de linea)
% - Aridad: 4
% - Tipo de predicado: regla (otras operaciones)
% - Tipo de recursión: recursión natural, ya que el string de salida Sout
% recién obtiene un valor al final (caso base)
a_string([],_,S,S):- !. % Caso base: si se convirtió en string cada
% color de todos los pixeles, se "copia" el string trabajado e iniciado en ''
% en el string de salida
a_string([[_,LimY,C,D]|RestPixs], LimY, StrIni, Sout):-
    % Caso donde el pixel posee de coordenada Y el mismo valor
    % que el limite de la imagen en Y, en dicho caso se debe
    % convertir a string el color, concatenarlo con el string inicial
    % y unir todo a un salto de línea
    colorString(C,D,StringC),
    string_concat(StrIni,StringC,StrColors),
    string_concat(StrColors,'\n', StrSgte),
    % Se vuelve a repetir el proceso con el resto de pixeles,
    % actualizando el string inicial
    a_string(RestPixs,LimY, StrSgte,Sout).
a_string([[_,_,C,D]|RestPixs],LimY, StrIni,Sout):-
    % Caso donde el pixel no está en el límite Y, en dicho caso solo
    % se realiza un espacio mediante '\t' luego de convertir a string
    % el color y unirlo a la cadena de string inicial
    colorString(C,D,StringC),
    string_concat(StrIni,StringC,StrColors),
    string_concat(StrColors, '\t', StrSgte),
    % Se vuelve a repetir el proceso con el resto de pixeles,
    % actualizando el string inicial
    a_string(RestPixs,LimY, StrSgte,Sout).
% ---------------
% - Dominio: Color (bit entero, hexadecimal string o lista rgb,
%            D: profundidad, Color
% - Goals: colorString, para convertir los colores de un pixel a string
% - Aridad: 3
% - Tipo de predicado: regla (otras operaciones)
colorString(Color,_,Color):- % En caso de color hexadecimal de un pixhex-d
    string(Color).
colorString(Bit,_,Str):- % En caso del color bit de un pixbit-d
    integer(Bit),
    % La conversión a string del bit queda en "Str"
    number_string(Bit,Str).
colorString([R,G,B], D, Str):- % En caso de canales de color de un pixrgb-d
    integer(R), integer(G), integer(B),
    % Paso a string los 3 canales
    number_string(R, Rstr),number_string(G, Gstr),
    number_string(B, Bstr),number_string(D, Dstr),
    % Uno cada canal con un espacio (para que en la representación
    % estén distanciados entre si)
    string_concat(Rstr," ", R_str), string_concat(Gstr, " ", G_str),
    string_concat(Bstr, " ", B_str),
    % Uno el valor Red con Green en un string
    string_concat(R_str,G_str,R_G_Str),
    % Uno el valor RG con Blue
    string_concat(R_G_Str, B_str, RGB_Str),
    % Uno con la profundidad
    string_concat(RGB_Str, Dstr, RGBD_Str),
    % Luego uno el RGB string con dos parentesis para encerrar
    string_concat(RGBD_Str, ")", RGBD_P),
    % guardo el string final en el de argumento "Str" (salida)
    string_concat("(", RGBD_P, Str).
% ------------------------------------------------------------------------------ %
% Requerimiento 17:
/*
- Dominio:
I: imagen a operar
LI: lista de imagenes (image list)
- Metas: imageDepthLayers, para crear una lista de imagenes por profundidad
respecto a las profundidades de los pixeles de la imagen original
- Predicados:
imageDepthLayers(I,LI).
mismaprof(Pixeles,A,L,LI).
ajustarPixsD(Pixs_mismoD,0,0,LimX,LimY,Pix1,PixsDAjustados).
iterar(X0,Y0,LimY,Xsgte,Ysgte).
whitePixel(Pixel,X0,Y0,PixelBlanco).
- Aridad: 2
- Tipo de predicado: regla, otras operaciones
- Tipo de recursión: natural, ya que mientras se va construyendo cada
imagen, el resto de imagenes por profundidad no se define hasta llegar
al caso base
- Estrategia: separar pixeles por profundidad, ajustar y construir
imagenes en torno a esa separación
*/
imageDepthLayers(I,LI):-
    % la imagen a operar no debe estar comprimida
    (not(imageIsCompressed(I))),
    getAncho(I,A), getLargo(I,L),
    getPixeles(I,Pixeles),
    mismaprof(Pixeles,A,L,LI), !.
% ---------------
% - Dominio: Pixeles, A: ancho de la imagen, L: largo de la imagen,
%            ImagenesD: lista de imagenes por profundidad
% - Goals: construir una lista de imagenes separadas por profundidad
%          y rellenas de pixeles blancos
% - Aridad: 4, Tipo de predicado: regla, otras operaciones
mismaprof([],_,_,[]):- !. % Caso base: se recorrieron todos los pixeles
mismaprof(Pixeles,A,L,[ImageD|RestImagesD]):-
    LimX is L - 1, LimY is A - 1,
    % Primero busco un D específico que será del pixel cabecera
    pix1(Pixeles,Pix1), getD(Pix1,D),
    buscarD(Pixeles,D,Pixs_mismoD,Pixs_difD),
    % a los Pixeles de misma profundidad se le hace un ajuste
    % rellenandolos con pixeles blancos
    ajustarPixsD(Pixs_mismoD,0,0,LimX,LimY,Pix1,PixsDAjustados),
    % Con dichos pixeles ajustados se construye la nueva imagen
    % que irá en la lista de imagenes de salida
    image(A,L,PixsDAjustados,ImageD),
    % Y recursivamente se sigue trabajando con el resto de pixeles
    % de diferente profundidad
    mismaprof(Pixs_difD,A,L,RestImagesD).
% ---------------
% - Dominio: Pixeles, D: profundidad buscada, PixsD: pixeles de misma
%          profundidad, Pixs_DifD: pixeles de diferente profundidad
% - Goals: buscarD, separar en una lista los pixeles coincidentes
%          con la profundidad buscada, y en la otra los no coincidentes
% - Aridad: 4
% - Tipo de recursión: recursión natural, ya que mientras se van
% construyendo las 2 listas, sus colas están en espera hasta llegar
% al caso base
% - Tipo de predicado: regla, otras operaciones
buscarD([],_,[],[]):- !. % Caso base: se recorrieron todos los pixeles
buscarD(Pixeles,D,[Pix1|RestD],Pixs_DifD):-
    % - Caso donde el pixel coincide con la profundidad buscada:
    % se agrega el Pixel 1 a la lista de Pixeles de mismo D
    pix1(Pixeles, Pix1), getD(Pix1,D), restPixs(Pixeles,Rest),
    buscarD(Rest,D,RestD,Pixs_DifD).
buscarD(Pixeles,D,PixsD, [Pix1|RestDifD]):-
    % - Caso donde el pixel no coincide con la profundidad buscada:
    % se agrega el Pixel cabecera a la lista de Pixeles de
    % diferente D
    pix1(Pixeles,Pix1), restPixs(Pixeles,Rest),
    buscarD(Rest, D, PixsD, RestDifD).
% ---------------
% - Dominio: PixelesD: pixeles de misma profundidad, X0: iterador de
%            posición en X iniciado en 0, Y0, LimX: límite de la imagen
%            en X, LimY, PixRef: pixel de referencia (para crear pixel
%            blanco), Pixeles Ajustados
% - Goals: ajustarPixsD, ajustar los pixeles rellenando con pixeles
%          blancos en posiciones donde no se encuentre ningún pixel
% - Aridad: 7
% - Tipo de recursión: recursión natural, ya que la cola de los pixeles
%                      ajustados queda en espera hasta el caso base
% - Tipo de predicado: regla, otras operaciones
ajustarPixsD(_,X0,_,LimX,_,_,[]):-
    % Caso base: cuando el marcador X0 supera los límites en X de
    % la imagen
    X0 > LimX.
ajustarPixsD(PixelesD,X0,Y0,LimX,LimY,PixRef,[Pix1|RestAjustados]):-
    % - Caso donde pixel cabecera coincide con las coordenadas X0, Y0
    % se incluye en la lista de pixeles ajustados
    pix1(PixelesD,Pix1), getX(Pix1,X0), getY(Pix1,Y0),
    restPixs(PixelesD,Rest),
    % Y se itera x0 e y0
    iterar(X0,Y0,LimY,Xsgte,Ysgte),
    ajustarPixsD(Rest,Xsgte,Ysgte,LimX,LimY,PixRef,RestAjustados).
ajustarPixsD(PixelesD,X0,Y0,LimX,LimY,PixRef,[PixBlanco|RestAjustados]):-
    % - Caso donde pixel cabecera no coincide con las coordenadas X0,Y0
    % se crea un pixel blanco en dicha posición
    whitePixel(PixRef,X0,Y0,PixBlanco),
    iterar(X0,Y0,LimY,Xsgte,Ysgte),
    ajustarPixsD(PixelesD,Xsgte,Ysgte,LimX,LimY,PixRef,RestAjustados).
% ---------------
% - Dominio: X0,Y0,LimY,Xsgte,Ysgte
% - Goals: iterar, obtener el sucesor de las coordenas X0 e Y0, sin
% pasar los límites de la imagen en ancho.
% - Aridad: 5, Tipo de predicado: regla (modificador de coordenada)
iterar(X0,Y0,Y0,Xsgte,0):-
    % - Caso donde el marcador Y0 alcanzo los límites del ancho de la
    % imagen, el Y se queda en 0 y el X incrementa 1
    Xsgte is X0 + 1.
iterar(X0,Y0,_,X0,Ysgte):-
    % Caso donde el marcador Y0 no ha alcanzado los límites del ancho
    % de la imagen, el Y incrementa en 1, el X se conserva
    Ysgte is Y0 + 1.
% ---------------
% - Dominio: Pixel, X0: coordenada X, Y0: coordenada Y, PixelBlanco
% - Goals: whitePixel, predicado para crear un pixel blanco,
% con un pixel de referencia y unas coordenadas X0 Y0 específicas
% - Aridad: 4, Tipo de predicado: regla, predicado constructor
whitePixel(Pixel,X0,Y0,PixelBlanco):- % CASO pixbit-d
    pixbit(_,_,_,_,Pixel), getD(Pixel,D),
    pixbit(X0,Y0,1,D,PixelBlanco).
whitePixel(Pixel,X0,Y0,PixelBlanco):- % CASO pixhex-d
    pixhex(_,_,_,_,Pixel), getD(Pixel,D),
    pixhex(X0,Y0,"#FFFFFF",D,PixelBlanco).
whitePixel(Pixel,X0,Y0,PixelBlanco):- % CASO pixrgb-d
    pixrgb(_,_,_,_,_,_,Pixel), getD(Pixel,D),
    pixrgb(X0,Y0,255,255,255,D,PixelBlanco).
% ------------------------------------------------------------------------------ %
% Requerimiento 18:
/*
Dominio:
I: imagen comprimida
I2: imagen descomprimida
- Meta: imageDecompress, descomprimir una imagen (comprimida).
- Predicados:
imageDecompress(I,I2).
recuperarPixs(Pixeles,I,A,PixelesDescomp).
    - Pixeles: pixeles de la imagen comprimida
    del formato <-1, Comprimidos, PixelesNoComprimidos>
	Formato Comprimidos: <Pos_Comp, D_Comp>
	Pos_Comp: posiciones de los pixeles comprimidos
        D_Comp: profundidad de los pixeles comprimidos
    - I: iterador de posición (inicia en 0)
    - PixelesDescomp: información pixeles comprimidos y no comprimidos
    unidos en una nueva lista de pixeles
- Aridad: 2
- Tipo de predicado: regla, otras operaciones
- Tipo de recursión: natural, ya que mientras se va descomprimiendo, la
cola de la lista de los pixeles recuperados está en espera hasta llegar
al caso base
- Estrategia: trabajar con solo los pixeles y luego
construir con aquellos la imagen
*/

imageDecompress(I,I2):-
    % para descomprimir la imagen debe estar comprimida
    imageIsCompressed(I),
    % Obtengo la información de la imagen
    getPixeles(I,Pixeles), getAncho(I,A), getLargo(I,L),
    % Descomprimo los pixeles
    recuperarPixs(Pixeles,0,A,PixelesDescomp),
    % Creo la nueva imagen con los pixeles descomprimidos
    image(A,L,PixelesDescomp,I2), !.
% ---------------
% - Dominio: Pixeles formato Comprimido, I: contador de posiciones
%            (iniciado en 0), A: ancho de la imagen,
%            PixelesDescomp: pixeles descomprimidos
% - Goals: recuperarPixs, para restaurar los pixeles comprimidos
%          y dejarlos como antes de ser comprimidos
% - Aridad: 4
% - Tipo de predicado: regla, otras operaciones
% - Tipo de recursión: natural
recuperarPixs([_,_,[],[]],_,_,[]):- !.
  % caso base: cuando ya se recorrieron todos los pixeles comprimidos,
  % conservados y las posiciones de la lista de posiciones
recuperarPixs([_,C,[[I,D]|RestComp],Conserv],I,A,[Descomp|RestRecuperados]):-
    % - Caso donde contador I coincide con la primera posicion de comprimidos
    % En este caso se descomprime el primer pixel comprimido y se
    % agrega a los recuperados
    descomprime([I,D],C,A,Descomp), Isgte is I + 1,
    recuperarPixs([_,C,RestComp,Conserv],Isgte,A,RestRecuperados).
recuperarPixs([_,C,Comprimidos,[Conserv1|RestConserv]], I, A,[Conserv1|RestRecu]):-
    % - Caso donde el contador no coincide con la posicion de comprimidos
    % En este caso se agrega el primer pixel conservado a
    % los pixeles recuperados
    Isgte is I + 1,
    recuperarPixs([_,C,Comprimidos,RestConserv], Isgte, A, RestRecu).
% ---------------
% - Dominio: [Pos,D]: Información pixel comprimido (posición, profundidad),
%            C: color comprimido, A: ancho de la imagen,
%            Descomp: Pixel descomprimido
% - Goals: descomprimir un pixel a través de una información reducida:
%          posición y profundidad
% - Aridad: 4
% - Tipo de predicado: regla, otras operaciones
% Para recuperar X e Y se tiene de patrón que X es la división
% entera entre la posición y el ancho de la imagen, mientras que Y
% es el resto.
descomprime([Pos,D], C, A, Descomp):-
    string(C), % caso pixhex
    X is Pos // A, Y is Pos mod A,
    pixhex(X,Y,C,D,Descomp).
descomprime([Pos,D], C, A, Descomp):-
    integer(C), % caso pixbit o pixhex
    X is Pos // A, Y is Pos mod A,
    pixbit(X,Y,C,D,Descomp).
descomprime([Pos,D],[R,G,B],A,Descomp):-
    X is Pos // A, Y is Pos mod A, % Caso pixrgb
    pixrgb(X,Y,R,G,B,D,Descomp).

% ------------------------------------------------------------------------------ %







































