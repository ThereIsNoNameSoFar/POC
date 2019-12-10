close all; clearvars; clc;

global sTh vTh MRes segRes index;

umbrealla = imread('umbrealla.png');

figure();
imshow(umbrealla);
title('original image');

umbrealla = double(umbrealla);

umbreallaHSV = double(rgb2hsv(umbrealla));
H = umbreallaHSV(:,:,1);

colorThreshold = 5/255;
minAreaSize = 27;

figure();
imshow(H, []);
title('H vector');

sTh = 4;
vTh = 0.05;
index = -1;

[y, x] = size(H);

segRes = zeros(y, x);
MRes = zeros(y, x);

split(H, 1, 1, x, y);

i = 0;
while i <= index
   IB = segRes == i;
   
   if any(IB(:))
       [yF, xF] = find(IB, 1, 'first');
       
       square = strel('square', 3);
       neighbors = imdilate(IB, square);
       diff = imabsdiff(neighbors, IB);
       pointMult = diff .* segRes;
       nonZeros = nonzeros(pointMult);
       uniqued = unique(nonZeros);
       
       isJoined = 0;
       for neighbor = 1:numel(uniqued)
           IBS = segRes == uniqued(neighbor);
           
           [yFS, xFS] = find(IBS, 1, 'first');
           
           colorDiff = abs(MRes(yF,xF) - MRes(yFS, xFS));
           if colorDiff < colorThreshold
               segRes(IBS) = i;
               isJoined = 1;
           end
       end
       if isJoined == 0
          i = i + 1;
       end
   else
       i = i + 1;
   end
end

figure();
imshow(segRes,[]);

U = unique(segRes);

for idx = 1:numel(U)
    C = segRes == U(idx);
    if sum(C) < minAreaSize
       segRes(C) = 0; 
    end
end

U = unique(segRes);

for idx = 1:numel(U)
    C = segRes == U(idx);
    segRes(C) = idx;
end

finalImage = label2rgb(segRes);

figure();
imshow(finalImage);




function split(image, xS, yS, xE, yE)
    global sTh vTh segRes index MRes
    
    subImage = image(yS:yE,xS:xE);
    meanVal = mean(subImage(:));
    stdevVal = std(subImage(:));
    
    if (stdevVal < vTh) || ((xE - xS) <= sTh)
        index=index + 1;
        segRes(yS:yE, xS:xE) = index;
        MRes(yS:yE, xS:xE) = meanVal;
    else
        splitX = floor((xE + xS) / 2);
        splitY = floor((yE + yS) / 2);
        
        % recursive call for 4 new Images I1 I2 I3 I4
        split(image, xS, yS, splitX, splitY);
        split(image, splitX + 1, yS, xE, splitY);
        split(image, splitX + 1, splitY + 1, xE, yE);
        split(image, xS, splitY + 1, splitX, yE);
    end
end