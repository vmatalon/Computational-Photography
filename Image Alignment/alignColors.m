function [one_aligned] = alignColors(one,two,version)
%ALIGNCOLORS Aligns the first color channel to the second. 
%   This function contains a naive, single-scale implementation of the SSD 
%   and NCC metrics and a multi-scale implementation of the NCC metric
%   using an image pyramid. 

% use edges as features instead of pixel intensity values 
one_edge = double(edge(one,'log'));
two_edge = double(edge(two,'log'));

[size_y,size_x] = size(one);

if version==1 % Single-Scale Version: SSD and NCC
    % remove 20% from each edge
    x20 = floor(size_x*0.2);
    y20 = floor(size_y*0.2);
    one_center = one_edge(y20+1:end-y20,x20+1:end-x20);
    two_center = two_edge(y20+1:end-y20,x20+1:end-x20);
    offsets = -15:15;
    [y,x] = naiveAlign(offsets,offsets,one_center,two_center);
else % Multi-Scale Version: Image Pyramid using SSD metric
    % remove 35% from each edge
    x35 = floor(size_x*0.35);
    y35 = floor(size_y*0.35);
    one_center = one_edge(y35+1:end-y35,x35+1:end-x35);
    two_center = two_edge(y35+1:end-y35,x35+1:end-x35);
    [y,x] = pyramidAlign(one_center,two_center);
end

disp(['Offsets: [x=',num2str(x),',y=',num2str(y),']']);

one_aligned = circshift(one,[y,x]);

end