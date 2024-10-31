clc
clear
close all

X = [0 0; 0 1; 1 0; 1 1];
y = [0; 0; 0; 1]; 

% Parameters
learning_rate = 0.01;
n_iterations = 50;
[n_samples, n_inputs] = size(X);

% Initialize weights and bias to zero
weights = zeros(n_inputs, 1);
bias = 0;

% Training the Adaline model
for iter = 1:n_iterations
    for i = 1:n_samples
        % Calculate linear output for each sample
        linear_output = X(i, :) * weights + bias;
        
        % Activation function (linear Function)
        y_pred = linear_output;
        
        % Calculate the update for weights and bias
        update = learning_rate * (y(i) - y_pred);
        
        % Update weights and bias
        weights = weights + update * X(i, :)';
        bias = bias + update;
    end
end

% Display final weights and bias
disp("Final weights:");
disp(weights);
disp("Final bias:");
disp(bias);

% Making predictions with the trained Adaline model
Y_pred = zeros(n_samples, 1);
for i = 1:n_samples
    linear_output = X(i, :) * weights + bias;
    if linear_output > 0.5           % Threshold of 0.5 for final output
        Y_pred(i) = 1;
    else
        Y_pred(i) = 0;
    end
end

% Display final results
disp("Adaline for AND gate:");
disp(Y_pred);
