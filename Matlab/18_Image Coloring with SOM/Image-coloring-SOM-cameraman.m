clc
clear
close all

% Load a built-in grayscale image
image_gray = imread('cameraman.tif'); 
imshow(image_gray)

x = double(image_gray(:))';

% Create a Self-Organizing Map (SOM)
dimension1 = 1;            
dimension2 = 5;            
coverSteps = 100;           
initNeighbor = 3;           
topologyFcn = 'hextop';     
distanceFcn = 'linkdist';   
net = selforgmap([dimension1 dimension2], coverSteps, initNeighbor, topologyFcn, distanceFcn);

% Train the SOM network
net = train(net, x);

% Cluster the data using the trained network
data_cluster = vec2ind(net(x));          
cluster_color = uint8(255 * hsv(max(data_cluster))); 

% Reconstruct the image with cluster colors
colored_image = uint8(zeros(size(image_gray, 1), size(image_gray, 2), 3));
for k = 1:max(data_cluster)
    cluster_pixels = find(data_cluster == k);
    [row, col] = ind2sub(size(image_gray), cluster_pixels);
    for i = 1:length(cluster_pixels)
        colored_image(row(i), col(i), :) = cluster_color(k, :);
    end
end

% Display the colorized image
figure
imshow(colored_image)
title('Colorized Clustering using SOM')
