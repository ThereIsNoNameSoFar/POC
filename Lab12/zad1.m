close all; clearvars; clc;
load('tablice_kwantyzacji.mat')

lilia = imread('mglawica_kolor.png');
imshow(lilia);


%% Encoding
liliaYUV = rgb2ycbcr(lilia);

Fdct2(:,:,1) = blkproc(liliaYUV(:,:,1), [8 8], @dct2);
Fdct2(:,:,2) = blkproc(liliaYUV(:,:,2), [8 8], @dct2);
Fdct2(:,:,3) = blkproc(liliaYUV(:,:,3), [8 8], @dct2);

c = 5;

Z(:,:,1) = blkproc(Fdct2(:,:,1), [8 8], (@(x) round(x ./ (c*Qy))));
Z(:,:,2) = blkproc(Fdct2(:,:,2), [8 8], (@(x) round(x ./ (c*Qc))));
Z(:,:,3) = blkproc(Fdct2(:,:,3), [8 8], (@(x) round(x ./ (c*Qc))));

%% Decoding

Fidct2(:,:,1) = blkproc(Z(:,:,1), [8 8], (@(x) x .* (c*Qy)));
Fidct2(:,:,2) = blkproc(Z(:,:,2), [8 8], (@(x) x .* (c*Qc)));
Fidct2(:,:,3) = blkproc(Z(:,:,3), [8 8], (@(x) x .* (c*Qc)));

decImgYUV(:,:,1) = blkproc(Fidct2(:,:,1), [8 8], @idct2);
decImgYUV(:,:,2) = blkproc(Fidct2(:,:,2), [8 8], @idct2);
decImgYUV(:,:,3) = blkproc(Fidct2(:,:,3), [8 8], @idct2);

decImgRgb = ycbcr2rgb(uint8(decImgYUV));
figure;
imshow(decImgRgb);


