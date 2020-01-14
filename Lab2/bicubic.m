clearvars; close all; clc;

figure(1);
Img = imread('parrot.bmp');
img1 = imshow(Img);

xReScale = 10;
yReScale = 10;
[YY, XX] = size(Img);

nYY = round(YY * yReScale);
nXX = round(XX * xReScale);

nI = uint8(zeros(nYY,nXX));

xStep = XX/nXX;
yStep = YY/nYY;
Img2 = double(Img);

load('a1.mat');

for jj = 0 : nYY-1
    j = jj*yStep;
     for ii = 0 : nXX-1
         i = ii*xStep;
         A = floor([j,i]);
         B = A + [1, 0];
         C = A + [1, 1];
         D = A + [0, 1];
         if i <= 2 || j <= 2 || ii >= nXX-(2*xReScale) || j >= YY-2
            nI(jj+1,ii+1) = Img2(A(1)+1,A(2)+1);
            continue
         end
         
         fA = Img2(A(1)+1,A(2)+1);
         fB = Img2(B(1)+1,B(2)+1);
         fC = Img2(C(1)+1,C(2)+1);
         fD = Img2(D(1)+1,D(2)+1);
         
         Ax = (Img2(A(1)+1,A(2))-Img2(A(1)-1,A(2)))/2;
         Ay = (Img2(A(1),A(2)+1)-Img2(A(1),A(2)-1))/2;
         Axy = (Img2(A(1)+1,A(2)+1)-Img2(A(1)-1,A(2))-Img2(A(1),A(2)-1)+Img2(A(1),A(2)))/4;
         Bx = (Img2(B(1)+1,B(2))-Img2(B(1)-1,B(2)))/2;
         By = (Img2(B(1),B(2)+1)-Img2(B(1),B(2)-1))/2;
         Bxy = (Img2(B(1)+1,B(2)+1)-Img2(B(1)-1,B(2))-Img2(B(1),B(2)-1)+Img2(B(1),B(2)))/4;
         Cx = (Img2(C(1)+1,C(2))-Img2(C(1)-1,C(2)))/2;
         Cy = (Img2(C(1),C(2)+1)-Img2(C(1),C(2)-1))/2;
         Cxy = (Img2(C(1)+1,C(2)+1)-Img2(C(1)-1,C(2))-Img2(C(1),C(2)-1)+Img2(C(1),C(2)))/4;
         Dx = (Img2(D(1)+1,D(2))-Img2(D(1)-1,D(2)))/2;
         Dy = (Img2(D(1),D(2)+1)-Img2(D(1),D(2)-1))/2;
         Dxy = (Img2(D(1)+1,D(2)+1)-Img2(D(1)-1,D(2))-Img2(D(1),D(2)-1)+Img2(D(1),D(2)))/4;

         xs = [fA; fB; fD; fC; Ax; Bx; Dx; Cx; Ay; By; Dy; Cy; Axy; Bxy; Dxy; Cxy];
         a = A1*xs;
         current = [j,i]-A;
         y = current(1);
         x = current(2);
         
         sum = 0.0;
         for b = 0:3
             for c = 0:3
                 sum = sum + a(b*4+c+1)*x^b*y^c;
             end
         end        
         nI(jj+1,ii+1) = sum;
     end
 end
 
 figure(2);
 img2 = imshow(uint8(nI));