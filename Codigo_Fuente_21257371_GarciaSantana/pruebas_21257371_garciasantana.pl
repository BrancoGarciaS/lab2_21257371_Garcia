:- use_module(requerimientos_funcionales_21257371_garciasantana).
:- use_module(tdapixeles_21257371_garciasantana).
:- use_module(tdapixhex_21257371_garciasantana).
:- use_module(tdapixrgb_21257371_garciasantana).
:- use_module(tdapixbit_21257371_garciasantana).
:- use_module(tdaimage_21257371_garciasantana).

% SCRIPT DE PRUEBAS
/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SCRIPT DE PRUEBAS (PROPIO)
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
% TDA image: constructor
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1).

pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2).

pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3).
% -------
% Requerimiento 3: imageIsBitmap
% Caso 1: debería retornar true, o sea la estructura de la imagen
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageIsBitmap(I1).

% Caso 2: las siguientes retornan false
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageIsBitmap(I2).

pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3), imageIsBitmap(I3).
% -------
% Requerimiento 4: imageIsPixmap
% Caso 1: Debe retornar true, o sea la estructura de la imagen
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageIsPixmap(I2).

% Caso 2: Debe retornar false
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageIsPixmap(I1).

pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3), imageIsPixmap(I3).
% -------
% imageIsHexmap
% Debe retorna true, o sea la estructura de la imagen
pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3), imageIsHexmap(I3).

% Debe retorna false
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageIsHexmap(I1).

pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageIsHexmap(I2).


% -------
% imageIsCompressed: en los siguientes casos retorna false
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageIsCompressed(I1).

pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageIsCompressed(I2).

pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3), imageIsCompressed(I3).
% -------
% imageFlipH, imageFlipV:

% En el caso de la imagen 1, la imagen invertida horizontalmente es
% igual a la original
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageFlipH(I1,I1_h), imageFlipV(I1,I1_v).

% En el caso de la imagen 2, la imagen invertida horizontalmente es
% igual a la original
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageFlipH(I2,I2_H), imageFlipV(I2,I2_V).

% En el caso de la imagen hexadecimal, la imagen I3_V2 que es la inversión
% vertical de la imagen invertida verticalmente (I3_V) de la imagen original
% (I3), debe ser igual a la imagen original (I3)
pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3), imageFlipH(I3,I3_H),
imageFlipV(I3,I3_V), imageFlipV(I3_V,I3_V2).
% -------
% imageCrop
% Queda como una imagen de 2x2
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageCrop(I1, 0, 1, 1, 2, I1crop).
% Queda como una imagen de 1x2
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageCrop(I2, 0, 1, 1, 1,I2crop).
% Queda como una imagen de 2x3
pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3),
imageCrop(I3, 0, 0, 2, 1, I3crop).
% -------
% imageRGBToHex
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageRGBToHex(I2, I2_hex).

% En los siguientes casos retorna falso, al entrar al dominio imagenes que no
% son tipo pixmap
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageRGBToHex(I1, I1_hex).

pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3), imageRGBToHex(I3, I3_hex).
% -------
% imageToHistogram
% En la imagen 1, los dos bits están repetidos 3 veces
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageToHistogram(I1, HistogramI1).

% Como en la imagen hay 4 colores, en el histograma deberían aparecer solo esos
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageToHistogram(I2, HistogramI2).

% En la imagen 3, solo un color (#3B3838) se repite 2 veces, el resto 1 vez
pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3),
imageToHistogram(I3, HistogramI3).
% -------
% imageRotate90
% La imagen 1 pasa a ser de 2x3
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageRotate90(I1, I1_rot90).

% La imagen 2 pasa a ser de 2x3
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageRotate90(I2, I2_rot90).

% La imagen 3 pasa a ser de
pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3),
imageRotate90(I3, I3_rot90).
% -------
% imageCompress
% A continuación debería retornarse la imagen comprimida sin problema
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageCompress(I1, I1_comp),
imageIsCompressed(I1_comp).

pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageCompress(I2, I2_comp),
imageIsCompressed(I2_comp).

pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3),
imageCompress(I3, I3_comp), imageIsCompressed(I3_comp).
% -------
% imageChangePixel
% La imagen 1 pasa a tener 4 pixeles con color bit 0
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), pixbit( 0, 2, 0, 80, P3_new),
imageChangePixel(I1, P3_new, I1_new).

% La imagen 2 pasa a tener un amarillo en la coordenada x = 0, y = 1
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), pixrgb( 0, 1, 255, 255, 0, 35, P2_new),
imageChangePixel(I2,P2_new,I2_new).

% La imagen 3 pasa a tener el color "#C643EF" en el centro
pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3),
pixhex( 1, 1, "#C643EF", 10, P5_new), imageChangePixel(I3,P5_new,I3_new).
% -------
% imageInvertColorRGB
% Si invertimos el pixel nuevo amarillo 255 255 0, queda azul y si se
% se le ingresa a la imagen, queda una imagen con un azul en x = 0, y = 1
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), pixrgb( 0, 1, 255, 255, 0, 35, P2_new),
imageInvertColorRGB( P2_new, P2_new_invert),
imageChangePixel(I2,P2_new_invert,I2_newA).

% Si invertimos un pixel, luego invertimos el pixel invertido, para despues
% cambiarlo en la imagen, se obtendrá la misma imagen original
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageInvertColorRGB( P5, P5_invert),
imageInvertColorRGB( P5_invert, P5_invert_invert),
imageChangePixel(I2,P5_invert_invert,I2_newB).

% En caso de colocar como dominio un pixel que no sea pixrgb, retornará false
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageInvertColorRGB( P3, P3_invert).
% -------
% imageToString
% La imagen 1 pasa a tener 4 pixeles con color bit 0
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageToString(I1, Str1), write(Str1).

% La imagen 2 pasa a tener un amarillo en la coordenada x = 0, y = 1
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageToString(I2, Str2), write(Str2).

% La imagen 3 pasa a tener el color "#C643EF" en el centro
pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3),
imageToString(I3, Str3), write(Str3).
% -------
% imageDepthLayers
% L1 : contiene 2 imagenes, ya que solo hay 2 profundidades distintas
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageDepthLayers( I1, L1).
% L2: contiene 2 imagenes, ya que solo hay 2 profundidades diferentes
% y en la primera se encuentra solo 2 colores, el blanco y [251,123,113]
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageDepthLayers( I2, L2).
% L3: contiene 3 imagenes, pues hay 3 profundidades distintas
% y en la tercera se encuentra un solo pixel que no es blanco "#3B3838"
pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3), imageDepthLayers(I3,L3).
% -------
% imageDecompress
% I1_descomp debe ser igual a I1
pixbit( 0, 0, 1, 15, P1), pixbit( 0, 1, 0, 75, P2), pixbit( 0, 2, 1, 15, P3),
pixbit( 1, 0, 0, 15, P4), pixbit( 1, 1, 1, 75, P5), pixbit( 1, 2, 0, 15, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I1), imageCompress(I1, I1_comp),
imageDecompress(I1_comp, I1_descomp).
% I2_descomp debe ser igual a I2
pixrgb( 0, 0, 251, 123, 113, 35, P1), pixrgb( 0, 1, 245, 234, 89, 80, P2),
pixrgb( 0, 2, 251, 123, 113, 35, P3), pixrgb( 1, 0, 129, 235, 197, 80, P4),
pixrgb( 1, 1, 219, 249, 238, 80, P5), pixrgb( 1, 2, 129, 235, 197, 80, P6),
image( 3, 2, [P1, P2, P3, P4, P5, P6], I2), imageCompress(I2, I2_comp),
imageDecompress(I2_comp, I2_descomp).
% I3_descomp debe ser igual a I3
pixhex( 0, 0, "#7DC8D5", 10, P1), pixhex( 0, 1, "#0070C0", 20, P2),
pixhex( 0, 2, "#3B3838", 30, P3), pixhex( 1, 0, "#E7F771", 10, P4),
pixhex( 1, 1, "#F4B183", 10, P5), pixhex( 1, 2, "#F6B048", 20, P6),
pixhex( 2, 0, "#DEEBF7", 10, P7), pixhex( 2, 1, "#3B3838", 10, P8),
pixhex( 2, 2, "#C643EF", 10, P9),
image( 3, 3, [P1, P2, P3, P4, P5, P6, P7, P8, P9], I3),
imageCompress(I3, I3_comp), imageDecompress(I3_comp, I3_descomp).

*/



