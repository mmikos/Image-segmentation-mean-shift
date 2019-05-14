function [segmIm, labels, peaks, im_flattened] = imSegment(im, r, c, feature_type)
%IMSEGMENT image segmentation.
%   Description of its functionaility is given in the assignment
%
%   Parameters: 
%       im: RGB image
%       r: number of clusters
%       feature_type: the feature type you use in your implementation as
%       suggested in the assignment description: '3D' or '5D'
%   Output:
%       SegmIm: segmentated image where its pixels' values are colored
%       based on the labels
%		Labels: labels for each data point
%		Peaks:  peaks associated with data points

row = size(im,1);

column = size(im,2);

im_flattened = reshape(im,row*column,3);

img = rgb2lab(im_flattened);

if feature_type == '3D' 

    imgT=img';

    [labels, peaks] = meanshift_opt2(imgT, r, c);
   
    label_pixel = reshape(labels,row,column);

    no_of_peaks = length(peaks);

% peaksrgb = lab2rgb(peaks');
% 
% peaksrgb=peaksrgb';

    segmIm = zeros(size(im));
   
        for label = 1:no_of_peaks

            for x = 1 : row
                 for y = 1 : column
                        segmIm(x, y, :) = peaks(:, label_pixel(x, y));
                 end
            end
        end
    
elseif feature_type == '5D'

    [X, Y] = meshgrid(im(1,:,1),im(:,1,1));

    X_flattened = reshape(X,row*column,1);
    Y_flattened = reshape(Y,row*column,1);

    img(:, 4) = X_flattened;

    img(:, 5) = Y_flattened;

    imgT=img';

    [labels, peaks] = meanshift_opt2(imgT, r, c);

    peaks = peaks(1:3,:);

    label_pixel = reshape(labels,row,column);

    no_of_peaks = length(peaks);

    % peaksrgb = lab2rgb(peaks');
    % 
    % peaksrgb=peaksrgb';

    segmIm = zeros(size(im));

        for label = 1:no_of_peaks
            for x = 1 : row
                for y = 1 : column
                        segmIm(x, y, :) = peaks(:, label_pixel(x, y));
                end
            end
        end

else

        disp('Wrong input')

end
        
segmIm = lab2rgb(segmIm);
