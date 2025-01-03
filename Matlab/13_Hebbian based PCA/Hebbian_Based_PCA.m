clc
clear
close all

% Load cancer dataset
load cancer_dataset
data = cancerInputs';  
labels = cancerTargets(1, :)';

% Mean-centering the data
data_mean = mean(data);
data_centered = data - data_mean;

% Parameters
learning_rate = 0.01;
epochs = 100;

% Initialize Hebbian weights randomly (2 principal components)
[num_samples, num_features] = size(data_centered);
weights = randn(num_features, 2);

% Hebbian learning algorithm
for epoch = 1:epochs
    for i = 1:num_samples
        input_vector = data_centered(i, :)';
        output_vector = weights' * input_vector;
        
        weights = weights + learning_rate * ...
            (input_vector * output_vector' - ...
            weights * (output_vector * output_vector'));
    end
end

% Project the data onto the 2 principal components
projected_data = data_centered * weights;

% Assign colors based on class labels
colors = zeros(num_samples, 3);
for i = 1:num_samples
    if labels(i) == 1 % Cancer
        colors(i, :) = [1, 0, 0]; % Red for cancer
    else
        colors(i, :) = [0, 1, 0]; % Green for non-cancer
    end
end

% Visualization
figure;
scatter(projected_data(:, 1), projected_data(:, 2), 50, colors, 'filled');
title('Hebbian-Based PCA Visualization of Cancer Dataset');
xlabel('Principal Component 1');
ylabel('Principal Component 2');
grid on;
