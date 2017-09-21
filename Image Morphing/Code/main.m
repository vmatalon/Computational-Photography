clear all;
close all; 

%% Load data
directory = dir(fullfile(pwd,'*.jpg'));
file_names = {directory.name}';
im1 = im2double(imread(file_names{1}));
im2 = im2double(imread(file_names{2}));
load im1_points.mat
load im2_points.mat
% load allbrazilians.mat
load fewbrazilians.mat
my_im = im2double(imread(file_names{3}));
load my_points.mat
load bellsandwhistles1.mat
load bellsandwhistles2.mat

%% Face Morphing 
%Compute average shape 
average_shape = (im1_points+im2_points)/2;
%Get Delaunay triangulation of average shape 
tri = delaunay(average_shape);

%Compute midway image 
midway_image = intermediateMorph(im1,im1_points,im2,im2_points,tri,0.5);
%Display midway image
figure(1);
hold on;
title('Midway face');
imshow(midway_image);
hold off;
imwrite(midway_image,'midway_afghan.jpg');

%Display midway image with triangles 
figure(2);
imshow(midway_image);
hold on;
triplot(tri,average_shape(:,1),average_shape(:,2));
saveas(gcf,'midwayt_afghan.jpg');
title('Midway face with triangles');
hold off;

%Create morph sequence 
frame_count = 45;
frames = morph(im1,im1_points,im2,im2_points,frame_count);

%Make gif
delay_time = 1/30;
figure(3);
createGif(frames,delay_time,1);

%% Population computations 
%Compute mean face 
shape_population = populationShape(brazilians.shapes);
morphed_population = populationMorph(brazilians,shape_population);
average_population = populationAverage(morphed_population);
figure(4);
hold on;
title('Average Brazilian woman');
imshow(average_population);
hold off;
imwrite(average_population,'averageb.jpg');

%Compute my face with average geometry 
tri_avme = delaunay((my_points+shape_population)/2);
me_population = warpImage(my_im,my_points,shape_population,tri_avme);
figure(5);
hold on;
title('My face with average geometry');
imshow(me_population);
hold off;
imwrite(me_population,'bme1.jpg');

%Compute average face with my geometry 
population_me = warpImage(average_population,shape_population,my_points,...
    tri_avme);
figure(6);
hold on;
title('Average face with my geometry');
imshow(population_me);
hold off;
imwrite(population_me,'bme2.jpg');

%Create caricature sequence 
frame_count = 15;
caricature_frames = caricature(my_im,my_points,shape_population,frame_count);
figure(7);
hold on;
title('Caricature');
imshow(caricature_frames.frame15);
hold off;
imwrite(caricature_frames.frame15,'caricature.jpg');

%Make gif
delay_time = 1/20;
figure(8);
createGif(caricature_frames,delay_time,2);

%% Bells & Whistles 1: change gender/ethnicity 
%Change gender 
me = bellsandwhistles1.me;
me_points = bellsandwhistles1.mep;
male = bellsandwhistles1.ag;
male_points = bellsandwhistles1.agp;
tri_g = delaunay((me_points+male_points)/2);

%Just shape
shape_gender = warpImage(me,me_points,male_points,tri_g);
figure(9);
hold on;
title('Change of gender: just shape');
imshow(shape_gender);
hold off;
imwrite(shape_gender,'gshape.jpg');
%Just appearance 
app_gender = warpImage(male,male_points,me_points,tri_g);
figure(10);
hold on;
title('Change of gender: just appearance');
imshow(app_gender);
hold off;
imwrite(app_gender,'gapp.jpg');
%Both
both_gender = intermediateMorph(male,male_points,me,me_points,tri_g,0.5);
figure(11);
hold on;
title('Change of gender: both');
imshow(both_gender);
hold off;
imwrite(both_gender,'gboth.jpg');

%Change ethnicity 
aa = bellsandwhistles1.aa;
aa_points = bellsandwhistles1.aap;
tri_aa = delaunay((me_points+aa_points)/2);

%Just shape
shape_ethnicity = warpImage(me,me_points,aa_points,tri_aa);
figure(12);
hold on;
title('Change of ethnicity: just shape');
imshow(shape_ethnicity);
hold off;
imwrite(shape_ethnicity,'eshape.jpg');
%Just appearance 
app_ethnicity = warpImage(aa,aa_points,me_points,tri_aa);
figure(13);
hold on;
title('Change of ethnicity: just appearance');
imshow(app_ethnicity);
hold off;
imwrite(app_ethnicity,'eapp.jpg');
%Both
both_ethnicity = intermediateMorph(aa,aa_points,me,me_points,tri_aa,0.5);
figure(14);
hold on;
title('Change of ethnicity: both');
imshow(both_ethnicity);
hold off;
imwrite(both_ethnicity,'eboth.jpg');

%% Bells & Whistles 2: morphing music video 
lauren1 = bellsandwhistles2.im1;
lauren2 = bellsandwhistles2.im2;
lauren1pts = bellsandwhistles2.points1;
lauren2pts = bellsandwhistles2.points2;

lauren = morph(lauren1,lauren1pts,lauren2,lauren2pts,40);
figure(15);
createGif(lauren,delay_time,3);

