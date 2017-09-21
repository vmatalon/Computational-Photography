function [y,x] = pyramidAlign(one,two)
%PYRAMIDALIGN Calculates the x & y offsets needed to align the second image
%to the first. 
%   In order to do this, the function calls pyramidResize which repeatedly 
%   reduces the image's size in half until the smallest dimension is less 
%   than or equal to 150 pixels. 
%   Once this is done, the function scales the offsets calculated and uses
%   a smaller range of offsets on the next most fine-grained level until it
%   reached the original image. 

[offset_y,offset_x,depth] = pyramidResize(one,two);
depth = depth-1;
offset_y = offset_y*2;
offset_x = offset_x*2;

while depth>=1
    % determine window of offsets to iterate over
    offsets = (-depth^2):(depth^2);
    offsets_y = offsets+(abs(offset_y)*sign(offset_y));
    offsets_x = offsets+(abs(offset_x)*sign(offset_x));
    
    % resize original image
    one_resized = imresize(one,1/(2^(depth-1)));
    two_resized = imresize(two,1/(2^(depth-1)));
    
    % calculate offsets using naive algorithm
    [offset_y,offset_x] = naiveAlign(offsets_y,offsets_x,one_resized,...
        two_resized);
    
    % rescale offsets
    offset_y = offset_y*2;
    offset_x = offset_x*2;
    
    % decrease depth 
    depth = depth-1;
end

[y,x] = naiveAlign(offsets_y,offsets_x,one,two);
    
end

