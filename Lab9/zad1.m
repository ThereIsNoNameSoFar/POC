close all; clearvars; clc;

knee = imread('knee.png');

imshow(knee);

seed = floor(ginput(1));
%seed = [100, 100];

visited = logical(zeros(size(knee)));
segmented = zeros(size(knee));

iStack = 1;
stack = zeros([10000,2]);

point(1) = seed(2);
point(2) = seed(1);
visited(point(1),point(2)) = 1;
stack(iStack,:) = point;
segmented(point(1),point(2)) = 1;

threshold = 4;

mV = 0;
ns = 0;

imageSize = size(knee);

while(iStack > 0)
    prevPoint = stack(iStack,:);
    stack(iStack, :) = [0, 0];
    iStack = iStack - 1;
    ns = ns + 1;
    mV = (mV * (ns - 1) + knee(prevPoint(2),prevPoint(1)))/ns;
    if(prevPoint(1) < 2 || prevPoint(2) < 2 || prevPoint(1) > (imageSize(1) - 1) || prevPoint(2) > (imageSize(2) - 1))
        continue;
    end
    
    for I = -1:1
        for J = -1:1
            point = prevPoint + [I, J];
            if(visited(point(1),point(2)) == 0)
                visited(point(1),point(2)) = 1;
                diff = abs(mV - knee(point(1),point(2)));
                if(diff < threshold)
                    segmented(point(1),point(2)) = 1;
                    iStack = iStack + 1;
                    stack(iStack, :) = point;
                end
            end
        end
    end
end

figure();
imshow(segmented);

