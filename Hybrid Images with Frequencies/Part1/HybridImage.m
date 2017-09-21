function [im_hybrid] = HybridImage(im_high,im_low,cutoff_high,cutoff_low)
%HYBRIDIMAGE Creates a hybrid image from two images. 
%   This function takes in two images and two cutoff frequencies. It
%   creates two low pass filters (one for each image) and extracts the high
%   frequencies for one of the images (by subtracting the blurred from the
%   original). It then adds these two images together to form a hybrid
%   image. 

%Extract high frequencies from image
dimension_high = floor(sqrt(max(size(im_high))));
gaussian_filter_high = fspecial('gaussian',dimension_high,cutoff_high);%Create filter
im_high_blurred = conv2(im_high,gaussian_filter_high,'same');%Blur image
im_high_filtered = im_high-im_high_blurred;%Get high frequencies

%Extract low frequencies from image
dimension_low = floor(sqrt(max(size(im_low))))/2;
gaussian_filter_low = fspecial('gaussian',dimension_low,cutoff_low);%Create filter
im_low_filtered = conv2(im_low,gaussian_filter_low,'same');%Blur image

%Add high and low to get hybrid
im_hybrid = im_high_filtered+im_low_filtered;

end

