%MAIN creates hybrid images for pairs of images in folder. 
%   It does this by aligning images and then setting the cuttoffs for each 
%   frequency and then calling HybridImages.
%   It displays the hybrid images, but does not save them.

%ALIGNIMAGES was provided.

%HYBRIDIMAGE Creates a hybrid image from two images. 
%   This function takes in two images and two cutoff frequencies. It
%   creates two low pass filters (one for each image) and extracts the high
%   frequencies for one of the images (by subtracting the blurred from the
%   original). It then adds these two images together to form a hybrid
%   image. 