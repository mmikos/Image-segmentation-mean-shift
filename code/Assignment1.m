
load('data/pts.mat');

list = zeros(size(data));

r=2;


for idx = 1:length(data)
    
 peak = findpeak(data, idx, 2);
 
 list(:, idx) = peak;
 
end

%%
load('data/pts.mat');

tic()
 
[labels, peaks] = meanshift_opt2(data, 2);

toc()

plot3dclusters( data, labels, peaks )