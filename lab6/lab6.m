% exp_6

image_name = '../images/Fourier.bmp';
image = imread(image_name);
[rows, cols, channels] = size(image);
if channels == 3
    image = rgb2gray(image);
end
G = fftshift(fft2(double(image)));
k = 0.00001;

% 逆滤波
H = zeros(rows, cols);
for u = 1 : rows
    for v = 1 : cols
        H(u, v) = exp(-k*(u^2+v^2)^(5/6));
    end
end
F1 = G ./ H;
T1 = uint8(real((ifft2(ifftshift(F1)))));

% 维纳滤波
F2 = zeros(rows, cols);
for u = 1 : rows
    for v = 1 : cols
        g = G(u, v);
        h = H(u, v);
        F2(u, v) = (1/h) * (h^2/(h^2+k)) * g;
    end
end
T2 = uint8(real((ifft2(ifftshift(F2)))));

figure(1);
subplot(1,3,1); imshow(image); title(' srcImage ');
subplot(1,3,2); imshow(T1); title(' Image after inverse filtering ');
subplot(1,3,3); imshow(T2); title(' Image after Wiener filtering ');
