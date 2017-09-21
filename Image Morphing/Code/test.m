%% Load data
directory = dir(fullfile(pwd,'*.jpg'));
file_names = {directory.name}';

%% Population computations 
load allbrazilians.mat
%load fewbrazilians.mat
my_im = im2double(imread(file_names{3}));
load my_points.mat

%Compute mean face 
shape_population = populationShape(brazilians.shapes);
morphed_population = populationMorph(brazilians,shape_population);
average_population = populationAverage(morphed_population);
figure(4);
hold on;
title('Average Brazilian woman');
imshow(average_population);
hold off;

%Compute my face with average geometry 
tri_avme = delaunay((my_points+shape_population)/2);
me_population = warpImage(my_im,my_points,shape_population,tri_avme);
figure(5);
hold on;
title('My face with average geometry');
imshow(me_population);
hold off;

%Compute average face with my geometry 
population_me = warpImage(average_population,shape_population,my_points,...
    tri_avme);
figure(6);
hold on;
title('Average face with my geometry');
imshow(population_me);
hold off;

%Create caricature sequence 
frame_count = 15;
caricature_frames = caricature(my_im,my_points,shape_population,frame_count);
figure(7);
hold on;
title('Caricature');
imshow(caricature_frames.frame15);
hold off;

%Make gif
delay_time = 1/20;
figure(8);
createGif(caricature_frames,delay_time,2);


%% Ethnicity/Gender change 
load bellsandwhistles1.mat
