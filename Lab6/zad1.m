close all; clearvars; clc;

load MR_data.mat;

local_window = [5 5];

displayFilter(I_noisefree, local_window, 0.1);
displayFilter(I_noisy1, local_window, 1);
displayFilter(I_noisy2, local_window, 1);
displayFilter(I_noisy3, local_window, 0.2);
displayFilter(I_noisy4, local_window, 0.3);

function displayFilter(Img, local_window, sigma)
    figure();
    subplot(1,3,1);
    imshow(Img, []);
    title("original");
    subplot(1,3,2);
    imshow(convolution(Img, local_window), []);
    title("convolution");
    subplot(1,3,3);
    imshow(bilateral(Img, local_window, sigma), []);
    title("bilateral, sigma: " + num2str(sigma));
end

function data_filtered = convolution_local(data, local_window)
    Nx = size(data,2);
    h = fspecial('gaussian', local_window, 25);
    data_filtered = zeros(1,Nx);
    for i=1:Nx
        patch = reshape(data(:,i),local_window);
        data_filtered(i) = sum(sum(patch .* h));
    end
end

function data_filtered = convolution(data, local_window)
    FUNCTION = @(data_, local_window_)convolution_local(data_, local_window_);
    data_filtered = colfilt(data, local_window, 'sliding', FUNCTION, local_window);
end

function data_filtered = bilateral_local(data, local_window, sigma)
    Nx = size(data,2);
    data_filtered = zeros(1,Nx);
    for i=1:Nx
        h = fspecial('gaussian', local_window, 25);
        patch = reshape(data(:,i),local_window);
        [rows, cols] = find(patch == patch);
        rows = reshape(rows, local_window);
        cols = reshape(cols, local_window);
        Ncy = ceil(local_window(1)/2);
        Ncx = ceil(local_window(2)/2);
        dist = sqrt((Ncy - rows).^2 + (Ncx - cols).^2);
        gamma = exp(-dist.^2 ./ (2 * sigma^2)); 
        data_filtered(i) = sum(sum(patch .* h .* gamma));
    end
end

function data_filtered = bilateral(data, local_window, sigma)
    FUNCTION = @(data_, local_window_)bilateral_local(data_, local_window_, sigma);
    data_filtered = colfilt(data, local_window, 'sliding', FUNCTION, local_window);
end