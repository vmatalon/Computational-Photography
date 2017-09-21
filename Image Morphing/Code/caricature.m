function [frames] = caricature(im,im_points,other_points,frame_count)
%CARICATURE Makes a caricature of the image by extrapolating it from the
%specified shape
%   This function produces a struct of frames from the extrapolation of
%   the image. The weights that are used are no longer between 0 and 1, 
%   they are between 0 and 2. 

%% Initialize values 
%Create frames struct
frames = struct();

%Compute average shape 
average_shape = (im_points+other_points)/2;
%Get Delaunay triangulation of average shape 
tri = delaunay(average_shape);

%Create vector of warp & cross-dissolve weights  
weights = 0:2/(frame_count-1):2;
% weights = -2:2/(frame_count-1):0;

%% Morph frame 
for f = 1:frame_count
    weight = weights(f);
    warp_points = ((1-weight)*im_points)+(weight*other_points);
    
    %Compute frame 
    frame = warpImage(im,im_points,warp_points,tri);
    %Add frame to frames
    frames.(['frame',num2str(f)]) = frame;
end

end

