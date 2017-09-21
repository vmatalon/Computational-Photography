function [pixel_map] = roundPixelMap(unrounded_pixels,rows,cols)
%ROUNDPIXELMAP Rounds the pixels that are inputted and makes sure that all
%pixels are in the range from 1 to the dimension of the image. 
    pixel_map = round(unrounded_pixels);
    for i = 1:size(unrounded_pixels,2)
        pixel_map(:,i) = max(min(pixel_map(:,i),[cols,rows,1]'),ones(3,1));
    end

end
