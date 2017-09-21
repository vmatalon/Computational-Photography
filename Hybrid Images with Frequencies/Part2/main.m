close all;

%Get image names
directory = dir(fullfile(pwd,'*.jpg'));
files = {directory.name}';

for im_index = 1:length(files)
    %Get image
    im_name = files{im_index};
    im = im2single(imread(im_name));
    im = rgb2gray(im);
    
    %Create stacks 
    levels = 6;
    gaussian_stack = GaussianStack(im,levels);
    laplacian_stack = LaplacianStack(gaussian_stack);
    DisplayStacks(gaussian_stack,laplacian_stack,im_index);
end