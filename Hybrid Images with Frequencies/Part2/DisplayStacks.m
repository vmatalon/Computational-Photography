function [] = DisplayStacks(gaussian_stack,laplacian_stack,iteration)
%DISPLAYSTACKS Displays both stacks that are inputted as arguments. 
%   This function knows that main is calling the stack functions with 6
%   levels and so it displays the first 5 levels of each stack in their own
%   figure. Since the function will be called on multiple images it takes
%   in the iteration the loop (in main) is on so that each stack can have a
%   unique figure assigned to it. 

%Display Gaussian Stack 
figure(iteration*2-1);
imagesc([gaussian_stack.level1,gaussian_stack.level2,gaussian_stack.level3,...
    gaussian_stack.level4,gaussian_stack.level5]),...
    colormap gray, axis off;

%Display Laplacian Stack 
figure(iteration*2);
imagesc([laplacian_stack.level1,laplacian_stack.level2,laplacian_stack.level3,...
    laplacian_stack.level4,laplacian_stack.level5]),...
    colormap gray, axis off;

end

