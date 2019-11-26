close all; clearvars; clc;

ertka = imread('ertka.bmp');
se_sq = strel('square', 3);
se_diam = strel('diamond', 3);
se_disk = strel('disk', 3);

figure(1);
subplot(2,3,1);
imshow(ertka);
title('Original');
subplot(2,3,2);
imshow(imerode(ertka, se_sq));
title('Square');
subplot(2,3,3);
imshow(imerode(ertka, se_diam));
title('Diamond');
subplot(2,3,4);
imshow(imerode(ertka, se_disk));
title('Disk');

ertka_er = imerode(ertka, se_sq);
ertka_er2 = imerode(ertka_er, se_sq);
ertka_er3 = imerode(ertka_er2, se_sq);
subplot(2,3,5);
imshow(ertka_er2);
title('Square 2 times');
subplot(2,3,6);
imshow(ertka_er3);
title('Square 3 times');

buzka = imread('buzka.bmp');
se_left = [1 0 0; 0 1 0; 0 0 1];
se_right = [0 0 1; 0 1 0; 1 0 0];
buzka_left = imerode(buzka, se_left);
buzka_right = imerode(buzka, se_right);
figure(2);
subplot(1,3,1);
imshow(buzka);
subplot(1,3,2);
imshow(buzka_left);
subplot(1,3,3);
imshow(buzka_right);

wyspa = imread('wyspa.bmp');
kolka = imread('kolka.bmp');
showMorfs(ertka);
showMorfs(wyspa);
showMorfs(kolka);

figure();
ertka_cl = imclose(ertka, se_sq);
ertka_only = imopen(ertka_cl, se_sq);
imshow(ertka_only);

figure();
hom = imread('hom.bmp');
SE1 = [0 1 0; 1 1 1; 0 1 0];
SE2 = [1 0 1; 0 0 0; 1 0 1];
hom_bw = bwhitmiss(hom, SE1, SE2);
subplot(2,1,1);
imshow(hom);
subplot(2,1,2);
imshow(hom_bw);

function showMorfs(Im)
    figure();
    se_sq = strel('square', 3);
    Im_er = imerode(Im, se_sq);
    Im_di = imdilate(Im, se_sq);
    Im_op = imopen(Im, se_sq);
    Im_cl = imclose(Im, se_sq);
    subplot(2,3,1);
    imshow(Im);
    title('Original');
    subplot(2,3,2);
    imshow(Im_er);
    title('Erode');
    subplot(2,3,3);
    imshow(Im_di);
    title('Dilate');
    subplot(2,3,4);
    imshow(Im_op);
    title('Open');
    subplot(2,3,5);
    imshow(Im_cl);
    title('Close');
end