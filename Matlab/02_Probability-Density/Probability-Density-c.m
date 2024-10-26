clc
clear
close all

mean_A = 140;
std_dev_A = 15;
mean_B = 120;
std_dev_B = 10;

sample_size = 500;
hypertension_data = mean_A + ...
    std_dev_A * randn(1, sample_size);
normotension_data = mean_B + ...
    std_dev_B * randn(1, sample_size);

threshold = 130.8;

misclassifications_A = sum(hypertension_data < threshold);
misclassifications_B = sum(normotension_data >= threshold);

total_misclassifications = misclassifications_A + ...
                                        misclassifications_B;
total_samples = sample_size * 2;
error_rate = (total_misclassifications / total_samples) * 100;

disp(['Misclassifications for Condition A (Hypertension): ', ...
    num2str(misclassifications_A)]);
disp(['Misclassifications for Condition B (Normotension): ', ...
    num2str(misclassifications_B)]);
disp(['Total misclassifications: ', num2str(total_misclassifications)]);
disp(['Error rate (%): ', num2str(error_rate)]);