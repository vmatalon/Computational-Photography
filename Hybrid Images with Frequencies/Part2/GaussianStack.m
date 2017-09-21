function [gaussian_stack] = GaussianStack(im,levels)
%GAUSSIANSTACK Creates a Gaussian stack for the inputted image that has the
%specified number of levels. 
%   This functions creates a Gaussian stack by convolving a padded version 
%   of the original image with a Gaussian filter whose dimensions are a 
%   function of the image's largest dimension and whose standard deviation 
%   increases exponentially with each level. 
%   The stack is made as a struct and each level is a field in the struct.

gaussian_stack = struct();

gaussian_stack.level1 = im;
for level = 2:levels
    dimension = floor(sqrt(max(size(im)))*1.5);
    sigma = power(2,level);
    gaussian_filter = fspecial('gaussian',dimension,sigma); %Create Filter 
    padded = padarray(im,[dimension,dimension],'symmetric'); %Pad image
    padded_blurred = conv2(padded,gaussian_filter,'same'); %Blur padded image
    im_blurred = padded_blurred(dimension:end-1-dimension,...
        dimension:end-1-dimension);
    gaussian_stack.(['level',num2str(level)]) = im_blurred; %Add to stack
end

end

