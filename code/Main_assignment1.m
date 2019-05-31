%% 3D Gaussians dataset meanshift
clear

load('data/pts.mat');

r = 2;

c = 4;

tic()

[labels, peaks] = meanshift_opt2(data, r, c);

toc()

plot3dclusters( data, labels, peaks )
title(['radius = ',num2str(r),', c = ', num2str(c)]);

%% Image segmentation

clear 

im = imread('img3.jpg');
% im = median_filt;

r = 30;

c = 4.5;


feature_type = 5;

tic()
 
[segmIm, labels, peaks, im_flattened] = imSegment(im, r, c, feature_type);

toc()

figure;
imshow(segmIm);
title(['radius = ',num2str(r),', c = ', num2str(c),', feature type = ', num2str(feature_type),', no. peaks = ', num2str(length(peaks))]);

figure;
plot3dclustersRGB(im_flattened', labels, peaks )
title(['radius = ',num2str(r),', c = ', num2str(c),', feature type = ', num2str(feature_type),', no. peaks = ', num2str(length(peaks))]);
%% Image segmentation - Multiple parameter experiments

clear
im = imread('img3.jpg');
%  im = imresize(im, 0.8);

r = 30;
c = 2.5;

feature_type = 5;

time_list = zeros(length(r),length(c),length(feature_type));

for i = 1:length(r)
    for j = 1:length(c)
        for k = 1:length(feature_type)
        rr = r(i);
        cc = c(j);
        ff = feature_type(k);
        
        tic;
        
        [segmIm, labels, peaks, im_flattened] = imSegment(im, rr, cc, ff);
        
        time_list(i, j, k) = toc;
   
        figure;
        imshow(segmIm);   
        set(gcf, 'Position',  [100, 100, 500, 400])   
        title(['radius = ',num2str(rr),', c = ', num2str(cc),', feature type = ', num2str(ff), 'D ',', no. peaks = ', num2str(length(peaks))]);    
        print(gcf, fullfile(sprintf('r_%d_c_%d_%dD.png',rr,cc)),'-dpng','-r600');
        
        figure;
        plot3dclustersRGB(im_flattened', labels, peaks );
        title(['radius = ',num2str(rr),', c = ', num2str(cc),', feature type = ', num2str(ff), 'D ',', no. peaks = ', num2str(length(peaks))]);
        print(gcf, fullfile(sprintf('r_%d_c_%dcloud_%dD.png',rr,cc)),'-dpng','-r600');
        
        end
    end
end

%% Preprocessing
%% Normalization
im = imread('img3.jpg');

im_norm = double(im);
im_norm = (im_norm-min(im_norm(:)))/(max(im_norm(:))-min(im_norm(:)));

%% Histogram equalization

hist_eq = histeq(im_norm);

%% Median Filter:

median_filt = medfilt3(im_norm);

%% 3-D Gaussian filtering of 3-D images
gauss_filt = imgaussfilt3(im_norm,1);

%% Wiener filter
wien = im_norm;
wien(:,:,1) = wiener2(im_norm(:,:,1),[5 5]);
wien(:,:,2) = wiener2(im_norm(:,:,2),[5 5]);
wien(:,:,3) = wiener2(im_norm(:,:,3),[5 5]);

%% Plots

figure;
subplot(2,3,1)
imshow(im)
title('Original Image')
subplot(2,3,2)
imshow(median_filt)
title('Median Filter')
subplot(2,3,4)
imshow(gauss_filt)
title('Gaussian filtering')
subplot(2,3,5)
imshow(wien)
title('Wiener filter')