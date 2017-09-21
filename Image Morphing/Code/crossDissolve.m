function [blend] = crossDissolve(im1,im2,weight)
%CROSSDISSOLVE Computes a weighted average of two images.
%   This function creates a blended image by adding im1*(1-weight) and
%   im2*weight. 

blend = (im1*(1-weight))+(im2*weight);

end

