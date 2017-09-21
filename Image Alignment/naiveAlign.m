function [y,x] = naiveAlign(offsets_y,offsets_x,one,two)
%NAIVEALIGN Calculates the x and y offset values. 
%   This function calculates x and y displacement when aligning the second 
%   color channel to the first using the SSD. 
%   The displacement values are limited to the ones found in the argument 
%   displacements. 

values = zeros(1,length(offsets_y)*length(offsets_x));
parfor index = 1:length(offsets_y)*length(offsets_x)
    [y,x] = ind2sub([length(offsets_y),length(offsets_x)],index);
    y = offsets_y(y);
    x = offsets_x(x);
    one_temp = circshift(one,[y,x]); % shift centered matrix
    values(index) = sum(sum((one_temp-two).^2)); % Sum of Squared Differences 
end

[~,index] = min(values);
[y,x] = ind2sub([length(offsets_y),length(offsets_x)],index);
y = offsets_y(y);
x = offsets_x(x);
% disp(['Offsets: x=',num2str(x),' y=',num2str(y)]);

end

