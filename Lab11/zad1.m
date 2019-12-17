close all; clearvars; clc;

dwieFale = imread('dwieFale.bmp');
kolo = imread('kolo.bmp');
kwadrat = imread('kwadrat.bmp');
kwadrat45 = imread('kwadrat45.bmp');
trojkat = imread('trojkat.bmp');

show_fourier(dwieFale);
show_fourier(kolo);
show_fourier(kwadrat);
show_fourier(kwadrat45);
show_fourier(trojkat);
