function [labels, peaks] = meanshift_opt2(data, r, c)

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