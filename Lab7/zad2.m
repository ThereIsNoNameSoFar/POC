close all; clearvars; clc;

fingerprint = imread('fingerprint.bmp');
fing_th1 = bwmorph(fingerprint,'thin',1);
fing_th2 = bwmorph(fingerprint,'thin',2);
fing_thInf = bwmorph(fingerprint,'thin',Inf);

figure();
subplot(2,2,1);
imshow(fingerprint);
title('Original');
subplot(2,2,2);
imshow(fing_th1);
title('x1');
subplot(2,2,3);
imshow(fing_th2);
title('x2');
subplot(2,2,4);
imshow(fing_thInf);
title('xInf');

kosc = imread('kosc.bmp');
kosc_skel = bwmorph(kosc,'skel',Inf);
figure();
subplot(1,2,1);
imshow(kosc);
subplot(1,2,2);
imshow(kosc_skel);

figure();
text = imread('text.bmp');
SE = ones(51,1);
text_pion = imopen(text, SE);
text_rec = imreconstruct(imerode(text,SE),text);
text_fill = imfill(text, 'holes');
text_clear = imclearborder(text);
subplot(3,1,1);
imshow(text);
subplot(3,1,2);
imshow(text_pion);
subplot(3,1,3);
imshow(text_rec);

figure();
subplot(3,1,1);
imshow(text);
subplot(3,1,2);
imshow(text_fill);
subplot(3,1,3);
imshow(text_clear);





