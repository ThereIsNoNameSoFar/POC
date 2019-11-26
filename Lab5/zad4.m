close all; clearvars; clc;

kw = imread('kw.bmp');
load maskiPP;

figure(1);
subplot(1,3,1);
imshow(kw);
subplot(1,3,2);
imshow(abs(conv2(kw, R1,'same')));
subplot(1,3,3);
imshow(uint8(conv2(kw, R1,'same') + 128));

figure(2);
subplot(1,3,1);
imshow(kw);
subplot(1,3,2);
imshow(abs(conv2(kw, R2,'same')));
subplot(1,3,3);
imshow(uint8(conv2(kw, R2,'same') + 128));

figure(3);
subplot(1,3,1);
imshow(kw);
subplot(1,3,2);
imshow(abs(conv2(kw, P1,'same')));
subplot(1,3,3);
imshow(uint8(conv2(kw, P1,'same') + 128));

figure(4);
subplot(1,3,1);
imshow(kw);
subplot(1,3,2);
imshow(abs(conv2(kw, P2,'same')));
subplot(1,3,3);
imshow(uint8(conv2(kw, P2,'same') + 128));

figure(5);
subplot(1,3,1);
imshow(kw);
subplot(1,3,2);
imshow(abs(conv2(kw, S1,'same')));
subplot(1,3,3);
imshow(uint8(conv2(kw, S1,'same') + 128));

figure(6);
subplot(1,3,1);
imshow(kw);
subplot(1,3,2);
imshow(abs(conv2(kw, S2,'same')));
subplot(1,3,3);
imshow(uint8(conv2(kw, S2,'same') + 128));


kombinowany = sqrt(conv2(kw, S1, 'same').^2 + conv2(kw, S2, 'same').^2);
kombinowanyAbs = abs(conv2(kw, S1, 'same')) + abs(conv2(kw, S2, 'same'));

figure(2);
subplot(1,3,1);
imshow(kw);
subplot(1,3,2);
imshow(kombinowany);
subplot(1,3,3);
imshow(kombinowanyAbs);

