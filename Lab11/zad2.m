close all; clearvars; clc;

lena = imread('lena.bmp');

show_fourier(lena);

im = double(lena);
[f1, f2] = freqspace(512, 'meshgrid');
Hd = ones(512);
r = sqrt(f1.^2 + f2.^2);
Hd(r>0.1) = 0;

fourier_filter(im, Hd);

h = fwind1(Hd, hanning(21));
[H f1 f2] = freqz2(h, 512, 512);
fourier_filter(im, H);

G_mask = fspecial('gaussian',512,1);
G_mask = mat2gray(G_mask);

fourier_filter(im, G_mask);


