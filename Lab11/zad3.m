close all; clearvars; clc;

img = imread('lunar.bmp');

show_fourier(img);

th = 10;
imgfft2 = fft2(img);
imgfft2shifted = fftshift(imgfft2);
fft2abs = log10(abs(imgfft2shifted)+1);
imgfft2(fft2abs > th) = 0;
res = uint8(ifft2(ifftshift(imgfft2)));

figure;
imshow(res, []);