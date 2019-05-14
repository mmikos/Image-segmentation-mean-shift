function [function_peak, cpts] = findpeak_opt(data, idx, r, c)
% found_cpts,found_prev

cpts = zeros(1, size(data,2));

% c = 4;

data_point = data(:,idx);

dataT=data';

data_pointT=data_point';

threshold = 0.01;

difference = 1;

% found_prev = [0];

while all(difference) > threshold

    distances = pdist2(dataT, data_pointT, 'euclidean');

    found = find(distances <= r);
    
%     found_cpts = find(distances <= r/c);
    
%     found_prev = cat(1, found_prev, found_cpts);

    cpts(distances <= r/c) = 1;
    
%     counter = length(find(cpts==1));

    curr_data = dataT(found, :);

    function_peak = mean(curr_data, 1);

    difference = abs(data_pointT - function_peak);

    data_pointT = function_peak;
    
end

function_peak=function_peak';
