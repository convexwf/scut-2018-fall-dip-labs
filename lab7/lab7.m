% exp_7
% 人脸皮肤颜色分层
image_name = '../images/skin.jpg';
image = double(imread(image_name));
[rows, cols, channels] = size(image);

% 进行颜色取样
sample_cnt = 10; % 颜色取样次数
imshow(uint8(image));
[x, y] = ginput(2*sample_cnt); % 背景色和肤色都需要采样

% 计算颜色平均值
bg_color = zeros(sample_cnt, 3);
skin_color = zeros(sample_cnt, 3);

for i = 1 : sample_cnt
	bg_color(i, :) = image(uint16(y(i)), uint16(x(i)), :);
	skin_color(i, :) = image(uint16(y(i+sample_cnt)), uint16(x(i+sample_cnt)), :);
end

% 去除背景
bg_mean = mean(bg_color, 1);
bg_std = std(bg_color, 0, 1);
T1 = image;
for u = 1 : rows
	for v = 1 : cols
		im = image(u, v, :);
		is_bg = true;
		for c = 1 : 3
			if(abs(im(c)-bg_mean(c)) > bg_std(c)*3)
				is_bg = false;
			end
		end
		if is_bg %  背景设为黑色
			T1(u, v, :) = [0 0 0];
		end
	end
end

% 提取脸部
skin_color
skin_mean = mean(skin_color, 1)
skin_std = std(skin_color, 0, 1)
T2 = T1;

for u = 1 : rows
	for v = 1 : cols
		im = T1(u, v, :);
		is_skin = true;
		for c = 1 : 3
			if(abs(im(c)-skin_mean(c)) > skin_std(c)*3)
				is_skin = false;
			end
		end
		if ~is_skin % 肤色外设为黑色
			T2(u, v, :) = [0 0 0];
		end
	end
end

figure(1)
subplot(1,3,1); imshow(uint8(image)); title(' src Image ');
subplot(1,3,2); imshow(uint8(T1)); title(' after background removal ');
subplot(1,3,3); imshow(uint8(T2)); title(' after skin color extraction ');
