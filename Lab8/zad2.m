close all; clearvars; clc;

img = zeros([11 11]);
img(3,5) = 1;
[H, theta, rho] = hough(img, 'RhoResolution', 0.1, 'ThetaResolution', 0.5);

figure(1);
subplot(1,2,1);
imshow(H, []);
subplot(1,2,2);
img(7,2) = 1;
[H, theta, rho] = hough(img, 'RhoResolution', 0.1, 'ThetaResolution', 0.5);
imshow(H, []);

figure(2);
subplot(1,2,1);
img(2,1) = 1;
img(10,3) = 1;
imshow(img, []);
subplot(1,2,2);
[H, theta, rho] = hough(img, 'RhoResolution', 0.1, 'ThetaResolution', 0.5);
imshow(H, []);

p = [145 134];
q = rho(p(2));
th = theta(p(1));
x = 0:0.1:10;
y= (q - x*cosd(th))/sind(th);

figure(3);
imshow(img, []);
hold on;
axis on; axis normal;
plot(x+1,y+1);
hold off;



