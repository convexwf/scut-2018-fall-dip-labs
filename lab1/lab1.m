% 将RGB值转为YUV值
function [Y, U, V]=RGB2YUV(R, G, B)
    Y = 0.299*R+0.587*G+0.114*B;
    U = 0.564 * (B-Y);
    V = 0.713 * (R-Y);
end

% 将YUV值转为RGB值
function [R, G, B] = YUV2RGB(Y, U, V)
    R = Y + 1.402*V;
    G = Y - 0.344*U - 0.714*V;
    B = Y + 1.772*U;
end

% exp_1
% 数字图像读取及色彩、亮度、对比度变化
image_name = '../images/lena.bmp';
image_RGB = imread(image_name);
[rows, cols, channels] = size(image_RGB);

% 调整色彩
R = image_RGB(:, :, 1);
G = image_RGB(:, :, 2);
B = image_RGB(:, :, 3);
image_R = cat(3, R, zeros(rows, cols), zeros(rows, cols));
image_G = cat(3, zeros(rows, cols), G, zeros(rows, cols));
image_B = cat(3, zeros(rows, cols), zeros(rows, cols), B);
figure(1);
subplot(2,2,1); imshow(image_RGB); title(' srcImage ');
subplot(2,2,2); imshow(image_R); title(' R-channel ');
subplot(2,2,3); imshow(image_G); title(' G-channel ');
subplot(2,2,4); imshow(image_B); title(' B-channel ');

% 调整亮度
[Y, U, V] = RGB2YUV(R, G, B);
image_YUV = cat(3, Y, U, V);

alpha1 = 0.5; Y1 = alpha1 * Y;
[R1, G1, B1] = YUV2RGB(Y1, U, V);
I1 = uint8(cat(3, R1, G1, B1));
alpha2 = 1.5; Y2 = alpha2 * Y;
[R2, G2, B2] = YUV2RGB(Y2, U, V);
I2 = uint8(cat(3, R2, G2, B2));

figure(2);
subplot(1,3,1); imshow(image_RGB); title(' srcImage ');
subplot(1,3,2); imshow(I1); title(' Y = Y * 0.5 ');
subplot(1,3,3); imshow(I2); title(' Y = Y * 1.5 ');

% 调整对比度
b = 50;
beta1 = 0.75; Y1 = beta1 * Y + b;
[R1, G1, B1] = YUV2RGB(Y1, U, V);
T1 = uint8(cat(3, R1, G1, B1));
beta2 = 1.25; Y2 = beta2 * Y - b;
[R2, G2, B2] = YUV2RGB(Y2, U, V);
T2 = uint8(cat(3, R2, G2, B2));

figure(3);
subplot(1,3,1); imshow(image_RGB); title(' srcImage ');
subplot(1,3,2); imshow(T1); title(' Y = Y * 0.75 + 50 ');
subplot(1,3,3); imshow(I2); title(' Y = Y * 1.25 - 50 ');
