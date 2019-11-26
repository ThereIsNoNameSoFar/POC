close all; clearvars; clc;

jet = imread('jet.bmp');
load maskiPP;

figure(1);
subplot(1,3,1);
imshow(jet);
subplot(1,3,2);
imshow(abs(conv2(jet, R1,'same')));
subplot(1,3,3);
imshow(uint8(conv2(jet, R1,'same') + 128));

figure(2);
subplot(1,3,1);
imshow(jet);
subplot(1,3,2);
imshow(abs(conv2(jet, R2,'same')));
subplot(1,3,3);
imshow(uint8(conv2(jet, R2,'same') + 128));

figure(3);
subplot(1,3,1);
imshow(jet);
subplot(1,3,2);
imshow(abs(conv2(jet, P1,'same')));
subplot(1,3,3);
imshow(uint8(conv2(jet, P1,'same') + 128));

figure(4);
subplot(1,3,1);
imshow(jet);
subplot(1,3,2);
imshow(abs(conv2(jet, P2,'same')));
subplot(1,3,3);
imshow(uint8(conv2(jet, P2,'same') + 128));

figure(5);
subplot(1,3,1);
imshow(jet,[]);
subplot(1,3,2);
imshow(abs(conv2(jet, S1,'same')),[]);
subplot(1,3,3);
imshow(uint8(conv2(jet, S1,'same') + 128),[]);

figure(6);
subplot(1,3,1);
imshow(jet);
subplot(1,3,2);
imshow(abs(conv2(jet, S2,'same')));
subplot(1,3,3);
imshow(uint8(conv2(jet, S2,'same') + 128));


kombinowany = sqrt(conv2(jet, S1, 'same').^2 + conv2(jet, S2, 'same').^2);
kombinowanyAbs = abs(conv2(jet, S1, 'same')) + abs(conv2(jet, S2, 'same'));

figure(2);
subplot(1,3,1);
imshow(jet);
subplot(1,3,2);
imshow(kombinowany);
subplot(1,3,3);
imshow(kombinowanyAbs);

