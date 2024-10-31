clc
clear
close all

mean_A_BP = 140;
std_dev_A_BP = 15;
mean_A_Chol = 240;
std_dev_A_Chol = 30;

mean_B_BP = 120;
std_dev_B_BP = 10;
mean_B_Chol = 180;
std_dev_B_Chol = 20;

sample_size = 500;

hypertension_BP = mean_A_BP + ...
    std_dev_A_BP * randn(1, sample_size);
normotension_BP = mean_B_BP + ...
    std_dev_B_BP * randn(1, sample_size);

hypertension_Chol = mean_A_Chol + ...
    std_dev_A_Chol * randn(1, sample_size);
normotension_Chol = mean_B_Chol + ...
    std_dev_B_Chol * randn(1, sample_size);

x_BP = linspace(80, 200, 400);
pdf_A_BP = normpdf(x_BP, mean_A_BP, std_dev_A_BP);
pdf_B_BP = normpdf(x_BP, mean_B_BP, std_dev_B_BP);

figure;

subplot(1, 2, 1);
plot(x_BP, pdf_A_BP, 'r', 'DisplayName', 'Hypertension');
hold on;
plot(x_BP, pdf_B_BP, 'b', 'DisplayName', 'Normotension');
title('Blood Pressure Probability Density Functions');
xlabel('Blood Pressure (mmHg)');
ylabel('Probability Density');
legend show;

x_Chol = linspace(100, 300, 400);
pdf_A_Chol = normpdf(x_Chol, mean_A_Chol, std_dev_A_Chol);
pdf_B_Chol = normpdf(x_Chol, mean_B_Chol, std_dev_B_Chol);

subplot(1, 2, 2);
plot(x_Chol, pdf_A_Chol, 'r', 'DisplayName', 'Hypertension');
hold on;
plot(x_Chol, pdf_B_Chol, 'b', 'DisplayName', 'Normotension');
title('Cholesterol Probability Density Functions');
xlabel('Cholesterol (mg/dL)');
ylabel('Probability Density');
legend show;

figure;
scatter(hypertension_BP, hypertension_Chol, 'r', ...
    'DisplayName', 'Hypertension', 'MarkerFaceAlpha', 0.5);

hold on;
scatter(normotension_BP, normotension_Chol, 'b', ...
    'DisplayName', 'Normotension', 'MarkerFaceAlpha', 0.5);

title('Scatter Plot of Blood Pressure and Cholesterol Levels');
xlabel('Blood Pressure (mmHg)');
ylabel('Cholesterol (mg/dL)');
legend show;
grid on;