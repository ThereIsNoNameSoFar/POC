close all; clearvars; clc;

ccl1 = imread('ccl1.png');

image = ccl1;

figure;
imshow(image);

[YY, XX] = size(image);
L = 1;
labels = zeros(YY,XX);

N = 100;
id = 1:N;

for Y = 2:(YY-1)
    for X = 2:(XX-1)
        if image(Y,X) == 0
            continue;
        end
        neighbours = [labels(Y-1, X-1), labels(Y-1,X), labels(Y-1,X+1), labels(Y, X-1)];
        if sum(neighbours) == 0
            labels(Y,X) = L;
            L = L + 1;
            continue;
        end
        neighbours = nonzeros(neighbours);
        minNeigh = min(neighbours);
        maxNeigh = max(neighbours);
        if minNeigh == maxNeigh
            labels(Y,X) = minNeigh;
        else
            labels(Y,X) = minNeigh;
            id = union(minNeigh, maxNeigh, id);
        end
    end
end

figure();
lut = id;
for I = 1:length(id)
    lut(I) = root(I, id);
end
labels2 = labels;
for Y = 1:YY
    for X = 1:XX
        if (labels(Y,X) > 0)
            labels2(Y,X) = lut(labels(Y,X));
        end
    end
end
imshow(label2rgb(labels2));



function tab_res = union(p, q, tab)
    tab(root(p, tab)) = root(q, tab);
    tab_res = tab;
end

function ret_id = root(id, tab)
    ret_id = id;
    while ret_id ~= tab(ret_id)
        ret_id = tab(ret_id);
    end
end