close all; clearvars; clc;

knee = imread('knee.png');

imshow(knee);

knee = double(knee);

seed = floor(ginput(1));

seed = [seed(2), seed(1)];

visited = zeros(size(knee));
segmented = zeros(size(knee));

iStack = 1;
stack = zeros([10000,2]);

visited(seed(1),seed(2)) = 1;
stack(iStack,:) = [seed(1), seed(2)];
segmented(seed(1),seed(2)) = knee(seed(1),seed(2));

threshold = 30;

mV = 0;
ns = 0;

imageSize = size(knee);

while(iStack > 0)
    pX = stack(iStack,1);
    pY = stack(iStack,2);
    iStack = iStack - 1;
    ns = ns + 1;
    mV = (mV * (ns - 1) + knee(pX,pY))/ns;
    if(pX < 2 || pY < 2 || pX > (imageSize(1) - 1) || pY > (imageSize(2) - 1))
        continue;
    end
    for I = -1:1
        for J = -1:1
            nX = pX + I;
            nY = pY + J;
            if(nX ~= pX && nY ~= pY && visited(nX,nY) == 0)
                visited(nX,nY) = 1;
                diff = abs(mV - knee(nX,nY));
                if(diff < threshold)
                    segmented(nX,nY) = knee(nX,nY);
                    iStack = iStack + 1;
                    stack(iStack, :) = [nX,nY];
                end
            end
        end
    end
end

figure();
imshow(segmented, []);

