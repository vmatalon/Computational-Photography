%MAIN Iterates through triples of images in the directory and creates 
%blended versions of the first two with the third image as the mask.
%   It does this by creating Laplacian stacks of level 4 of the first two 
%   images and a Gaussian stack of the mask. (To do this it uses the 
%   functions in the directory ../Part2 (it adds them to the path)). It 
%   then calls CombinedLaplacianStack and AddStack to combine them. 
%   Again, it displays the blended images but does not save them. 

%COMBINEDLAPLACIANSTACK Combines the images contained in the stacks to form
%a blended stack. 
%   This function iterates thrugh every level in the inputted stacks and
%   uses the mask stack as weights to smooth the blending. It returns a
%   struct stack of blended levels. 

%ADDSTACK Iterates through the blended stack and adds them to form the
%image mosaic. 
