clc; close all; clearvars;

%% coins

coins = imread('coins.png');

figure(1);
subplot(2,1,1);
imshow(coins);
subplot(2,1,2);
imhist(coins);

figure(2);
imshow(im2bw(coins, (80/255)));

%% figura 1

figure(3);
figura = imread('figura.png');
subplot(2,1,1);
imshow(figura);
subplot(2,1,2);
imhist(figura);

%% figura 2

figure(4);
figura2 = imread('figura2.png');
subplot(2,1,1);
imshow(figura2);
subplot(2,1,2);
imhist(figura2);


%% figura 3

figure(5);
figura3 = imread('figura3.png');
subplot(2,1,1);
imshow(figura3);
subplot(2,1,2);
imhist(figura3);


%% figura 4

figure(6);
figura4 = imread('figura4.png');
subplot(2,1,1);
imshow(figura4);
subplot(2,1,2);
imhist(figura4);

%% otsu

figure(7);
threshOtsu = graythresh(coins);
imshow(im2bw(coins, threshOtsu));

%% autom
rice = imread('rice.png');
tekst = imread('tekst.bmp');
obiekty = imread('obiekty.bmp');
katalog = imread('katalog.bmp');
testBinarization(coins, 80/255);
testBinarization(rice, 120/255);
testBinarization(tekst, 180/255);
testBinarization(obiekty, 170/255);
testBinarization(katalog, 150/255);


function testBinarization(Image, threshManual)
    figure();
    subplot(3,2,1);
    imshow(Image);
    title("Original image");
    subplot(3,2,2);
    imhist(Image);
    title("Histogram");
    subplot(3,2,3);
    imshow(im2bw(Image, threshManual));
    title("Manual threshold : " + num2str(threshManual));
    subplot(3,2,4);
    threshOtsu = graythresh(Image);
    imshow(im2bw(Image, threshOtsu));
    title("Otsu threshold : " + num2str(threshOtsu));
    subplot(3,2,5);
    threshKitt = clusterKittler(Image) / 255;
    imshow(im2bw(Image, threshKitt));
    title("Kittler threshold : " + num2str(threshKitt));
    subplot(3,2,6);
    threshYen = entropyYen(Image) / 255;
    imshow(im2bw(Image, threshYen));
    title("Yen threshold : " + num2str(threshYen));
end




