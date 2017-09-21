function [im_carved] = removeSeam(im,seam,dimension)
%REMOVESEAM Removes a seam from the image such that carving occurs along 
%the desired dimension. 
%   This function removes the seam from according to the dimension specified by
%   iterating through all rows/columns and adding the image information before
%   and after the index specified in seam to a carved version of the
%   image, which it will then return.

%Get image dimensions
[im_height,im_width,~] = size(im);

if strcmp(dimension,'vertical')
    im_carved = zeros(im_height-1,im_width,3);
    [~,c_width,~] = size(im_carved);

    for x = 1:c_width
        seam_x = seam(x);
        
        if seam_x==1
            im_carved(seam_x:end,x,:) = im(seam_x+1:end,x,:);
        elseif seam_x==im_height
            im_carved(1:seam_x-1,x,:) = im(1:seam_x-1,x,:);
        else 
            im_carved(1:seam_x-1,x,:) = im(1:seam_x-1,x,:);
            im_carved(seam_x:end,x,:) = im(seam_x+1:end,x,:);
        end
    end 
else 
    im_carved = zeros(im_height,im_width-1,3);
    [c_height,~,~] = size(im_carved);
    
    for y = 1:c_height
        seam_y = seam(y);
        
        if seam_y==1
            im_carved(y,seam_y:end,:) = im(y,seam_y+1:end,:);
        elseif seam_y==im_width
            im_carved(y,1:seam_y-1,:) = im(y,1:seam_y-1,:);
        else 
            im_carved(y,1:seam_y-1,:) = im(y,1:seam_y-1,:);
            im_carved(y,seam_y:end,:) = im(y,seam_y+1:end,:);
        end
    end
end

end

