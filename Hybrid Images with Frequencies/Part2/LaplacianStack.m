function [laplacian_stack] = LaplacianStack(gaussian_stack)
%LAPLACIANSTACK Makes a Laplacian stack from the inputted Gaussian stack. 
%   This function takes in a Gaussian stack and iteratively subtracts the 
%   current level from the level below it until it reaches the last level.
%   the last level is the same in both stacks. 

names = fieldnames(gaussian_stack);
levels = length(names);
laplacian_stack = struct();

for level = 1:levels-1
    laplacian_stack.(names{level}) = ...
        gaussian_stack.(names{level})-gaussian_stack.(names{level+1});
end
laplacian_stack.(names{levels}) = gaussian_stack.(names{levels});

end

