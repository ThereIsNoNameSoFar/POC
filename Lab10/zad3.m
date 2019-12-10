close all; clearvars; clc;

shapes = imread('shapes.png');

figure;
imshow(shapes,[]);

shapes_ind = bwlabel(shapes, 8);

wsp = obliczWspolczynniki(shapes_ind);

r = regionprops(logical(shapes_ind), 'Centroid');
for i = 1:length(r)
    text(r(i).Centroid(1),r(i).Centroid(2), ['\color{magenta}', num2str(i)]);
end

[YY, XX] = size(shapes);
for Y = 1:YY
    for X = 1:XX
        pixel = shapes_ind(Y,X);
        if (pixel ~= 0 && wsp(pixel, 2) > 0.6)
            shapes_ind(Y,X) = 0;
        end
    end
end

figure;
imshow(shapes_ind,[]);
