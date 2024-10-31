clc
clear
close all

rng(0);
learning_rate = 0.1;  
n_iterations = 5;
n_inputs = 2;          
n_samples = 100;

x1 = rand(n_inputs, n_samples/2) * 0.3 + 0.5; 
x2 = rand(n_inputs, n_samples/2) * 0.7; 

x= [x1, x2];
y= [zeros(1,50), ones(1,50)];

figure
scatter(x(1, 1:50), x(2, 1:50), 'or')
hold on;
scatter(x(1, 51:100), x(2, 51:100), 'ob')
xlabel('F1: first feature');
ylabel('F2: second feature');

shuffled_indices = randperm(n_samples);
x = x(:, shuffled_indices);
y = y(shuffled_indices);

weights = zeros(n_inputs, 1);
bias = 0;

for iter = 1:n_iterations
    for i = 1:n_samples
        linear_output = x(:,i)' * weights + bias;
        y_pred = 1 * (linear_output > 0);
        update = learning_rate * (y(i) - y_pred);
        weights = weights + update * x(:,i);
        bias = bias + update;
    end
end

disp('Final weights:');
disp(weights);
disp('Final bias:');
disp(bias);

y_pred = zeros(1, n_samples);
for i = 1:n_samples
    linear_output = x(:, i)' * weights + bias;
    y_pred(i) = 1 * (linear_output > 0);
end

scatter(x(1, y_pred == 0), x(2, y_pred == 0), '.r'); 
scatter(x(1, y_pred == 1), x(2, y_pred == 1), '.b');
xlabel('F1: first feature');
ylabel('F2: second feature');
title('Scatter plot of predicted labels');

x_vals = linspace(min(x(1, :)), max(x(1, :)), 100);
y_vals = -(weights(1) * x_vals + bias) / weights(2);
plot(x_vals, y_vals, 'k');
hold off;
