% PLOTCLUSTERS Plots a set of differently colored point clusters.
%   PLOT3DCLUSTERS( DATA, LABELS, MEANS ) plots the 3D data D with each of
%   its different clusters as different colors. The cluster means and
%   labels are specified by LABELS and MEANS respectively.

% This modification uses real RGB values extracted from the peaks

function plot3dclustersRGB( data, labels, means )

% plot each cluster
n = size(means,2);
for label = 1:n

    color = means(:, label);
    color = lab2rgb(color');
    
    % conversion from lab to rgb makes values of color sligtly smaller than
    % 0 or sligtly bigger than 1, hence we replace the conversion errors    
    color(color < 0) = 0;
    color(color > 1) = 1;
    cluster = data( :, find(labels == label) );
    plot3(cluster(1,:),cluster(2,:),cluster(3,:),'.','Color',color); hold on;
end
grid on;
    
    
