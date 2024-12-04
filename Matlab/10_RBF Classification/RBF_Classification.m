clc;
clear;
close all;

X = [randn(500,2)+2; 
       randn(500,2)-2];
y = [ones(500,1); 
      -ones(500,1)];

cv = cvpartition(size(X,1),'HoldOut',0.2);
idx = cv.test;
X_train = X(~idx,:);
y_train = y(~idx,:);
X_test = X(idx,:);
y_test = y(idx,:);

gamma_values = [0.1, 1, 10, 100];
models = cell(length(gamma_values),1);

for i = 1:length(gamma_values)
    models{i} = fitcsvm(X_train, y_train, ...
    'KernelFunction', 'rbf', 'KernelScale', ...
    1/sqrt(2*gamma_values(i)));
end

x_min = min(X(:,1)) - 1;
x_max = max(X(:,1)) + 1;
y_min = min(X(:,2)) - 1;
y_max = max(X(:,2)) + 1;
[xx, yy] = meshgrid(...
    linspace(x_min, x_max, 200), ...
    linspace(y_min, y_max, 200));

figure;
for i = 1:length(gamma_values)
    subplot(1,4,i);
    Z = predict(models{i}, [xx(:), yy(:)]);
    Z = reshape(Z, size(xx));
    contourf(xx, yy, Z, 'LineColor',...
        'none', 'LevelStep', 0.5);
    hold on;
    
    scatter(X_train(y_train == 1, 1), ...
        X_train(y_train == 1, 2), 30, 'r', 's');
    scatter(X_train(y_train == -1, 1), ...
        X_train(y_train == -1, 2), 30, 'b', '^');
    scatter(X_test(y_test == 1, 1), ...
        X_test(y_test == 1, 2), 30, 'r', 's');
    scatter(X_test(y_test == -1, 1), ...
        X_test(y_test == -1, 2), 30, 'b', '^');
    
    colormap('cool');
    title(sprintf('Gamma: %.1f', gamma_values(i)));
    xlabel('Feature 1');
    ylabel('Feature 2');
    hold off;
end
