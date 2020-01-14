clearvars; close all; clc;

zloty = rgb2gray(imread('100zloty.jpg'));

%% Bit slicing

figure(1);
subplot(3, 3, 1);
imshow(zloty);
for I = 0:7
    zloty_slice = boolean(bitand(zloty, bitshift(1, I)));
    subplot(3, 3, I+2);
    imshow(zloty_slice);
end

%% Putting it back together

figure(2);
subplot(3, 3, 1);
imshow(zloty);
for I = 0:7
    mask = 0;
    for J = 0:I
        mask = bitor(mask, bitshift(1, 7-J));
    end
    subplot(3, 3, I+2);
    imshow(bitand(zloty, mask));
end