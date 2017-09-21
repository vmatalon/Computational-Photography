function [im_energy] = energize(im,type)
%ENERGIZE Calculates the importance of each pixel using an energy function.
%   This function calculates the importance of each pixel in the inputted
%   image using the energy function specified by the type argument (which
%   can be:
%       gradient = (e1) L1 & L2 norm of the gradient, saliency measure
%           calculated with the help of the gradient function 
%       entropy = adds entropy over a 9x9 window and adds it to e1
%           calculated with the help of the entropyfilt function 
%       histogram = histogram of oriented edges
%           calculated with the help of the imhist function 

if isinteger(im)
    im_gray = im2double(rgb2gray(im));
else
    im_gray = rgb2gray(im);
end

[dx,dy] = gradient(im_gray);
if strcmp(type,'gradient') %Gradient saliency measure
    [dx,dy] = gradient(im_gray);
    im_energy = abs(dx)+abs(dy);
elseif strcmp(type,'color') %Gradient saliency measure
    im_energy = abs(dx)+abs(dy);
elseif strcmp(type,'entropy') %Entropy energy 
    im_energy = abs(dx)+abs(dy)+entropyfilt(im_gray);
elseif strcmp(type,'histogram')%Histogram of oriented gradients     
    histogram_of_gradients = zeros(size(im_gray));
    %pad array
    im_padded = padarray(im,[5,5],'symmetric');
    for y = 1:size(im_gray,1)
        for x = 1:size(im_gray,2)
            window = im_padded(y:y+10,x:x+10);
            histogram_of_gradients(y,x) = max(imhist(window,8));
        end
    end
    im_energy = (abs(dx)+abs(dy))./histogram_of_gradients;
else
    disp('Invalid energy function type.');
end
    
end

