close all; clearvars; clc;

lena = imread('lena.bmp');

show_fourier(lena);

im = double(lena);
[f1, f2] = freqspace(512, 'meshgrid');
Hd = ones(512);
%Hd_gorny = ones(512);
%Hd_pasmowy = ones(512);
r = sqrt(f1.^2 + f2.^2);
Hd(r>0.1) = 0;
%Hd_gorny(r<0.1) = 0;
%Hd_pasmowy(r<0.03 | r>0.13) = 0;

fourier_filter(im, Hd);
%fourier_filter(im, Hd_gorny);
%fourier_filter(im, Hd_pasmowy);

h = fwind1(Hd, hanning(21));
[H, f1, f2] = freqz2(h, 512, 512);
fourier_filter(im, H);

G_mask = fspecial('gaussian',512,20);
G_mask = mat2gray(G_mask);

fourier_filter(im, G_mask);


