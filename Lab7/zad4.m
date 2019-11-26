close all; clearvars; clc;

calc = imread('calculator.bmp');
SE1 = ones(1,71);
calc_er = imerode(calc, SE1);
calc_rec = imreconstruct(calc_er, calc);
calc_op = imopen(calc, SE1);

figure();
subplot(1,3,1);
imshow(calc);
title('original');
subplot(1,3,2);
imshow(calc_rec);
title('reconstruct');
subplot(1,3,3);
imshow(calc_op);
title('open');

calc_diff = calc - calc_rec;
calc_top = imtophat(calc,SE1);
figure();
subplot(1,3,1);
imshow(calc);
title('original');
subplot(1,3,2);
imshow(calc_diff);
title('reconstruction diff');
subplot(1,3,3);
imshow(calc_top);
title('top-hat');

SE2 = ones(1,11);
calc_er2 = imerode(calc_diff, SE2);
calc_rec2 = imreconstruct(calc_er2, calc_diff);
figure();
imshow(calc_rec2);

SE3 = ones(1,21);
calc_di3 = imdilate(calc_rec2, SE3);
calc_rec3 = imreconstruct(min(calc_di3, calc_diff), calc_diff);
figure();
imshow(calc_rec3);



