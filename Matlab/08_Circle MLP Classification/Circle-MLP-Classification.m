clc
clear
close all

x_c = 3;
y_c = 4;
r = 2;
num_points = 500;
x = rand(num_points, 1) * 6; 
y = rand(num_points, 1) * 6; 
labels = ((x - x_c).^2 + (y - y_c).^2 <= r^2);

figure;
scatter(x(labels == 1), y(labels == 1), 'r'); 
hold on; 
scatter(x(labels == 0), y(labels == 0), 'b');
viscircles([x_c y_c], r, 'LineStyle', '--');
xlabel('x');
ylabel('y');
title('Training Data');

inputs = [x, y]';
targets = labels';

net = feedforwardnet([10, 10]);
net = train(net, inputs, targets);

[x_grid, y_grid] = meshgrid(0:0.1:6, 0:0.1:6);
grid_points = [x_grid(:), y_grid(:)]';
predictions = net(grid_points);
predictions = reshape(predictions, size(x_grid));

figure;
contourf(x_grid, y_grid, predictions, [0.5 0.5], 'k'); 
hold on;
scatter(x(labels == 1), y(labels == 1), 'r');
scatter(x(labels == 0), y(labels == 0), 'b');
viscircles([x_c y_c], r, 'LineStyle', '--');
xlabel('x');
ylabel('y');
title('Decision Boundary');
