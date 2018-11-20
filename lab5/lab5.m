% exp_5
% 频域低通和高通滤波

srcImage_name = '../images/lab5-srcImage.bmp';
srcImage = imread(srcImage_name);
noiseImage_name = '../images/lab5-noiseImage.bmp';
noiseImage = imread(noiseImage_name);
[rows, cols, channels] = size(noiseImage)
if channels == 3
    noiseImage = rgb2gray(noiseImage);
end
f = fftshift(fft2(double(noiseImage)));
% 计算D
n = 55;
D = zeros(rows, cols);
for u = 1 : rows
    for v = 1 : cols
        D(u, v) = sqrt((u-rows/2)^2+(v-cols/2)^2);
    end
end

%布特沃思低通滤波器
D0_1 = 80;
H1 = 1./(1+(D./D0_1).^(2*n));
F1 = f.*H1;
T1 = (ifft2(ifftshift(F1)));

figure(1)
subplot(1,3,1); imshow(noiseImage); title(' Image with noise ');
subplot(1,3,2); imshow(uint8(real(T1))); title(' Image after filtering ');
subplot(1,3,3); imshow(srcImage); title(' Image without noise ');

%高斯低通滤波器
D0_2 = 80;
H2 = exp((-(D.^2))/(2*D0_2^2));
F2 = f.*H2;
T2 = uint8(real((ifft2(ifftshift(F2)))));

figure(2)
subplot(1,3,1); imshow(noiseImage); title(' Image with noise ');
subplot(1,3,2); imshow(T2); title(' Image after filtering ');
subplot(1,3,3); imshow(srcImage); title(' Image without noise ');

%布特沃思高通滤波器
D0_3 = 10;
H3 = 1./(1+(D0_3./D).^(2*n));
F3 = f.*H3;
T3 = uint8(real((ifft2(ifftshift(F3)))));

figure(3)
subplot(1,3,1); imshow(noiseImage); title(' Image with noise ');
subplot(1,3,2); imshow(T3); title(' Image after filtering ');
subplot(1,3,3); imshow(srcImage); title(' Image without noise ');

%高斯高通滤波器
D0_4 = 10;
H4 = 1-exp(-((D.^2)./(2*D0_4.^2)));
F4 = f.*H4;
T4 = uint8(real((ifft2(ifftshift(F4)))));

figure(4)
subplot(1,3,1); imshow(noiseImage); title(' Image with noise ');
subplot(1,3,2); imshow(T4); title(' Image after filtering ');
subplot(1,3,3); imshow(srcImage); title(' Image without noise ');
