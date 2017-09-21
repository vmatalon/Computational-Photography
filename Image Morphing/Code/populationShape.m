function [shape_population] = populationShape(shapes)
%POPULATIONSHAPE Computes the average shape of a population. 
%   This function takes in a struct of shapes and computes the average of
%   these by summing them together and dividing by the number of shapes in
%   the struct. 

field_names = fieldnames(shapes);
shape_count = length(field_names);
shape_population = zeros(size(shapes.(field_names{1})));

for s = 1:shape_count
    shape_population = shape_population+shapes.(field_names{s});
end
shape_population = shape_population/shape_count;

end

