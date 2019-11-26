close all; clearvars; clc;

plansza = imread('plansza.bmp');
filter = fspecial('average',3);
convPlansza = uint8(conv2(plansza, filter,'same'));
diffImg = imabsdiff(plansza, convPlansza);

figure(1);
subplot(1,3,1);
imshow(plansza,[]);
subplot(1,3,2);
imshow(convPlansza,[]);
subplot(1,3,3);
imshow(diffImg,[]);

figure(2);
f3 = fspecial('average',3);
f5 = fspecial('average',5);
f9 = fspecial('average',9);
f15 = fspecial('average',15);
f35 = fspecial('average',35);
subplot(2,3,1);
imshow(uint8(conv2(plansza, f3,'same')));
subplot(2,3,2);
imshow(uint8(conv2(plansza, f5,'same')));
subplot(2,3,3);
imshow(uint8(conv2(plansza, f9,'same')));
subplot(2,3,4);
imshow(uint8(conv2(plansza, f15,'same')));
subplot(2,3,5);
imshow(uint8(conv2(plansza, f35,'same')));

lena = imread('lena.bmp');
figure(3);
subplot(1,3,1);
imshow(lena);
title('Original');
subplot(1,3,2);
imshow(uint8(conv2(lena, f3,'same')));
title('Avarage');
M = [1 2 1; 2 4 2; 1 2 1];
M = M/sum(sum(M));
subplot(1,3,3);
imshow(uint8(conv2(lena, M,'same')));
title('Custom Matrix');

figure(4);
g0_5 = fspecial('gaussian', 5, 0.5);
g2 = fspecial('gaussian', 5, 2);
g5 = fspecial('gaussian', 5, 5);
subplot(1,3,1);
mesh(g0_5);
subplot(1,3,2);
mesh(g2);
subplot(1,3,3);
mesh(g5);

figure(5);
subplot(1,3,1);
imshow(uint8(conv2(lena, g0_5,'same')));
title('Odchylenie: 0.5');
subplot(1,3,2);
imshow(uint8(conv2(lena, g2,'same')));
title('Odchylenie: 2');
subplot(1,3,3);
imshow(uint8(conv2(lena, g5,'same')));
title('Odchylenie: 5');



