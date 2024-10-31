clc
clear
close all

n = 100;
x1 = randn(n, 1);
x2 = randn(n, 1);
x3 = randn(n, 1);

y = (2*x1.^2 + 3*x2 + x3) ./ (1 + x1 + x2.^2);

X_quad = [x1.^2, x2.^2, x3, x1.*x2];

a_quad = (X_quad' * X_quad) \ (X_quad' * y);

y_pred_quad = X_quad * a_quad;

MSE_quad = mean((y - y_pred_quad).^2);

disp('Estimated parameters for quadratic model:');
disp(a_quad);

disp('Mean Squared Error for quadratic model:');
disp(MSE_quad);
