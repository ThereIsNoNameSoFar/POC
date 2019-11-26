close all; clearvars; clc;

moon = imread('moon.tif');

M = [0 1 0; 1 -4 1; 0 1 0];
M = M/9;

moonConv = conv2(moon, M,'same');

absMoon = abs(moonConv);
plus128Moon = moonConv + 128;

figure(1);
subplot(1,3,1);
imshow(moon, []);
subplot(1,3,2);
imshow(absMoon, []);
subplot(1,3,3);
imshow(plus128Moon, []);


laplacian = fspecial('laplacian');
figure(2);
subplot(1,3,1);
imshow(moon);
subplot(1,3,2);
moonLaplacian = uint8(conv2(moon, laplacian,'same'));
imshow(moonLaplacian);
subplot(1,3,3);
imshow(moon - moonLaplacian);