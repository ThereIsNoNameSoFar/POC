function show_fourier(Img)
    im = double(Img);
    fT = fft2(im);
    Y = fftshift(fT);
    A = abs(fT);
    F = angle(Y.*(A>0.0001));

    figure;
    subplot(2,2,1);
    imshow(Img,[]);
    title('original');
    subplot(2,2,2);
    A = log10(A+1);
    imshow(A,[]);
    title('amplitude');
    subplot(2,2,3);
    imshow(F,[]);
    title('phaze');
    subplot(2,2,4);
    iY = ifftshift(Y);
    iFT = ifft2(iY);
    imshow(uint8(iFT),[]);
    title('inverse');
end