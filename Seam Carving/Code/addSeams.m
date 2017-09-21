function [im_carved] = addSeams(im,seam_struct,dimension,iteration)
%ADDSEAM Adds seams to the image such that carving occurs along the desired
%dimension.
%   This function adds the seams in the seam struct inputted that are
%   required by the iteration. It does this by iterating through all the
%   rows/columns and adding the seam to the left of the 

seams = fieldnames(seam_struct);

%Get image dimensions
[im_height,im_width,~] = size(im);

if strcmp(dimension,'vertical')
    seam_start = ((iteration-1)*im_height)+1;
    seam_end = iteration*im_height;
    seams = seams(seam_start:seam_end);
    im_carved = zeros(im_height+length(seams),im_width,3);
    im_carved(1:im_height,1:im_width) = im;
    [~,c_width,~] = size(im_carved);
    
    for s = 1:length(seams)
        current_seam = seams(s);
        
        for x = 1:c_width-1
            seam_x = current_seam(x);
            if seam_x==1
                im_carved(seam_x+1:end,x,:) = im_carved(seam_x:end-1,x,:);
                im_carved(seam_x,x,:) = mean(im_carved(seam_x+1,x,:),...
                    im_carved(seam_x+2,x,:));
            elseif seam_x==im_height
                im_carved(seam_x+1,x,:) = mean(im_carved(seam_x,x,:),...
                    im_carved(seam_x-1,x,:));
                
                im_carved(1:seam_x-1,x,:) = im(1:seam_x-1,x,:);
            else
                im_carved(1:seam_x-1,x,:) = im(1:seam_x-1,x,:);
                im_carved(seam_x:end,x,:) = im(seam_x+1:end,x,:);
            end
        end
    end
else 
    seam_start = ((iteration-1)*im_width)+1;
    seam_end = iteration*im_width;
    seams = seams(seam_start:seam_end);
    im_carved = zeros(im_height,im_width+length(seams),3);
    im_carved(1:im_height,1:im_width) = im;
    [c_height,~,~] = size(im_carved);
    
    
end

end

