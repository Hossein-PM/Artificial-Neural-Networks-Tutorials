clc
clear
close all

% Load dataset
load bodyfat_dataset;

X = bodyfatInputs';  % Features
y = bodyfatTargets'; % Targets

% Split data into 80% for training and 20% for testing
cv = cvpartition(size(X, 1), 'HoldOut', 0.2);
X_train = X(training(cv), :);
y_train = y(training(cv), :);
X_test = X(test(cv), :);
y_test = y(test(cv), :);

% PCA for dimensionality reduction on training data
[coeff, X_train_reduced, ~, ~, explained] = pca(X_train);

% Select number of components based on explained variance
var_threshold = 95;
cumulative_variance = cumsum(explained);
num_components = find(cumulative_variance >= var_threshold, 1);
X_train_reduced = X_train_reduced(:, 1:num_components);

% Train SOM on the reduced training data
som = selforgmap([15 15], 100, 3, 'hextop', 'linkdist');
som.trainParam.epochs = 200;
som = train(som, X_train_reduced');

% SOM output and label assignment for training data
output_train = som(X_train_reduced');
output_labels_train = vec2ind(output_train)';

% Train SVM regression model
mdl = fitrsvm(output_labels_train, y_train, 'KernelFunction', 'gaussian', 'Standardize', true);

% Prediction for test data
X_test_reduced = (X_test - mean(X_train)) * coeff(:, 1:num_components);
output_test = som(X_test_reduced');
output_labels_test = vec2ind(output_test)';
y_pred = predict(mdl, output_labels_test);

% Model performance on test data
mse = mean((y_test - y_pred).^2);
rmse = sqrt(mse);

% Percentage error
error_percentage = (rmse / (max(y_test) - min(y_test))) * 100;

% Print results
fprintf('Root Mean Squared Error (RMSE) on test data: %.2f\n', rmse);
fprintf('Percentage error on test data: %.2f%%\n', error_percentage);
