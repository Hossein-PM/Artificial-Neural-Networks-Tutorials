clc
clear
close all

mean_A = 140;
std_dev_A = 15;
mean_B = 120;
std_dev_B = 10;

x_values = linspace(80, 200, 400);

threshold = NaN;
for x = x_values
    p_A = normpdf(x, mean_A, std_dev_A);
    p_B = normpdf(x, mean_B, std_dev_B);
    if abs((p_A - p_B)/(p_A + p_B)) < 0.01 
        threshold = x;
        break;
    end
end

p_error_A = normcdf(threshold, mean_A, std_dev_A);
p_error_B = 1 - normcdf(threshold, mean_B, std_dev_B);

disp(['Decision threshold: ', num2str(threshold)]);
disp(['Misclassification probability for Condition A: ', num2str(p_error_A)]);
disp(['Misclassification probability for Condition B: ', num2str(p_error_B)]);

if p_error_A > p_error_B
    disp('Condition A (Hypertension) is more prone to misclassification.');
else
    disp('Condition B (Normotension) is more prone to misclassification.');
end