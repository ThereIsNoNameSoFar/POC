close all; clearvars; clc;

dom = imread('dom.png');

log_dom = edge(dom, 'log');
zero_dom = edge(dom, 'zerocross');
canny_dom = edge(dom, 'canny');
sobel_dom = edge(dom, 'Sobel');

log_dom_man = edge(dom, 'log', 0.5, 0.5);
canny_dom_man = edge(dom, 'canny', [0.2 0.3], 0.5);
sobel_dom_man = edge(dom, 'Sobel', 0.12);

figure();
subplot(4,2,1);
imshow(dom);
title('original');
subplot(4,2,2);
imshow(zero_dom);
title('zero-crossing');

subplot(4,2,3);
imshow(log_dom);
title('log');
subplot(4,2,4);
imshow(log_dom_man);
title('log manual');

subplot(4,2,5);
imshow(canny_dom);
title('canny');
subplot(4,2,6);
imshow(canny_dom_man);
title('canny manual');

subplot(4,2,7);
imshow(sobel_dom);
title('sobel');
subplot(4,2,8);
imshow(sobel_dom_man);
title('sobel manual');


