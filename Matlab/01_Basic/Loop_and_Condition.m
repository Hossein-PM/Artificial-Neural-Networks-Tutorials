clc
clear
close all

% for
user_list = {'amir', 'mobina', 'ali'};
for i = 1:length(user_list)
    disp(['Welcome, ' user_list{i}])
end

% if
clc
num= 12;
if num> 10
    disp('ok')
end
clc
name= 'amir';
strcmp(name, 'amir')

% else if
clc
time_hour= 5;
symptom= 'fever';

if time_hour >= 0 && time_hour <= 24
    disp('Checking patient status...')
    if strcmp(symptom, 'sleepy') && time_hour < 10
        disp('Suggesting rest and light medication')
    elseif strcmp(symptom, 'fever') || time_hour < 2
        disp('Suggesting fever medication and hydration')
    elseif strcmp(symptom, 'pain') && time_hour >= 8
        disp('Suggesting pain relief medication')
    else
       disp('Suggesting routine check and water intake')
    end
end
