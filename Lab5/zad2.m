close all; clearvars; clc;

lenaSzum = imread('lenaSzum.bmp');
filtLena = medfilt2(lenaSzum);
diffImg = imabsdiff(filtLena, lenaSzum);

filter = fspecial('average',3);
convLena = uint8(conv2(lenaSzum, filter,'same'));
diffImg2 = imabsdiff(convLena, lenaSzum);

figure(1);
subplot(2,3,1);
imshow(lenaSzum,[]);
subplot(2,3,2);
imshow(filtLena,[]);
subplot(2,3,3);
imshow(diffImg,[]);
subplot(2,3,4);
imshow(lenaSzum,[]);
subplot(2,3,5);
imshow(convLena,[]);
subplot(2,3,6);
imshow(diffImg2,[]);

figure(2);
lenaMultiMed = lenaSzum;
for I = 1:10
    lenaMultiMed = medfilt2(lenaMultiMed, [5 5]);
end
imshow(lenaMultiMed);

