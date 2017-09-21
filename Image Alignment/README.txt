Vanessa Matalon 

%MAIN Calls the needed functions to align the color channels.
%
%ALIGNCOLORS Aligns the first color channel to the second. 
%   This function contains a naive, single-scale implementation of the SSD 
%   and NCC metrics and a multi-scale implementation of the NCC metric
%   using an image pyramid. 
%
% 
%NAIVEALIGN Calculates the x and y offset values. 
%   This function calculates x and y displacement when aligning the second 
%   color channel to the first using the SSD. 
%   The displacement values are limited to the ones found in the argument 
%   displacements. 
%
%PYRAMIDRESIZE Reduces the image size in half until the smallest dimension
%is 150 pixels or less. 
%   The function repeatedly reduces the image's size in half until the 
%   smallest dimension is less than or equal to 150 pixels. 
%   Once this is achieved, the function returns the depth of the pyramid
%   and the x and y offsets for that depth. 
%
%PYRAMIDALIGN Calculates the x & y offsets needed to align the second image
%to the first. 
%   In order to do this, the function calls pyramidResize which repeatedly 
%   reduces the image's size in half until the smallest dimension is less 
%   than or equal to 150 pixels. 
%   Once this is done, the function scales the offsets calculated and uses
%   a smaller range of offsets on the next most fine-grained level until it
%   reached the original image. 