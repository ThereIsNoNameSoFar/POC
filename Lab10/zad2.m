close all; clearvars; clc;

ccl2 = imread('ccl2.png');

image = ccl2;

figure;
imshow(image,[]);

figure;
img_bw_4 = bwlabel(image, 4);
imshow(label2rgb(img_bw_4));

figure;
img_bw_8 = bwlabel(image, 8);
imshow(label2rgb(img_bw_8));