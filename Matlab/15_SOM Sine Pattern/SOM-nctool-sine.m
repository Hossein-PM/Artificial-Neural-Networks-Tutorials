clc
clear
close all

x= 6* rand(1,1000)- 3;
noise= 0.2* randn(size(x));
y= sin(x)+ noise;

figure
plot(x, y, '.')

X= [x;y];
nctool