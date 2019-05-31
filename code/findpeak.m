%% Peak searching function - non-optimized

% This function pearforms peak searching for each point by defining 
% a spherical window at the data point of radius r and computing the
% mean of the points that lie within the window. The algorithm then 
% shifts the window to the mean and repeats until convergence under 
% a threshold (here: t = 0.01). With each iteration the window will 
% shift to a more densely populated portion of the data set until 
% a peak is reached, where the data is equally distributed in the window. 

% Parameters:
%       data: dataset or image
%       idx: column index of the data point
%       r: search window radius (number of clusters)

% Output:
%		function_peak: density peak associated with a data point
%		found_distance: vector that contains indices of the datapoints within radius r

function [function_peak, found_distance] = findpeak(data, idx, r)

data_point = data(:,idx);

dataT=data';

data_pointT=data_point';

threshold = 0.01;

difference = 1;

while all(difference) > threshold

    distances = pdist2(dataT, data_pointT, 'euclidean');

    found_distance = find(distances <= r);
    
    curr_data = dataT(found_distance, :);

    function_peak = mean(curr_data, 1);

    difference = abs(data_pointT - function_peak);

    data_pointT = function_peak;

end

function_peak=function_peak';
