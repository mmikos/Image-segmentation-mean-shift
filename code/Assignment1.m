
load('data/pts.mat');

list = zeros(size(data));

r=2;


for idx = 1:length(data)
    
 peak = findpeak(data, idx, 2);
 
 list(:, idx) = peak;
 
end

%%
load('data/pts.mat');

tic()
 
[labels, peaks] = meanshift_opt(data, 2);
% [labels, peaks] = meanshift_opt2(imgT,r);
toc()

plot3dclusters( data, labels, peaks )

%%

% he = imread('55075.jpg');
% imshow(he);
% 
% lab_he = rgb2lab(he);
%  
% ab = lab_he(:,:,2:3);
% ab = im2single(ab);
% nColors = 3;
% % repeat the clustering 3 times to avoid local minima
% pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',3);
% 
% imshow(pixel_labels,[])
% title('Image Labeled by Cluster Index');


%%
im = imread('181091.jpg');

r = 100;

% imshow(im )

tic()
 
[segmIm, labels, peaks, img] = imSegment(im, r, '3D');
toc()
row = size(im,1);
column = size(im,2);
im = reshape(im,row*column,3);

plot3dclusters(im', labels, peaks )
%  imshow(segmIm)
segmIm = reshape(segmIm,row,column);
