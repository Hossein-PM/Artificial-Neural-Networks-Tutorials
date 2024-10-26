clc
clear
close all

mean_A = 140;
std_dev_A = 15;
mean_B = 120;
std_dev_B = 10;

x = linspace(80, 200, 400);

pdf_A = (1 / (sqrt(2 * pi * std_dev_A^2))) * ...
    exp(-((x - mean_A).^2) / (2 * std_dev_A^2));

pdf_B = (1 / (sqrt(2 * pi * std_dev_B^2))) * ...
    exp(-((x - mean_B).^2) / (2 * std_dev_B^2));

figure;
plot(x, pdf_A, 'r', 'DisplayName', 'Condition A (Hypertension)'); 
hold on;
plot(x, pdf_B, 'b', 'DisplayName', 'Condition B (Normotension)');
title('Probability Density Functions of Blood Pressure');
xlabel('Systolic Blood Pressure (mmHg)');
ylabel('Probability Density');
legend show;
grid on;
clc