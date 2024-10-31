clc
clear
close all

n_points = 1000;
rng(0); %seed
x = randn(1, n_points);
y = zeros(1, n_points);

for n = 3:n_points
    y(n) = 0.5 * y(n-1) - 0.1 * y(n-2) + x(n);
end

figure;
subplot(2, 1, 1);
plot(x);
title('Input: Gaussian White Noise');
legend('Input (Gaussian Noise)');

subplot(2, 1, 2);
plot(y, 'Color', [1 0.5 0]);
title('Output of the System');
legend('Output');

sgtitle('System Input and Output');