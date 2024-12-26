clc
clear
% close all

%% Load and preprocess image
% picture= 'mandrill.png';
picture= 'peppers.png';
img = imread(picture);
img_gray = rgb2gray(img);
img_double = double(img_gray);

%% Apply PCA
[coeff, score, latent] = pca(img_double);
num_components = 10; %3, 10, 20, 50;

%% Reconstruct image
reconstructed_img = score(:, 1:num_components) * ...
    coeff(:, 1:num_components)' + mean(img_double);

%% Display images
figure;
subplot(1, 2, 1);
imshow(uint8(img_double));
title('Original Image');

subplot(1, 2, 2);
imshow(uint8(reconstructed_img));
title(['Reconstructed Image with ', ...
    num2str(num_components), ' Components']);
