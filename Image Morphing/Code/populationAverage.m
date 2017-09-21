function [average_population] = populationAverage(morphed_population)
%POPULATIONAVERAGE Cross-dissolves all images in the morphed population 
%struct to create the population average. 
%   This function sums all the morphed images together and then divides by
%   the number of images in the population. 

field_names = fieldnames(morphed_population);
average_population = morphed_population.(field_names{1});

for i = 2:length(field_names)
    current_morph = morphed_population.(field_names{i});
    average_population = average_population+current_morph;
end
average_population = average_population/length(field_names);

end

