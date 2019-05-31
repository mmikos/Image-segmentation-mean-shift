function [segmIm, labels, peaks, im_flattened] = imSegment(im, r, c, feature_type)
%% Image segmentation.

% This function performs image segmentation by running meanshift function
% on the transposed flattened image. The input image needed to be
% reshaped and coverted to Lab color space in order to have a desired
% shape for the meanshift input. Using labels a matrix was created with
% each pixel assigned to a cluster. Peak values were used to color the
% pixels in an image based on the labels. Two different types of features
% were used:
% (1) the Lab color values (3D feature vector)
% (2) Lab + (x,y) coordinate values (5D feature vector)
% Segmented image was reshaped back to the oroginal size and converted back
% to RGB color space.

%   Parameters: 
%       im: RGB image
%       r: number of clusters
%       c: constant used to calculate a distance for the search path
%       feature_type: the feature type you use in your implementation as
%       suggested in the assignment description: '3D' or '5D'
%   Output:
%       SegmIm: segmentated image where its pixels' values are colored
%       based on the labels
%		Labels: labels for each data point
%		Peaks:  peaks associated with data points
%       im_flattened: resized image, for plotting clusters

 row = size(im,1);

 column = size(im,2);

 im_flattened = reshape(im,row*column,3);

 img = rgb2lab(im_flattened);

 if feature_type == 3

     imgT=img';

     [labels, peaks] = meanshift_opt2(imgT, r, c);
   
     label_pixel = reshape(labels,row,column);
   
     label_pixel_flattened = reshape(label_pixel,row*column,1);
   
     no_of_peaks = length(peaks);

     segmIm = zeros(size(im_flattened'));
     
     for label = 1:no_of_peaks
         
         found = find(label_pixel_flattened == label);
         segmIm(:, found) = peaks(:, label_pixel_flattened(found));
          
     end
     
 elseif feature_type == 5
     
     [X, Y] = meshgrid(1:column,1:row);

     X_flattened = reshape(X,row*column,1);
     Y_flattened = reshape(Y,row*column,1);

     img(:, 4) = X_flattened;

     img(:, 5) = Y_flattened;

     imgT=img';

     [labels, peaks] = meanshift_opt2(imgT, r, c);

     peaks = peaks(1:3,:);

     label_pixel = reshape(labels,row,column);
     
     label_pixel_flattened = reshape(label_pixel,row*column,1);
     
     no_of_peaks = length(peaks);
     
     segmIm = zeros(size(im_flattened'));
     
     for label = 1:no_of_peaks
        
         found = find(label_pixel_flattened == label);
         
         segmIm(:,found) = peaks(:,label_pixel_flattened(found));
     
     end
     
 else
     
     disp('Wrong input')
 
 end
 
segmIm = reshape(segmIm', row, column, 3);

segmIm = lab2rgb(segmIm);

end
