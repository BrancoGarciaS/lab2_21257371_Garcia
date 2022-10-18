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

getColor([_,_,C,_],C).

getD(P,D):-
   pixbit-d(_,_,_,D,P);
   pixhex-d(_,_,_,D,P);
   pixrgb-d(_,_,_,D,P).

% -------------------------------------------------------------------- %
% Otros Operadores de pixel:

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
pixs_estan_ordenados([Pix1|RestPixs],Pos_Correspondiente,A):-
    % Pos_correspondiente se ingresa como 0 y se va a ir incrementando en 1
    % La posición correspondiente (según el orden establecido) de un pixel
    % viene dado por: ancho * x + y, en la lista de pixeles
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
getPixPorPosicion([Pix1|RestPixs],Pos_buscada,A,Pix_buscado,[Pix1|PixsNoBusc]):-
    getX(Pix1,X), getY(Pix1,Y),
    Pos_Pixel is A * X + Y,
    Pos_Pixel =\= Pos_buscada,
    getPixPorPosicion(RestPixs,Pos_buscada,A,Pix_buscado,PixsNoBusc).
getPixPorPosicion([Pix_buscado|RestPixs],Pos_buscada,A,Pix_buscado,RestPixs):-
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
%
image(Ancho, Alto, Pixeles, [Ancho,Alto,Pixs]):-
    integer(Ancho),
    integer(Alto),
    % se ordenan en caso de ingresar pixeles desordenados en X e Y
    % en caso que la imagen no esté comprimida.
    % Si la imagen está comprimida, sus pixeles no se alteran
    ordenarPixs(Pixeles,Ancho,Pixs).

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

% ------------------------------------------------------------------------------ %
imageRGBToHex(I1, I2):-
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
conv_a_hex([X,Y,[R,G,B],D],Pix_hexa):-
    canal_a_hex(R,R_hex),
    canal_a_hex(G,G_hex),
    canal_a_hex(B,B_hex),
    string_concat("#",R_hex,Parte1),
    string_concat(G_hex,B_hex,Parte2),
    string_concat(Parte1,Parte2,Str_hexa),
    pixhex-d(X,Y,Str_hexa,D,Pix_hexa).

% Clausulas para convertir a Hexadecimal todos los pixeles RGB:
pixsToHex([],[]). % HECHO - caso base: si se recorren todos los pixeles,
% convertiendose la lista de salida queda vacía
pixsToHex([Pix1|Rest], [PixsHex|RestHex]):-
    % REGLA - para convertir a hexadecimal una lista de pixeles.
    % Se convierte a hexadecimal el pixel cabecera 'guardandose'
    % en la cabeza de la lista de pixeles hexadecimales
    conv_a_hex(Pix1, PixsHex),
    % se vuelve a realizar el mismo procedimiento con el resto
    % de pixeles, hasta llegar al hecho caso base.
    pixsToHex(Rest, RestHex).

% ------------------------------------------------------------------------------ %

imageToHistogram(I,Histograma):-
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
contarcolores([Pix1|Rest],[[Color,Repeticion]|Cola]):-
    % Se toma en cuenta el color del pixel cabecera almacenando
    % esa información en la lista (salida) de conteo de colores
    getColor(Pix1,Color),
    % Se cuenta el color especifico del pixel cabecera
    % Desde la llamada se obtiene Repeticion el cual es un dato
    % que tambien se deja en la lista de conteo de colores
    mismocolor([Pix1|Rest],Color,Repeticion,PixsRest),
    % Se vuelve a realizar la llamada recursiva, pero con los
    % pixeles restantes que no tienen el color contado
    contarcolores(PixsRest,Cola).

% ------------------------------------------------------------------------------ %

% ------------------------------------------------------------------------------ %
/*
Dominio:
I1: imagen a operar
I2: imagen volteada verticalmente

Predicados:
imageRotate90(I1,I2).
rotXY([X,Y,C,D], Largo, [X,Yrot,C,D]). Yrot: Y rotado 90 grados a la derecha
rot90(P,L,Pixs_Rot). P: pixs, L: largo, Pixs_V: pixs rotados 90° a la derecha

Metas: Principales: imageRotate90
*/
imageRotate90(I1,I2):-
    getAncho(I1,A),
    getLargo(I1,L),
    getPixeles(I1,P),
    rot90(P,L,Pixs_Rot),
    % Al rotar 90 grados las dimensiones de la imagen
    % se invierten (Ancho y Alto)
    image(L,A,Pixs_Rot,I2).

% Clausula para rotar 90° a la derecha un pixel
rotXY([X,Y,C,D], Largo, [Y,Yrot,C,D]):-
    % (x_original, y _original) -> (y_original, largo - 1 - x_original)
    Yrot is Largo - 1 - X.

% Clausulas para rotar 90° todos los pixeles de una lista
rot90([],_,[]). % HECHO - caso base: cuando se recorren todos los pixeles
% rotandose cada uno 90 grados.
rot90([Pix1|Rest], Largo, [Pix1_2|Rest2]):-
    % Se rota el pixel cabecera y se incluye en la lista de pixeles rotados
    rotXY(Pix1, Largo, Pix1_2),
    % Se realiza el mismo procedimiento con el resto de pixeles
    rot90(Rest, Largo, Rest2).

% ------------------------------------------------------------------------------ %
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
comprimir([[X,Y,C,D]|RestPixs], C, Pos, Conserv, [Pos|RestPos],[[X,Y,C,D]|RestComp]):-
    PosSgte is Pos + 1,
    comprimir(RestPixs, C, PosSgte, Conserv, RestPos, RestComp).
comprimir([Pix1|RestPixs],C,Pos,[Pix1|RestConserv],PosComp,Comprimidos):-
    PosSgte is Pos + 1,
    comprimir(RestPixs,C,PosSgte,RestConserv,PosComp,Comprimidos).
% ------------------------------------------------------------------------------ %
/*
Dominio:
I1: imagen a operar
NewPixel: pixel a cambiar
I2: imagen con el pixel cambiado

Predicados:
imageChangePixel(I,NewPixel,I2).
reemplazarPix(Pixeles, NewPixel, NewPixels).
	NewPixels: pixeles con el pixel nuevo incluido

Metas: Principales: imageChangePixel
*/
imageChangePixel(I,NewPixel,I2):-
    getAncho(I,A),
    getLargo(I,L),
    getPixeles(I,Pixeles),
    reemplazarPix(Pixeles, NewPixel, NewPixels),
    image(A,L,NewPixels, I2).

% Clausulas para reemplazar el pixel nuevo en la lista de pixeles
% Dominio: pixeles originales X pixel nuevo X pixeles modificados
reemplazarPix([],_,[]). % Hecho - Caso base: que la lista de pixeles
% se recorren completamente
% Caso donde el pixel a cambiar cooincide con las coordenadas X Y (atributo
% único de un pixel) con el pixel a reemplazar
reemplazarPix([[X,Y,_,_]|RestPixs], [X,Y,C,D] , [[X,Y,C,D]|RestPixsNew]):-
    reemplazarPix(RestPixs, [X,Y,C,D], RestPixsNew).
% Caso donde el pixel a cambiar no cooincide con las coordenadas del pixel
% a reemplazar, se colocan los pixeles originales
reemplazarPix([Pix1|RestPixs], NewPix , [Pix1|RestPixsNew]):-
    reemplazarPix(RestPixs, NewPix, RestPixsNew).
% ------------------------------------------------------------------------------ %
/*
Dominio:
Pixel: pixrgb-d a operar
Pix_inv: pixrgb-d con sus canales RGB volteados

Predicados:
invertColorRGB(Pixel,Pix_inv)

Metas: Principales: invertColorRGB
*/
invertColorRGB(Pixel,Pix_inv):-
    % Obtengo la información del pixel original
    getX(Pixel,X),
    getY(Pixel,Y),
    getColor(Pixel,[R,G,B]),
    getD(Pixel,D),
    % Para invertir cada canal resto 255 con cada valor
    R_inv is 255 - R,
    G_inv is 255 - G,
    B_inv is 255 - B,
    % Construyo el nuevo pixel con los canales invertidos
    pixrgb-d(X,Y,R_inv,G_inv,B_inv,D,Pix_inv).
% ------------------------------------------------------------------------------ %
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
    number_string(R, Rstr),
    number_string(G, Gstr),
    number_string(B, Bstr),
    % Uno cada canal con un espacio (para que en la representación
    % estén distanciados entre si)
    string_concat(Rstr," ", R_str),
    string_concat(Gstr, " ", G_str),
    string_concat(Bstr, " ", B_str),
    % Uno el valor Red con Green en un string
    string_concat(R_str,G_str,R_G_Str),
    % Uno el valor RG con Blue en el string de argumento "Str" (salida)
    string_concat(R_G_Str, B_str, Str).
% ------------------------------------------------------------------------------ %



















































