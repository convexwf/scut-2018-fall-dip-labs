% exp_3

srcImage_name = '../images/srcImage.jpg';
srcImage = imread(srcImage_name);
noiseImage_name = '../images/noiseImage.bmp';
noiseImage = imread(noiseImage_name);
[rows, cols] = size(noiseImage);
N = 1;

% 均值滤波器去除噪声
T1 = noiseImage;
for i = 1+N : rows-N
    for j = 1+N : cols-N
        kernel = double(noiseImage(i-N:i+N,j-N:j+N));
        T1(i, j) = uint8( (sum(sum(kernel)))/(4*N*N+4*N+1) );
    end
end
figure(1);
subplot(1,3,1); imshow(noiseImage); title(' Image with noise ');
subplot(1,3,2); imshow(T1); title(' Image after average filtering ');
subplot(1,3,3); imshow(srcImage); title(' Image without noise ');

% 中值滤波器去除噪声
T2 = noiseImage;
for i = 1+N : rows-N
    for j = 1+N : cols-N
        kernel = noiseImage(i-N:i+N,j-N:j+N);
        vec = reshape(kernel, (2*N+1)^2, 1);
        sorted_vec = sort(vec, 1, 'ASCEND');
        mid = median(sorted_vec);
        T2(i, j)=mid;
    end
end
figure(2);
subplot(1,3,1); imshow(noiseImage); title(' Image with noise ');
subplot(1,3,2); imshow(T2); title(' Image after median filtering ');
subplot(1,3,3); imshow(srcImage); title(' Image without noise ');
