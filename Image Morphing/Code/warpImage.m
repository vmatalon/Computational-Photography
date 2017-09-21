function [im_warped] = warpImage(im,im_points,warp_points,tri)
%WARPIMAGE This function warps the given image into the specified shape. 
%   This function warps the image into the specified shape via the
%   triangulation. First, I create a list of the triangle each pixel belongs
%   to and then I use that to make a map of the locations I should get the
%   pixels for the warped image from. Once this is done for all triangles I
%   assign the pixels in the warped image from the pixel values in the
%   original image using the pixel map I created. The last step checks
%   where the value of a pixel is NaN and wherever it finds that it inputs
%   the value of the rounded pixel location. 

%% Initialize values 
[rows,cols,dimm] = size(im);
dim = rows*cols;
triangle_count = size(tri,1);
indices = [repmat(1:cols,1,rows);reshape(repmat(1:rows,cols,1),[1,dim]);...
    ones(1,dim)];
pixel_map = zeros(3,dim);
rounded_pixel_map = zeros(3,dim);
triangle_indices = mytsearch(warp_points(:,1),warp_points(:,2),tri,...
    indices(1,:)',indices(2,:)');

if dimm==1
    imm = zeros(rows,cols,3);
    imm(:,:,1) = im;
else 
    imm = im;
end

%% Iterate over triangles
for t = 1:triangle_count
    tri1 = tri(t,1);
    tri2 = tri(t,2);
    tri3 = tri(t,3);
    
    %Compute transformation matrix 
    warp_triangle = [[warp_points(tri1,:);warp_points(tri2,:);...
        warp_points(tri3,:)]';ones(1,3)];
    im_triangle = [[im_points(tri1,:);im_points(tri2,:);...
        im_points(tri3,:)]';ones(1,3)];
    transform = im_triangle/warp_triangle;
    
    %Make pixel maps
    unrounded_indices = transform*indices(:,triangle_indices==t);
    pixel_map(:,triangle_indices==t) = unrounded_indices;
    rounded_pixel_map(:,triangle_indices==t) = ...
        roundPixelMap(unrounded_indices,rows,cols);
end

%% Fill in pixels to make warped image
%Interpolating 
[X,Y]=meshgrid(1:cols,1:rows);
Xq = vec2mat(pixel_map(1,:),cols);
Yq = vec2mat(pixel_map(2,:),cols);
r = zeros(rows,cols);
g = zeros(rows,cols);
b = zeros(rows,cols);
parfor i = 1:3
    if i==1
        r=r+interp2(X,Y,imm(:,:,i),Xq,Yq);
    elseif i==2
        g=g+interp2(X,Y,imm(:,:,i),Xq,Yq);
    else
        b=b+interp2(X,Y,imm(:,:,i),Xq,Yq);
    end
end
im_warped = cat(3,r,g,b);

naan = find(isnan(im_warped));
for i = 1:length(naan)
    [r,c,d] = ind2sub(size(im_warped),naan(i));
    rr = rounded_pixel_map(2,r);
    cc = rounded_pixel_map(2,c);
    im_warped(r,c,d) = imm(rr,cc,d);
end

%Rounding 
% for i = 1:dim
%     if ~isnan(triangle_indices(i))
%         im_warped(indices(2,i),indices(1,i),:) = ...
%             im(rounded_pixel_map(2,i),rounded_pixel_map(1,i),:);
%     else
%         disp('NaN!');
%     end
% end

if dimm==1
    im_warped = im_warped(:,:,1);
    naan = isnan(im_warped);
    im_warped(naan) = 0;
end

end

