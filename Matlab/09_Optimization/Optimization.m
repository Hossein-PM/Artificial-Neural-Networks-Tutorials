clc;
clear;
close all;

x = -2:0.02:0.5; % ex: -2:0.02:5;
f = @(x) 0.3*(0.4*x.^4 - 2*x.^3 + x - 7);
grad_f = @(x) 0.3*(4*0.4*x.^3 - 3*2*x.^2 + 1);

% Combined function and gradient for optimizers
func_grad = @(x) deal(f(x), grad_f(x));

plot(x, f(x), 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('f(x)');
title('Function Plot');
hold on;

start_point= 0;
% ex: start_point= -2 + (5 + 2) * rand


% LMS (Quasi-Newton)
lms = fminunc(func_grad, ...
    start_point, optimset('Display', 'off', ...
    'GradObj', 'on', 'Algorithm', ...
    'quasi-newton', 'MaxIter', 1000));
plot(lms, f(lms), 'ro', 'MarkerSize', 8, 'LineWidth', 2);

% LMS with Momentum (using a simpler approach)
momentum = fminunc(@(x) f(x), start_point, optimset('Display', 'off', 'MaxIter', 1000));
plot(momentum, f(momentum), 'go', 'MarkerSize', 12, 'LineWidth', 2);

% Conjugate Gradient (Trust-Region)
cg = fminunc(func_grad, start_point, optimset('Display', 'off', 'GradObj', 'on', 'Algorithm', 'trust-region', 'MaxIter', 10000));
plot(cg, f(cg), 'bo', 'MarkerSize', 16, 'LineWidth', 2);

% Levenberg-Marquardt (Approximated using 'trust-region-dogleg')
levenberg = fminunc(func_grad, start_point, optimset('Display', 'off', 'GradObj', 'on', 'Algorithm', 'trust-region-dogleg', 'MaxIter', 10000));
plot(levenberg, f(levenberg), 'ko', 'MarkerSize', 20, 'LineWidth', 2);

legend('Function', 'LMS Minimum', 'Momentum Minimum', 'Conjugate Gradient Minimum', 'Levenberg-Marquardt Minimum');
