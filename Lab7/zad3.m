close all; clearvars; clc;

ferrari = imread('ferrari.bmp');
se_sq = strel('square', 3);
ferrari_er = imerode(ferrari, se_sq);
ferrari_di = imdilate(ferrari, se_sq);
ferrari_diff = ferrari_di - ferrari_er;

figure();
subplot(2,2,1);
imshow(ferrari);
title('original');
subplot(2,2,2);
imshow(ferrari_er);
title('erode');
subplot(2,2,3);
imshow(ferrari_di);
title('dilate');
subplot(2,2,4);
imshow(ferrari_diff);
title('diffrence');

ferrari_op = imopen(ferrari, se_sq);
ferrari_cl = imclose(ferrari, se_sq);
figure();
subplot(3,1,1);
imshow(ferrari);
title('original');
subplot(3,1,2);
imshow(ferrari_op);
title('open');
subplot(3,1,3);
imshow(ferrari_cl);
title('close');

ferrari_top = imtophat(ferrari, se_sq);
ferrari_bottom = imbothat(ferrari, se_sq);
figure();
subplot(3,1,1);
imshow(ferrari);
title('original');
subplot(3,1,2);
imshow(ferrari_top);
title('top-hat');
subplot(3,1,3);
imshow(ferrari_bottom);
title('bottom-hat');

rice = imread('rice.png');
se_disk = strel('disk', 10);
rice_top = imtophat(rice, se_disk);
figure();
subplot(1,2,1);
imshow(rice);
subplot(1,2,2);
imshow(rice_top);



