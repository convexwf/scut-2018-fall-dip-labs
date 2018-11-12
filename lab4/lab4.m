%exp_4
%利用拉普拉斯算子进行空间域锐化
image_name = '../images/LaplaceFilter.bmp';
image = imread(image_name);
[rows, cols] = size(image);
N = 1;

LP1= [1 1 1;1 -8 1;1 1 1];
LP2 = [0 1 0;1 -4 1;0 1 0];
LP = LP2

T = image;
for i = 1+N : rows-N
    for j = 1+N : cols-N
        kernel = double(image(i-N:i+N,j-N:j+N));
        T(i,j) = uint8(T(i,j) - sum(sum(LP.*kernel)));
    end
end

figure(1);
subplot(1,2,1); imshow(image); title(' srcImage ');
subplot(1,2,2); imshow(T); title(' Image after Laplace transform ');
