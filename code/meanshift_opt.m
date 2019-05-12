function [labels, peaks] = meanshift_opt(data, r)

labels = zeros(1, size(data,2));

[peak, found_distance] = findpeak(data, 1, r); 

peaks(:, 1) = peak;

label_count = 1;

labels(found_distance) = label_count;     

for idx = 2:length(data)
    
    if labels(idx) == 0

    [peak, found_distance] = findpeak(data, idx, r);
  
        for j = 1:label_count
        
            if  abs(peaks - peak) < r/2 == 0
        
            label_count = label_count + 1; 
            
            peaks(:, label_count) = peak;

            labels(found_distance) = label_count;
        
            else
                                 
            labels(idx) = label_count;

            end
        end
    end
 end


