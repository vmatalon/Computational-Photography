close all;

%Get image names
directory = dir(fullfile(pwd,'*.jpg'));
files = {directory.name}';

for im_index = 1:length(files)
    %Read image
    im_name = files{im_index};
    im = imread(im_name);

    %Extract high frequencies from image
    dimension = floor(sqrt(max(size(im))));
    gaussian_filter = fspecial('gaussian',dimension,2);%Create filter
    im_blurred = imfilter(im,gaussian_filter,'conv');%Blur image 
    im_high = im-im_blurred;%Get high frequencies

    %Sharpen image 
    alpha = 2;
    im_sharp = im+(alpha*im_high);

    %Save image
    figure(im_index);
    imshow(im_sharp);
%     imwrite(im_sharp,[im_name(1:end-4),'-sharpened.jpg'],'jpg');
end