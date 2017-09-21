function [frames] = morph(im1,im1_points,im2,im2_points,frame_count)
%MORPH Morphs between the two images with a specified number of
%intermediate frames. 
%   This function first creates the average shape between the two images
%   and creates the traingulation to be used by calling Matlab's delaunay 
%   function on this average shape. Next, for each frame (from
%   1:frame_count) it creates the intermediate morph by calling
%   intermediateMorph and adds it to the struct of frames. 

%% Initialize values 
%Create frames struct
frames = struct();

%Compute average shape 
average_shape = (im1_points+im2_points)/2;
%Get Delaunay triangulation of average shape 
tri = delaunay(average_shape);

%Create vector of warp & cross-dissolve weights  
weights = 0:1/(frame_count-1):1;

%% Morph frame 
for f = 1:frame_count
    %Compute frame 
    frame = intermediateMorph(im1,im1_points,im2,im2_points,tri,weights(f));
    %Add frame to frames
    frames.(['frame',num2str(f)]) = frame;
end

end

