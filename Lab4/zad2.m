clc; close all; clearvars;

rice = imread('rice.png');
katalog = imread('katalog.bmp');
[Xrice, Yrice] = size(rice);
[Xkatalog, Ykatalog] = size(katalog);
riceBW = localBinar(rice, 10, Xrice, Yrice);
katalogBW = localBinar(katalog, 5, Xkatalog, Ykatalog);

figure(1);
subplot(2,2,1);
imshow(rice);
subplot(2,2,2);
imshow(riceBW);
subplot(2,2,3);
imshow(katalog);
subplot(2,2,4);
imshow(katalogBW);


%% Savouli
riceBW_Sav = localBinarSav(rice, 10, Xrice, Yrice, -0.15, 128);
katalogBW_Sav = localBinarSav(katalog, 10, Xkatalog, Ykatalog, 0.15, 128);

figure(2);
subplot(2,2,1);
imshow(rice);
subplot(2,2,2);
imshow(riceBW_Sav);
subplot(2,2,3);
imshow(katalog);
subplot(2,2,4);
imshow(katalogBW_Sav);


%% functions

function ImgBW = localBinar(Img, W2, X, Y)
    ImgBW = Img;
    for i = 1:X
        for j = 1:Y
            if(Img(i,j) > meanLT(i,j,W2,Img,X,Y))
                ImgBW(i,j) = 255;
            else
                ImgBW(i,j) = 0;
            end
        end
    end
end


function ImgBW = localBinarSav(Img, W2, X, Y, k, R)
    ImgBW = Img;
    for i = 1:X
        for j = 1:Y
            m = meanLT(i,j,W2,Img,X,Y);
            stddev = stddevLT(i,j,W2,Img,m,X,Y);
            T = m * (1 + k*(stddev/R - 1));
            if(Img(i,j) > T)
                ImgBW(i,j) = 255;
            else
                ImgBW(i,j) = 0;
            end
        end
    end
end
