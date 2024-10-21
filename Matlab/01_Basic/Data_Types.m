clc
clear
close all

%% Scalar
scalar_value = 5;
disp(['Scalar: ', num2str(scalar_value)]);

%% Matrix and Array
%clc
matrix_value = [1, 2, 3; 
    4, 5, 6; 
    7, 8, 9];
disp('Matrix:');
disp(matrix_value);
disp(['Element from matrix (row 2, col 1): ', ...
    num2str(matrix_value(2,1))]);

%% String
%clc
string_value = 'Hello world';
disp(['String: ', string_value]);
disp(['First character of string: ', ...
    string_value(1)]);

%% Cell Array
%clc
cell_value = {1, 'MATLAB', [1, 2, 3]};
disp('Cell Array:');
disp(cell_value);
disp(['Second element of cell array: ', cell_value{2}]);

%% Struct
%clc
student.name = 'Amir';
student.age = 27;
student.grades = [90, 85, 88];
disp('Struct:');
disp(student);
disp(['Student name: ', student.name]);

%% Logical
%clc
logical_value = true;
disp(['Logical: ', num2str(logical_value)]);
disp(['Logical value as number: ', num2str(logical_value)]);

%% Table
%clc
names = {'Ali'; 'Sara'; 'Reza'};
ages = [23; 22; 24];
grades = [90, 85, 88; 78, 82, 80; 85, 87, 89];
table_value = table(names, ages, grades);
disp('Table:');
disp(table_value);
disp(['First person''s name: ', names{1}]);