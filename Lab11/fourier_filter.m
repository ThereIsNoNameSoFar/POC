function fourier_filter(im, mask)
    im_size = size(im);
    [f1, f2] = freqspace(im_size(1), 'meshgrid');
    figure;
    subplot(1,2,1);
    colormap(jet(64));
    mesh(f1,f2,mask);
    subplot(1,2,2);
    fT = fft2(im);
    Y = fftshift(fT);
    Y_f = Y.*mask;
    iY = ifftshift(Y_f);
    H_filtered = ifft2(iY);
    imshow(H_filtered,[]);
end