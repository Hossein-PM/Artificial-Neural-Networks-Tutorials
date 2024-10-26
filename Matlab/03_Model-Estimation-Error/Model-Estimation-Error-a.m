clc
clear
close all

n = 100;
x1 = randn(n, 1);
x2 = randn(n, 1);
x3 = randn(n, 1);

y = (2*x1.^2 + 3*x2 + x3) ./ (1 + x1 + x2.^2);

X = [x1, x2, x3];

a = (X' * X) \ (X' * y);

y_pred = X * a;

MSE = mean((y - y_pred).^2);

disp('Estimated parameters:');
disp(a);

disp('Mean Squared Error:');
disp(MSE);
