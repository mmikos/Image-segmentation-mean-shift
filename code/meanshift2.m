function [labels, peaks] = meanshift2(data, r)

labels = zeros(1, size(data,2));

peak = findpeak(data, 1, r); 

peaks(:, 1) = peak;

label_count = 1;

labels(1) = label_count;

for idx = 1:length(data)

    peak = findpeak(data, idx, r); 
    
    for j = 1:label_count
        
        if  abs(peaks - peak) < r/2 == 0
            
        peaks(:, label_count) = peak;
        
        labels(idx) = label_count;
        
        label_count = label_count + 1; 
        
        else
        
        labels(idx) = label_count;
        
        end
    end
end
