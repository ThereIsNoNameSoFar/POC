close all; clearvars; clc;

kwadraty = imread('kwadraty.png');

canny_kwadraty = edge(kwadraty, 'canny');
[H, theta, rho] = hough(canny_kwadraty);
peaks = houghpeaks(H, 8);

figure(1);
subplot(2,2,1);
imshow(kwadraty,[]);
subplot(2,2,2);
imshow(canny_kwadraty,[]);
subplot(2,2,3);
imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
hold on;
x = theta(peaks(:,2)); y = rho(peaks(:,1));
plot(x,y,'o');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal;
axis off;
hold off;

figure(2);
lines = houghlines(kwadraty,theta,rho,peaks,'FillGap',5,'MinLength',7);
imshow(kwadraty);
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