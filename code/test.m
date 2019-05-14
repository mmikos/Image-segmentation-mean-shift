clear

im = imread('img3.jpg');

r = 8;

tic()
 
[segmIm, labels, peaks, im_flattened] = imSegment(im, r, '5D');
toc()

figure;

subplot(121)
imshow(im)

subplot(122)
imshow(segmIm);
% 
% row = size(im,1);
% column = size(im,2);
% im = reshape(im,row*column,3);
figure;
plot3dclusters(im_flattened', labels, peaks )

% n = size(peaks,2);
% for label = 1:n
%     % pick random color
% %     color = rand([3 1]);
%     color = peaks(:, label);
%     color = lab2rgb(color');
%     list(:, label) = color;
% end

% imshow(label_pixel,[])
