close all;

%Get files from Part2
here = pwd;
cd ..
cd(fullfile(pwd,'Part2'));
addpath(pwd);
cd(here);

%Get image names
directory = dir(fullfile(pwd,'*.jpg'));
files = {directory.name}';

for index = 1:length(files)/3
    %Get images
    im1 = im2single(imread(files{index*3-2}));
    im2 = im2single(imread(files{index*3-1}));
    mask = im2single(imread(files{index*3}));
    %Make B&W
    im1 = rgb2gray(im1);
    im2 = rgb2gray(im2);
    
    %Create Stacks
    laplacian_stack_im1 = LaplacianStack(GaussianStack(im1,4));
    laplacian_stack_im2 = LaplacianStack(GaussianStack(im2,4));
    gaussian_stack_mask = GaussianStack(mask,4);
    
    laplacian_stack_combined = CombinedLaplacianStack(...
        laplacian_stack_im1,laplacian_stack_im2,gaussian_stack_mask);
    
    mosaic = AddStack(laplacian_stack_combined);
    figure(index);
    imshow(mosaic);
%     imwrite(mosaic,['mosaic',num2str(index),'.jpg']);
end