clc
clear
close all

x= 6* rand(1,1000)- 3;
noise= 0.2* randn(size(x));
y= sin(x)+ noise;
X= [x;y];
x = X;

% Create a Self-Organizing Map
dimension1 = 10;
dimension2 = 1;
coverSteps = 100;
initNeighbor = 3;
topologyFcn = 'hextop';
distanceFcn = 'linkdist';
net = selforgmap([dimension1 dimension2], ...
    coverSteps, initNeighbor, topologyFcn, distanceFcn);

net.plotFcns = {'plotsomtop', 'plotsomnc', 'plotsomnd', ...
    'plotsomplanes', 'plotsomhits', 'plotsompos'};

% Train the Network
net.trainParam.showWindow = 1;
net.trainParam.showCommandLine = 1;
net.trainParam.show = 10;
net.trainParam.epochs = 1000;

[net,tr] = train(net,x);

% Test the Network
y = net(x);

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotsomtop(net)
%figure, plotsomnc(net)
%figure, plotsomnd(net)
%figure, plotsomplanes(net)
figure, plotsomhits(net,x)
figure, plotsompos(net,x)

% Cluster data
data_cluster = vec2ind(net(X));
cluster_center = cell2mat(net.IW);
max_class_number = max(data_cluster);
class_color = prism(max_class_number);
figure;
hold on;
grid minor;
title('SOM Clustering');
for k = 1:max(data_cluster)
    plot(X(1, data_cluster == k), X(2, data_cluster == k), ...
        'o', 'color', class_color(k, :));
end

plot(cluster_center(:,1), cluster_center(:,2), ...
    'Ok', 'linewidth', 5, 'markersize', 10);

% feature extraction
disp(X(:,200)');
disp(net(X(:,200))');
data_cluster = vec2ind(net(X(:,200)));
disp(data_cluster);