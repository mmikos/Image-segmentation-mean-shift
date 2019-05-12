function [labels, peaks] = meanshift(data, r)

labels = zeros(1, size(data,2));

list = zeros(size(data));

peak = findpeak(data, 1, r); 

peaks(:, 1) = peak;
 
list(:, 1) = peak;
 
i = 2;


for idx = 2:length(data)

    peak = findpeak(data, idx, r); 

    list(:, idx) = peak;
        
    if  abs(peaks - peak) < r/2 == 0
            
        peaks(:, i) = peak;
            
        i = i + 1; 
        
    end
end

number_of_peaks = size(peaks, 2);

for idx = 1:length(data)

    for j = 1:number_of_peaks
        
        if abs(list(:, idx) - peaks(:, j)) < r/2

        labels(1, idx) = j;
    
        end
    end
end

end

