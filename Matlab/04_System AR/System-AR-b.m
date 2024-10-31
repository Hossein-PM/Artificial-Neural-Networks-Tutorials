clc
clear
close all

n_points = 1000;
rng(0);
x = randn(1, n_points);
y = zeros(1, n_points);

for n = 3:n_points
    y(n) = 0.5 * y(n-1) - 0.1 * y(n-2) + x(n);
end

lengths = [30, 50, 100, 150, 200, 300, 500, 1000];
for length = lengths
    
    [weights_ar1, mse_ar1] = fit_ar_model(x(1:length), y(1:length), 1);
    fprintf('AR(1) parameters for length %d: ', length);
    disp(weights_ar1');
    fprintf('MSE AR(1) for length %d: %.4f\n', length, mse_ar1);

    [weights_ar2, mse_ar2] = fit_ar_model(x(1:length), y(1:length), 2); 
    fprintf('AR(2) parameters for length %d: ', length);
    disp(weights_ar2');
    fprintf('MSE AR(2) for length %d: %.4f\n', length, mse_ar2);  
end
