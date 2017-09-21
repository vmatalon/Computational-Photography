function [mosaic] = AddStack(laplacian_stack)
%ADDSTACK Iterates through the blended stack and adds them to form the
%image mosaic. 

names = fieldnames(laplacian_stack);
mosaic = zeros(size(laplacian_stack.level1));
for level = 1:length(names)
    mosaic = mosaic + laplacian_stack.(names{level});
end

end