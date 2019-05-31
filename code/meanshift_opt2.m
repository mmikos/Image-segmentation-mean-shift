function [labels, peaks] = meanshift_opt2(data, r, c)
%% Meanshift - Second speedup

% Mean-shift function, calls findpeak for each point and then assigns a label
% to each point according to its peak. Algorithm compares peaks after each call 
% to findpeak and merges similar peaks. Two peaks are considered to be the same 
% if the distance between them is smaller than r/2. If the peak of a data point 
% already exists in peaks matrix then its computed peak is discarded and it is 
% given the label of the associated peak in peaks.

% The second speedup takes into account the point within a distance of
% r/c of the search path. These points are associated with the converged peak,
% where c is some constant value. 
% 
% Meanshift calls findpeak_opt function that uses a checkpoint vector (cpts)
% storing a 1 for each point that is a distance of r/c from the path, 0 otherwise.


% Parameters:
%       data: dataset or image
%       r: search window radius (number of clusters)
%       c: constant used to calculate a distance for the search path

% Output:
%		labels: vector of labels for each data point
%		peaks:  matrix of density peaks associated with data points

 labels = zeros(1, size(data,2));

 label_count = 1;

 [peak, cpts] = findpeak_opt(data, 1, r, c); 

 peaks(:, 1) = peak;

 index = find(cpts == 1);

 labels(index) = label_count;     

 for idx = 1:length(data)
     
     if labels(idx) == 0
            
     [peak, cpts] = findpeak_opt(data, idx, r, c);

     index = find(cpts == 1);
     
     for counter = 1:label_count
         
         if all(abs(peaks(:,counter) - peak) < r/2) == 1
             
             labels(index) = counter;
             
             break
         end
     end
     
     if labels(idx) == 0
         
         label_count = label_count + 1;  

         peaks(:, label_count) = peak;

         labels(index) = label_count;
     end
     end
 end
end