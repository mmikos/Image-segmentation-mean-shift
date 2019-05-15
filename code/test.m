clear

im = imread('img1.jpg');

r = 10;

c = 1;

feature_type = '5D';

tic()
 
[segmIm, labels, peaks, im_flattened] = imSegment(im, r, c, feature_type);
toc()

% figure;

% subplot(121)
% imshow(im)

% subplot(122)
figure;
imshow(segmIm);
title(['radius = ',num2str(r),', c = ', num2str(c),', feature type = ', num2str(feature_type)]);

figure;
plot3dclustersRGB(im_flattened', labels, peaks )
title(['radius = ',num2str(r),', c = ', num2str(c),', feature type = ', num2str(feature_type)]);

% n = size(peaks,2);
% for label = 1:n
%     
% color = peaks(:, label);
%     color = lab2rgb(color');
%     color(color < 0.00000001) = 0;
%  
% list(:,label)=color;
%  
% end

% 
% load('data/pts.mat');
% 
% list = zeros(size(data));
% 
% r = 2;
% 
% 
% for idx = 1:length(data)
%     
%  peak = findpeak(data, idx, 2);
%  
%  list(:, idx) = peak;
%  
% end

% imshow(label_pixel,[])
