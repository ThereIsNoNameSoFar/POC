clc; close all; clearvars;

bart = imread('bart.bmp');

figure(1);
subplot(3,1,1);
imshow(bart);
subplot(3,1,2);
imhist(bart);

lowThresh = 180;
highThresh = 220;

bartBW = bart > lowThresh & bart < highThresh;
bartBW = uint8(bartBW);

subplot(3,1,3);
imshow(bartBW,[]);
