% exp_2
% 灰度变换
image_name_1 = '../images/GrayTransformation.bmp';
image_1 = double(imread(image_name_1));

R=image_1(:,:,1);
G=image_1(:,:,2);
B=image_1(:,:,3);

% 灰度变换
%R=uint8(255-R);
%B=uint8(255-B);
%G=uint8(255-G);

% 对数变换
%R = uint8(10.5 * log2(1+R));
%G = uint8(10.5 * log2(1+G));
%B = uint8(10.5 * log2(1+B));

% 幂率变换
R = uint8(0.5 * (R.^2));
G = uint8(0.5 * (G.^2));
B = uint8(0.5 * (B.^2));



new_image_1 = cat(3, R, G, B);
figure(1);
subplot(1,2,1), imshow(uint8(image_1)); title(' srcimage ');
subplot(1,2,2), imshow(new_image_1); title(' GrayTransformation ');

% 伽马校正
image_name_2 = '../images/GammaCorrection.bmp';
image_2 = double(imread(image_name_2));
C=300;
y1=0.4; T1 = (image_2/C).^(1/y1)*C;
y2=0.6; T2 = (image_2/C).^(1/y2)*C;
y3=0.8; T3 = (image_2/C).^(1/y3)*C;
figure(2);
subplot(2,2,1); imshow(uint8(image_2)); title(' srcimage ');
subplot(2,2,2); imshow(uint8(T1)); title(' gamma = 0.4 ');
subplot(2,2,3); imshow(uint8(T2)); title(' gamma = 0.6 ');
subplot(2,2,4); imshow(uint8(T3)); title(' gamma = 0.8 ');
