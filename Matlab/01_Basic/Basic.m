% help
help
clc
help plot

% who & whos
clc
a= 5; b= 6;
who
clc
whos

% format long vs short
clc
pi
format short
c= sin(pi/4)
format long
c= sin(pi/4)
format short

% ellipsis
clc
2+ 3 *(3-5)^2 ...
    +200

% round
clc
round(pi)
round(22.9999)

% random
clc
rand
clc
low= 5;
high= 22;
rand*(high- low)+ low
clc
round(rand*(high- low)+ low)

% figure
clc
figure
figure
figure
plot([1,2,4,3])