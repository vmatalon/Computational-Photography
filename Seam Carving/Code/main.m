%Get image names
directory = dir(fullfile(pwd,'*.jpg'));
files = {directory.name}';

for im_index = 1:length(files)
    %Read image
    im_name = files{im_index};
    im = im2double(imread(im_name));
    
    %Set dimension and desired dimension
%     dimension = 'vertical';
%     desired_dimension = floor(size(im,1)*0.9);
    dimension = 'horizontal';
    desired_dimension = floor(size(im,2)*0.7);

    %Seam carve
    [im_carved,seams] = seamCarve(im,dimension,desired_dimension);
    
    %Show (and save)
    figure(im_index);
    imshow(im_carved);
    %imwrite(im_carved,[im_name(1:end-4),'-carved.jpg']);
end