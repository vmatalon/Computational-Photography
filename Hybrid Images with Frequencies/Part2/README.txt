%MAIN Creates and displays the stacks for all images in the directory.
%    It does this by calling the other 3 functions in this folder. 
%    It displays the stacks, but does not save them. 

%GAUSSIANSTACK Creates a Gaussian stack for the inputted image that has the
%specified number of levels. 
%   This functions creates a Gaussian stack by convolving a padded version 
%   of the original image with a Gaussian filter whose dimensions are a 
%   function of the image's largest dimension and whose standard deviation 
%   increases exponentially with each level. 
%   The stack is made as a struct and each level is a field in the struct.

%LAPLACIANSTACK Makes a Laplacian stack from the inputted Gaussian stack. 
%   This function takes in a Gaussian stack and iteratively subtracts the 
%   current level from the level below it until it reaches the last level.
%   the last level is the same in both stacks. 

%DISPLAYSTACKS Displays both stacks that are inputted as arguments. 
%   This function knows that main is calling the stack functions with 6
%   levels and so it displays the first 5 levels of each stack in their own
%   figure. Since the function will be called on multiple images it takes
%   in the iteration the loop (in main) is on so that each stack can have a
%   unique figure assigned to it. 