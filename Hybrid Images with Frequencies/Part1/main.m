clear all;
close all;

% Get image names
directory = dir(fullfile(pwd,'*.jpg'));
files = {directory.name}';

% Iterate through all pairs of images to create hybrid images 
for pair = 1:length(files)/2
    % Read images & convert to single 
    im_high = im2single(imread(files{pair*2-1}));
    im_low = im2single(imread(files{pair*2}));
    
    % Convert to grayscale
    im_high = rgb2gray(im_high);
    im_low = rgb2gray(im_low);
    
    % Align the pair of images by selecting 2 points on both images 
    % & crop them to be the same size 
%     [im_high,im_low] = AlignImages(im_high,im_low);
    
    % Choose the cuttoff frequencies for each image 
    cutoff_high = 300;
    cutoff_low = 10;
    
    % Compute the hybrid image
    im_hybrid = HybridImage(im_high,im_low,cutoff_high,cutoff_low);
    figure(pair);
    imshow(im_hybrid);
%     imwrite(im_hybrid,['hybrid',num2str(pair),'.jpg']);
end
