
load('data/pts.mat');

list = zeros(size(data));

r = 2;


for idx = 1:length(data)
    
 peak = findpeak(data, idx, 2);
 
 list(:, idx) = peak;
 
end

%%
clear

load('data/pts.mat');

r = 2;

c = 1;

tic()

[labels, peaks] = meanshift_opt2(data, r, c);
% [labels, peaks] = meanshift_opt(data, r);

toc()

plot3dclusters( data, labels, peaks )
title(['radius = ',num2str(r),', c = ', num2str(c)]);

%%
clear 

im = imread('img1.jpg');

r = 20;

c = 4;

feature_type = '5D';

tic()
 
[segmIm, labels, peaks, im_flattened] = imSegment(im, r, c, feature_type);

toc()

figure;
imshow(segmIm);
title(['radius = ',num2str(r),', c = ', num2str(c),', feature type = ', num2str(feature_type)]);

figure;
plot3dclustersRGB(im_flattened', labels, peaks )
title(['radius = ',num2str(r),', c = ', num2str(c),', feature type = ', num2str(feature_type)]);
