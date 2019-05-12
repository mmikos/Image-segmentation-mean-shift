function [labels, peaks] = meanshift_opt2(data, r)

labels = zeros(1, size(data,2));

label_count = 1;

[peak, cpts] = findpeak_opt(data, 1, r); 

peaks(:, 1) = peak;

index = find(cpts == 1);

labels(index) = label_count;     

for idx = 2:length(data)
    
    if labels(idx) == 0

    [peak, cpts] = findpeak_opt(data, idx, r);
    
    index = find(cpts == 1);
  
        for j = 1:label_count
        
            if  abs(peaks - peak) < r/2 == 0
        
            label_count = label_count + 1; 
            
            peaks(:, label_count) = peak;

            labels(index) = label_count;
        
            else
                                 
            labels(index) = label_count;

            end
        end
    end
end