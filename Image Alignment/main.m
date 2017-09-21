% CS194-26: Project 1
% Images of the Russian Empire: Colorizing the Prokudin-Gorskii photo
% collection
% Vanessa Matalon

path_code = pwd;
cd .. 
% path_data = fullfile(pwd,'data'); % project images
path_data = fullfile(pwd,'moredata'); % extra images
cd(path_code);

% get image filenames in the data directory
directory = dir(path_data);
files = {directory.name}';
files(ismember(files,{'.','..'})) = [];

for imnumber = 1:length(files)
% for imnumber = 5:5 % only run one image for submission
    % get image & convert 
    imname = files{imnumber};
    disp(imname);
    impath = fullfile(path_data,imname);
    fullim = imread(impath); % read in the image
    fullim = im2double(fullim); % convert to double matrix 
    
    % separate color channels 
    height = floor(size(fullim,1)/3);
    B = fullim(1:height,:);
    G = fullim(height+1:height*2,:);
    R = fullim(height*2+1:height*3,:);
    
    % align color channels
    if strcmp('.jpg',imname(end-3:end))
        version = 1; % single-scale
    else 
        version = 2; % multi-scale
    end
    tic;
    G_aligned = alignColors(G,B,version);
    R_aligned = alignColors(R,B,version);
    toc
    
    % create color image
    figure(imnumber);
    colorized = cat(3,R_aligned,G_aligned,B); % concatenate RGB channela  
    imshow(colorized); % show the resulting image
    imwrite(colorized,['result-',imname(1:end-4),'.jpg'],'jpg'); % save result image
    
    disp(' ');
end
