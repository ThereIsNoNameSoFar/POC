% Lab2 Zadanie domowe
% Michal Warzecha
clear vars; close all; clc;

%% Load and display images
parrot_img = imread('parrot.bmp');

resized_parrot = BicubicInterpolation(parrot_img, 3, 3);

figure(1);
imshow(parrot_img);
figure(2);
imshow(resized_parrot);


%% BicubicInterpolation methods
function correctedPoint = CorrectPoint(point, maxY, maxX)
    correctedPoint(1) = min(point(1), maxY);
    correctedPoint(2) = min(point(2), maxX);
    correctedPoint(1) = max(correctedPoint(1), 0);
    correctedPoint(2) = max(correctedPoint(2), 0);
end

function [A, B, C, D] = GetNearPoints(Y, X, yStep, xStep)
    A = floor([(Y*yStep), (X*xStep)]);
    B = A + [0, 1];
    C = A + [1, 1];
    D = A + [1, 0];
end

function col = GetColorAtPoint(Point, img)
    [maxY, maxX] = size(img);
    Point = CorrectPoint(Point, maxY - 1, maxX - 1);
    col = img(Point(1) + 1, Point(2) + 1);
end

function f_x = xDeriv(Point, img)
    leftPixel = GetColorAtPoint([Point(1) Point(2) - 1], img);
    rightPixel = GetColorAtPoint([Point(1) Point(2) + 1], img);
    f_x = (rightPixel - leftPixel)/2;
end

function f_y = yDeriv(Point, img)
    topPixel = GetColorAtPoint([Point(1) - 1 Point(2)], img);
    bottomPixel = GetColorAtPoint([Point(1) + 1 Point(2)], img);
    f_y = (bottomPixel - topPixel)/2;
end

function f_xy = xyDeriv(Point, img)
    bottomRightPixel = GetColorAtPoint([Point(1) + 1 Point(2) + 1], img);
    leftPixel = GetColorAtPoint([Point(1) Point(2) - 1], img);
    topPixel = GetColorAtPoint([Point(1) - 1 Point(2)], img);
    currentPixel = GetColorAtPoint(Point, img);
    f_xy = (bottomRightPixel - leftPixel - topPixel + currentPixel)/4;
end

function col = GetColorFromAVector(y_pos, x_pos, a)
    col = 0;
    for J = 0:3
        for I = 0:3
            col = col + a(J*4 + I + 1) * y_pos^J * x_pos^I;
        end
    end
end

function resized_img = BicubicInterpolation(img, scaleY, scaleX)
    load('a1.mat', '-mat');
    [origSizeY, origSizeX] = size(img);
    newSizeY = scaleY * origSizeY;
    newSizeX = scaleX * origSizeX;
    resized_img = uint8(zeros(newSizeY, newSizeX));
    
    yStep = origSizeY/newSizeY;
    xStep = origSizeX/newSizeX;
    
    for Y = 0:(newSizeY-1)
        j = Y*yStep;
        for X = 0:(newSizeX-1)
            i = X*xStep;
            A = floor([j i]);
            B = A + [0 1];
            C = A + [1 1];
            D = A + [1 0];
            %[A, B, C, D] = GetNearPoints(Y, X, yStep, xStep);
            f_A = GetColorAtPoint(A, img);
            f_B = GetColorAtPoint(B, img);
            f_C = GetColorAtPoint(C, img);
            f_D = GetColorAtPoint(D, img);
            x = [f_A;             f_B;             f_D;             f_C;
                 xDeriv(A, img);  xDeriv(B, img);  xDeriv(D, img);  xDeriv(C, img);
                 yDeriv(A, img);  yDeriv(B, img);  yDeriv(D, img);  yDeriv(C, img);
                 xyDeriv(A, img); xyDeriv(B, img); xyDeriv(D, img); xyDeriv(C, img)];
            a = transpose(double(A1)*double(x));
            y_pos = Y*yStep - A(1);
            x_pos = X*xStep - A(2);
            resized_img(Y + 1, X + 1) = GetColorFromAVector(y_pos, x_pos, a);
        end
    end
end