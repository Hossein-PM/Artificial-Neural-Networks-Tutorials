clc;
clear;
close all;

rng(0)
num_samp= 250;
mu1 = [2, 2];  
mu2 = [2, 2];
sigma1 = [2, -1.5; -1.5, 2]; 
sigma2 = [2, 1.5; 1.5, 2];  

class1 = mvnrnd(mu1, sigma1, num_samp); 
class2 = mvnrnd(mu2, sigma2, num_samp); 

% Combine the data
data = [class1; class2];
labels = [ones(num_samp,1); 2*ones(num_samp,1)];

% Apply PCA
[coeff, score, ~] = pca(data);

% Project data onto the first two principal components
data_pca = score(:, 1:2);

% Plot the original data (before PCA)
subplot(1, 2, 1);
gscatter(data(:,1), data(:,2), labels, 'rb', 'xo');
title('Original Data');

% Plot the data after PCA (using the first two components)
subplot(1, 2, 2);
gscatter(data_pca(:,1), data_pca(:,2), labels, 'rb', 'xo');
title('Data after PCA');
