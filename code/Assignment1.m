%% 3D Gaussians dataset meanshift
clear

load('data/pts.mat');

r = 2;

c = 1;

tic()

[labels, peaks] = meanshift(data, r);
% [labels, peaks] = meanshift_opt(data, r);

toc()

plot3dclusters( data, labels, peaks )
title(['radius = ',num2str(r),', c = ', num2str(c)]);

%% Image segmentation

clear 

im = imread('img2.jpg');

r = 10;

c = 2;

feature_type = '3D';

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
im = imread('img1.jpg');

feature_type = '5D';

r = [4, 8, 12, 16, 20];
c = [2, 4, 6];

time_list = zeros(length(r),length(c));

for i = 1:length(r)
    for j = 1:length(c)
        rr = r(i);
        cc = c(j);
        
        tic;
        
        [segmIm, labels, peaks, im_flattened] = imSegment(im, rr, cc, feature_type);
        
        time_list(i, j) = toc;

%         imwrite(segmIm,sprintf('r %d c %d.jpg',rr,cc))
        
        figure;
        imshow(segmIm);       
        title(['radius = ',num2str(rr),', c = ', num2str(cc),', feature type = ', num2str(feature_type),', no. peaks = ', num2str(length(peaks))]);    
        print(gcf, fullfile(sprintf('r %d c %d.png',rr,cc)),'-dpng','-r400');
        
        figure;
        plot3dclustersRGB(im_flattened', labels, peaks );
        title(['radius = ',num2str(rr),', c = ', num2str(cc),', feature type = ', num2str(feature_type),', no. peaks = ', num2str(length(peaks))]);
        print(gcf, fullfile(sprintf('r %d c %dcloud.png',rr,cc)),'-dpng','-r400');
        
    end
end

% medfilt3
% Image Normalization
% Median Filter:
% Mean Filter:
% im=(im-min(im(:)))/(max(im(:))-min(im(:)))

% I= double(imread('circles.png'));
% I= imnoise(I,'salt & pepper',0.02);
% Kaverage = filter2(fspecial('average',3),J)/255;
% figure
% imshow(Kaverage)

% K = wiener2(J,[5 5]);
% figure
% imshow(K(600:1000,1:600));
% title('Portion of the Image with Noise Removed by Wiener Filter');