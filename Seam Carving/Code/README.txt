%MAIN Iterates through all the pictures in the directory and seam carves them.
%   In order to do this, the function sets the dimension ('horizontal' or 
%   'vertical) and desired_dimension (number of pixels that dimension 
%   should be) and calls the seamCarve function. 
%   It then displays the files (saving them has been commented out 
%   for grading purposes).

%MAINADD Is the same as main, but the desired_dimension is set to something
%that requires adding seams as opposed to removing seams (b&w).

%SEAMCARVE Seam carves an image along some dimension until it reaches the 
%desired dimension.
%   This function takes in an image, the dimension to carve along, and the
%   desired dimension.
%   In order to remove seams, the function repeatedly calculates the energy
%   of all pixels in the current iteration of im_carved (using the energize
%   function: default type='gradient') finds the seam using findSeam, and 
%   then removes it with the removeSeam function.
%   In order to add seams, the function calculates how many steps the
%   process will be broken into such that no chunk enlarges the image by
%   more than 50%. It then removes seams from a temp image and then adds
%   those seams back to the image by calling addSeams.
%   It saves all the seams found in a struct which is the second output
%   of the function.

%ENERGIZE Calculates the importance of each pixel using an energy function.
%   This function calculates the importance of each pixel in the inputted
%   image using the energy function specified by the type argument (which
%   can be:
%       gradient = (e1) L1 & L2 norm of the gradient, saliency measure
%           calculated with the help of the gradient function 
%       entropy = adds entropy over a 9x9 window and adds it to e1
%           calculated with the help of the entropyfilt function 
%       histogram = histogram of oriented edges
%           calculated with the help of the imhist function 

%FINDSEAM Uses dynamic programming to find the lowest-energy seam for 
%carving along the desired dimension. 
%   This function takes in an energy representation of the image and the
%   desired dimension along which it shall find the seam. The process is
%   twofold: first, the function iterates through all pixels starting from
%   the second row/column and computes the cumulative energy for all
%   pixels & next, it backtracks from the pixel with the least cumulative
%   energy in the last row/column recording the indeces of the pixels that
%   form a part of the optimal seam (breaking ties by returning the index 
%   with the lowest value).


%REMOVESEAM Removes a seam from the image such that carving occurs along 
%the desired dimension. 
%   This function removes the seam from according to the dimension specified by
%   iterating through all rows/columns and adding the image information before
%   and after the index specified in seam to a carved version of the
%   image, which it will then return.

