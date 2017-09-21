function [morphed_image] = intermediateMorph(im1,im1_points,im2,im2_points,...
    tri,weight)
%INTERMEDIATEMORPH Computes the morphed image of im1 and im2 given their
%points, the triangulation, and the weight to use. 
%   This function makes sure the number of correspoinding points are the
%   same and assumes both images are the same size. Next, it warps
%   the two images in parallel by calling the warpImage function on each
%   image. Finally, it cross-dissolves them by calling crossDissolve in
%   order to produce the morphed image. 

%% Make sure correspondence is correctly defined
assert(isequal(size(im1_points),size(im2_points)),...
    'Points do not correspond!');

%% Initialize values 
[rows,cols,~] = size(im1);
im1_warped = zeros(rows,cols,3);
im2_warped = zeros(rows,cols,3);
warp_points = ((1-weight)*im1_points)+(weight*im2_points); %warp shape

%% Warp images in parallel 
parfor i = 1:2
    if i==1
        im1_warped = im1_warped+warpImage(im1,im1_points,warp_points,tri);
    else 
        im2_warped = im2_warped+warpImage(im2,im2_points,warp_points,tri);
    end
end

%% Cross-Dissolve to get morph
morphed_image = crossDissolve(im1_warped,im2_warped,weight);

end