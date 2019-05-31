function [function_peak, cpts] = findpeak_opt(data, idx, r, c)
%% Peak searching function - Second speedup

% This function pearforms peak searching for each point by defining 
% a spherical window at the data point of radius r and computing the
% mean of the points that lie within the window. The algorithm then 
% shifts the window to the mean and repeats until convergence under 
% a threshold (here: t = 0.01). With each iteration the window will 
% shift to a more densely populated portion of the data set until 
% a peak is reached, where the data is equally distributed in the window.

% The second speedup takes into account the point within a distance of
% r/c of the search path. These points are associated with the converged peak,
% where c is some constant value. 

% Parameters:
%       data: dataset or image
%       idx: column index of the data point
%       r: search window radius (number of clusters)
%       c: constant used to calculate a distance for the search path

% Output:
%		function_peak: density peak associated with a data point
%		cpts:  checkpoint vector (cpts) storing a 1 for each point that 
%              is a distance of r/c from the path, 0 otherwise

 cpts = zeros(1, size(data,2));

 data_point = data(:,idx);

 dataT=data';

 data_pointT=data_point';

 threshold = 0.01;

 difference = 1;

 while all(difference) > threshold
     
     distances = pdist2(dataT, data_pointT, 'euclidean');

     found = find(distances <= r);
    
     % assign value 1 when distance between the point and rest of the data is smaller than r/c
     
     cpts(distances <= r/c) = 1;

     curr_data = dataT(found, :);

     function_peak = mean(curr_data, 1);

     difference = abs(data_pointT - function_peak);

     data_pointT = function_peak;
    
 end

 function_peak=function_peak';
end