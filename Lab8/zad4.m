close all; clearvars; clc;

lab112 = imread('lab112.png');

figure(1);
binaryzation = uint8(im2bw(lab112, 0.168)) * 255;
se_disk = strel('disk', 3);
dl = imdilate(binaryzation, se_disk);
canny_lab112 = edge(dl, 'canny');
imshow(canny_lab112);

figure(2);
[H, theta, rho] = hough(canny_lab112);
peaks = houghpeaks(H, 8);
lines = houghlines(canny_lab112,theta,rho,peaks,'FillGap',5,'MinLength',7);
imshow(lab112);
hold on;
axis on, axis normal;
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
hold off;

figure(3);
dom = imread('dom.png');
canny_dom = edge(dom, 'canny');
[H, theta, rho] = hough(canny_dom);
peaks = houghpeaks(H, 6);

subplot(2,1,1);
imshow(dom);
subplot(2,1,2);
imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
hold on;
x = theta(peaks(:,2)); y = rho(peaks(:,1));
plot(x,y,'ro');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal;
axis off;
hold off;
