clc
clear
close all

% Load the thyroid dataset
load thyroid_dataset.mat; %help

% Extract input and target data
X = thyroidInputs;
y = thyroidTargets;

% Step 1: Normalize data
X_norm = (X - mean(X, 2)) ./ std(X, 0, 2);

% Step 2: Hebbian-based PCA
[m, n] = size(X_norm);
pca_components = 10;
W = rand(m, pca_components);
alpha_pca = 0.001; %lr
epochs_pca = 500;

for epoch = 1:epochs_pca
    for i = 1:n
        xi = X_norm(:, i);
        yi = W' * xi;
        delta_W = alpha_pca * (xi * yi' - W * (yi * yi')); % Hebbian learning rule
        W = W + delta_W;
    end
end

X_reduced = W' * X_norm;

% Step 3: Train SOM with reduced data
som = selforgmap([10 10]);
som = train(som, X_reduced);
clusters = som(X_reduced);

% Step 4: Map SOM clusters to target classes
[~, predicted_clusters] = max(clusters, [], 1);
[~, true_labels] = max(y, [], 1); %one-hot

% Simple mapping of clusters to actual labels
cluster_to_class = zeros(size(predicted_clusters));
for i = 1:max(predicted_clusters)
    cluster_indices = find(predicted_clusters == i);
    if ~isempty(cluster_indices)
        label_counts = histcounts(true_labels(cluster_indices), 1:4);
        [~, mapped_label] = max(label_counts);
        cluster_to_class(i) = mapped_label;
    end
end
predicted_labels = cluster_to_class(predicted_clusters);

% Step 5: Evaluate accuracy
accuracy = sum(predicted_labels == true_labels) /...
    length(true_labels) * 100;
disp(['Classification Accuracy: ', num2str(accuracy), '%']);
