clc
clear
close all

% Parameters
learning_rate = 0.01;  
n_iterations = 1000;   
n_inputs = 3;          
n_hidden_neurons = 4;  
n_samples = 50;       

rng(0);  % seed
X = [randi([20, 80], n_samples, 1), ...   
      randi([90, 180], n_samples, 1), ...  
      randi([150, 300], n_samples, 1)];      

% Generate balanced binary target output
Y_d = [zeros(n_samples/2, 1); ones(n_samples/2, 1)];
Y_d = Y_d(randperm(n_samples));  % Shuffle to randomize

% Initialize weights and biases
weights_input_hidden = rand(n_inputs, n_hidden_neurons) * 0.1 - 0.05;
bias_hidden = rand(1, n_hidden_neurons) * 0.1 - 0.05;
weights_hidden_output = rand(n_hidden_neurons, 1) * 0.1 - 0.05;
bias_output = rand(1) * 0.1 - 0.05;

% Sigmoid activation function and its derivative
sigmoid = @(x) 1 ./ (1 + exp(-x));
sigmoid_derivative = @(x) x .* (1 - x);

% Training process
for iter = 1:n_iterations
    for i = 1:n_samples
        % Forward pass
        hidden_input = X(i, :) * weights_input_hidden + bias_hidden;
        hidden_output = sigmoid(hidden_input);
        
        output_input = hidden_output * weights_hidden_output + bias_output;
        output = sigmoid(output_input);

        % Calculate error
        error = Y_d(i) - output;
        
        % Backpropagation
        d_output = error * sigmoid_derivative(output);
        
        error_hidden = d_output * weights_hidden_output';
        d_hidden = error_hidden .* sigmoid_derivative(hidden_output);
        
        % Update weights and biases
        weights_hidden_output = weights_hidden_output + ...
            learning_rate * (hidden_output' * d_output);
        bias_output = bias_output + learning_rate * d_output;
        
        weights_input_hidden = weights_input_hidden + ...
            learning_rate * (X(i, :)' * d_hidden);
        bias_hidden = bias_hidden + learning_rate * d_hidden;
    end
end

% Testing the network
Y_pred = zeros(n_samples, 1);
for i = 1:n_samples
    hidden_input = X(i, :) * weights_input_hidden + bias_hidden;
    hidden_output = sigmoid(hidden_input);
    
    output_input = hidden_output * weights_hidden_output + bias_output;
    Y_pred(i) = sigmoid(output_input) > 0.5;
end

% Calculate overall accuracy
accuracy = mean(Y_pred == Y_d) * 100;
fprintf('Overall network accuracy: %.2f%%\n', accuracy);
