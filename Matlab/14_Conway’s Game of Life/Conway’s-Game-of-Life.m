clc
clear
close all

% Initial settings
gridSize = 20;   % Grid size
nGenerations = 50; % Number of generations
p = 0.3;          % Initial probability of being alive

% Create the initial grid
grid = rand(gridSize) < p;

% Display the initial grid with scaling
scaleFactor = 3; % Each point becomes a 3x3 block
scaledGrid = kron(grid, ones(scaleFactor));

figure;
imshow(scaledGrid, []);
title('Conway''s Game of Life - Generation 0');

% SOM Training
gridData = reshape(grid, [], 1); % Flatten the grid to a vector
net = selforgmap([3, 3]);        % Create a 3x3 SOM network
net = train(net, gridData');     % Train SOM based on grid data

% Simulate the Game of Life and evolve
for gen = 1:nGenerations
    % Apply the Game of Life rules to generate the next grid
    grid = gameOfLifeStep(grid);

    % Scale the grid for better visualization
    scaledGrid = kron(grid, ones(scaleFactor));
    
    % Display the scaled grid
    figure;
    imshow(scaledGrid, []);
    title(['Generation ', num2str(gen)]);
    
    pause(0.5);
end

% Conway's Game of Life rules function
function nextGrid = gameOfLifeStep(currentGrid)
    nextGrid = currentGrid;
    for i = 1:size(currentGrid, 1)
        for j = 1:size(currentGrid, 2)
            % Check neighbors of each cell and apply Game of Life rules
            neighbors = sum(sum(currentGrid(mod(i-2, size(currentGrid, 1)) + 1 : mod(i, size(currentGrid, 1)) + 1, ...
                                    mod(j-2, size(currentGrid, 2)) + 1 : mod(j, size(currentGrid, 2)) + 1))) - currentGrid(i,j);

            if currentGrid(i,j) == 1
                if neighbors < 2 || neighbors > 3
                    nextGrid(i,j) = 0;  % Cell dies due to underpopulation or overpopulation
                end
            elseif neighbors == 3
                nextGrid(i,j) = 1;  % Cell is born due to reproduction
            end
        end
    end
end
