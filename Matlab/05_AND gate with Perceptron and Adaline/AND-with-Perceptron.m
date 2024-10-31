clc
clear
close all

% Parameters
learning_rate = 0.01;  
n_iterations = 5;  % 1:5
n_inputs = 2;          
n_samples = 4;         

% Input data (e.g., AND gate)
X = [0 0; 0 1; 1 0; 1 1];
Y_d = [0; 0; 0; 1];

% Initialize weights and bias
weights = zeros(n_inputs, 1);
bias = 0;

% Train perceptron
for iter = 1:n_iterations
    for i = 1:n_samples
        % Linear output
        linear_output = X(i, :) * weights + bias;
        
        % Activation function (Step Function)
        y_pred = 1 * (linear_output > 0);
        
        % Update weights and bias
        update = learning_rate * (Y_d(i) - y_pred);
        weights = weights + update * X(i, :)';
        bias = bias + update;
    end
end

% Display final weights and bias
disp('Final weights:');
disp(weights);
disp('Final bias:');
disp(bias);

% Test perceptron
Y_pred = zeros(n_samples, 1);
for i = 1:n_samples
    linear_output = X(i, :) * weights + bias;
    Y_pred(i) = 1 * (linear_output > 0);
end

% Display predicted outputs
disp('Predicted outputs:');
disp(Y_pred);
