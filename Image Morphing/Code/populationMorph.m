function [morphed_population] = populationMorph(population,shape_population)
%POPULATIONMORPH Morphs all the images to have the shape specified. 
%   This function takes in a struct of images and their shapes and the 
%   average population shape and morphs each image to that shape by calling
%   warp image on each one. The triangulation that it uses is a delaunay
%   triangulation on the average shape. 

images = population.images;
shapes = population.shapes;

im_field_names = fieldnames(images);
shapes_field_names = fieldnames(shapes);
morphed_population = struct();

tri = delaunay(shape_population);

for i = 1:length(im_field_names)
    im = images.(im_field_names{i});
    im_shape = shapes.(shapes_field_names{i});
    morphed_population.(im_field_names{i}) = warpImage(im,im_shape,...
        shape_population,tri);
end

end

