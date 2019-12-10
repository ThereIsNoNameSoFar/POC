close all; clearvars; clc;

image = imread('shapesReal.png');


figure;
imshow(image);

figure;
binar = im2bw(image, 0.25);
imshow(binar);

figure;
labeled = bwlabel(binar, 4);

wsp = obliczWspolczynniki(labeled);

imshow(label2rgb(labeled));

r = regionprops(logical(labeled), 'Centroid');
for i = 1:length(r)
    text(r(i).Centroid(1),r(i).Centroid(2), ['\color{magenta}', num2str(i)]);
end

[YY, XX] = size(binar);
for Y = 1:YY
    for X = 1:XX
        pixel = labeled(Y,X);
        if (pixel ~= 0 && wsp(pixel, 2) > 0.6)
            labeled(Y,X) = 0;
        end
    end
end

figure;
imshow(labeled,[]);