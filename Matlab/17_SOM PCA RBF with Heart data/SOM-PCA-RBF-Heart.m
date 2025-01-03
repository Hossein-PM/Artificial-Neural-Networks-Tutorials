clc
clear
close all
rng(0)

% Step 1: Load the dataset
data = readtable('heart.csv');

% Step 2: Split data into features and labels
X = table2array(data(:, 1:end-1));
y = table2array(data(:, end));

% Step 3: Standardize the data
X_scaled = zscore(X);

% Step 4: Reduce dimensionality using PCA
[coeff, X_pca] = pca(X_scaled, 'NumComponents', 2);

% Step 5: Use MiniSom for clustering
somX = 10; somY = 10;
som = selforgmap([somX, somY], 100, 3, 'hextop', 'linkdist');
som = train(som, X_pca');

% Assign clusters to the data
outputs = som(X_pca');
som_clusters = vec2ind(outputs)';
som_cluster_labels = cellstr(string(som_clusters));

% Step 6: Split data into training and testing sets
cv = cvpartition(size(X_pca, 1), 'HoldOut', 0.2);
train_idx = training(cv);
test_idx = test(cv);

X_train = X_pca(train_idx, :);
X_test = X_pca(test_idx, :);
y_train = y(train_idx);
y_test = y(test_idx);

% Step 7: Use RBF kernel for classification
model = fitcsvm(X_train, y_train, ...
    'KernelFunction', 'rbf', 'KernelScale', 'auto');
y_pred_test = predict(model, X_test);
y_pred_train = predict(model, X_train);

% Compute accuracies
accuracy_test = sum(y_pred_test == y_test) /...
    numel(y_test);
accuracy_train = sum(y_pred_train == y_train) / ...
    numel(y_train);

disp(['Train Accuracy: ', num2str(accuracy_train)]);
disp(['Test Accuracy: ', num2str(accuracy_test)]);

% Visualization
scatter(X_pca(:, 1), X_pca(:, 2), 25, y, 'filled');
colormap('parula');
title('PCA Visualization');
grid on;
