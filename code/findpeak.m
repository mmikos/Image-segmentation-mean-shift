function [function_peak, found_distance] = findpeak(data, idx, r)

data_point = data(:,idx);

dataT=data';

data_pointT=data_point';

threshold = 0.1;

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
