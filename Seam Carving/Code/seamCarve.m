function [im_carved,seam_struct] = seamCarve(im,dimension,desired_dimension)
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

im_carved = im;
seam_struct = struct();

%Get image dimensions
[height,width,~] = size(im);

%Calculate number of iterations until done
seams = 0;
if strcmp(dimension,'vertical')
    seams = desired_dimension-height;
elseif strcmp(dimension,'horizontal')
    seams = desired_dimension-width;
else
    disp('Invalid dimension.');
end
seam_sign = sign(seams);

if seam_sign==-1 %Removing seams
    for seam_number = 1:abs(seams)
        im_energy = energize(im_carved,'gradient');
        seam = findSeam(im_energy,dimension);
        im_carved = removeSeam(im_carved,seam,dimension);
        seam_struct.(['s',num2str(seam_number)]) = seam;
    end
else %Adding seams
    disp('Not able to add seams');
%     if strcmp(dimension,'vertical')
%         add_iterations = ceil((seams/height)*2);
%         d = height;
%     else 
%         add_iterations = ceil((seams/width)*2);
%         d = width;
%     end
%     
%     for iteration = 1:add_iterations
%         seam_limit = d*.5*iteration;
%         for seam_number = 1:seam_limit
%             im_energy = energize(im_temp,'gradient');
%             seam = findSeam(im_energy,dimension);
%             im_temp = removeSeam(im_temp,seam,dimension);
%             seam_struct.(['s',num2str(seam_number)]) = seam;
%         end
%         im_carved = addSeams(im_carved,seam_struct,dimension,iteration);
%         im_temp = im_carved;
%     end
end

end

