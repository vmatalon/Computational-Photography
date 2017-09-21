function [y,x,depth] = pyramidResize(one,two)
%PYRAMIDRESIZE Reduces the image size in half until the smallest dimension
%is 150 pixels or less. 
%   The function repeatedly reduces the image's size in half until the 
%   smallest dimension is less than or equal to 150 pixels. 
%   Once this is achieved, the function returns the depth of the pyramid
%   and the x and y offsets for that depth. 

depth = 1;
while min(size(one))>150 % image is larger than threshold
    one = imresize(one,0.5);
    two = imresize(two,0.5);
    depth = depth+1;
end
offsets = (-depth^2):(depth^2);
[y,x] = naiveAlign(offsets,offsets,one,two);

end

