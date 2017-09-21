function [seam] = findSeam(energy,dimension)
%FINDSEAM Uses dynamic programming to find the lowest-energy seam for 
%carving along the desired dimension. 
%   This function takes in an energy representation of the image and the
%   desired dimension along which it shall find the seam. The process is
%   twofold: first, the function iterates through all pixels starting from
%   the second row/column and computes the cumulative energy for all
%   pixels & next, it backtracks from the pixel with the least cumulative
%   energy in the last row/column recording the indeces of the pixels that
%   form a part of the optimal seam (breaking ties by returning the index 
%   with the lowest value).

energyC = energy;

%Get image dimensions
[height,width] = size(energy);

if strcmp(dimension,'vertical')
    seam = zeros(1,width);

    %Compute cumulative energy 
    for y = 1:height
        for x = 2:width
            if y==1
                energyC(y,x) = energyC(y,x)+...
                    min([energyC(y,x-1),energyC(y+1,x-1)]);
            elseif y==height
                energyC(y,x) = energyC(y,x)+...
                    min([energyC(y-1,x-1),energyC(y,x-1)]);
            else
                energyC(y,x) = energyC(y,x)+...
                    min([energyC(y-1,x-1),energyC(y,x-1),energyC(y+1,x-1)]);
            end
        end
    end
 
    %Find path of optimal seam 
    [~,index] = min(energyC(:,width));
    seam(width) = index;
    for x = 2:width
        xx = width-(x-1);
        yy = seam(xx+1);
        if yy==1
            [~,i] = min([energyC(yy,xx),energyC(yy+1,xx)]);
            if i==1
                index = yy;
            else 
                index = yy+1;
            end
        elseif yy==height
            [~,i] = min([energyC(yy-1,xx),energyC(yy,xx)]);
            if i==1
                index = yy-1;
            else 
                index = yy;
            end
        else
            [~,i] = min([energyC(yy-1,xx),energyC(yy,xx),energyC(yy+1,xx)]);
            if i==1
                index = yy-1;
            elseif i==2
                index = yy;
            else 
                index = yy+1;
            end
        end
        
        seam(xx) = index;
    end
    
else 
    seam = zeros(1,height);
    
    %Compute cumulative energy 
    for y = 2:height
        for x = 1:width
            if x-1==0
                energyC(y,x) = energyC(y,x)+...
                    min([energyC(y-1,x),energyC(y-1,x+1)]);
            elseif x+1==width+1
                energyC(y,x) = energyC(y,x)+...
                    min([energyC(y-1,x-1),energyC(y-1,x)]);
            else 
                energyC(y,x) = energyC(y,x)+...
                    min([energyC(y-1,x-1),energyC(y-1,x),energyC(y-1,x+1)]);
            end
        end
    end
    
    %Find path of optimal seam 
    [~,index] = min(energyC(height,:));
    seam(height) = index;
    for y = 2:height
        yy = height-(y-1);
        xx = seam(yy+1);
        
        if xx==1
            [~,i] = min([energyC(yy,xx),energyC(yy,xx+1)]);
            if i==1
                index = xx;
            else 
                index = xx+1;
            end
        elseif xx==width
            [~,i] = min([energyC(yy,xx-1),energyC(yy,xx)]);
            if i==1
                index = xx-1;
            else 
                index = xx;
            end
        else
            [~,i] = min([energyC(yy,xx-1),energyC(yy,xx),energyC(yy,xx+1)]);
            if i==1
                index = xx-1;
            elseif i==2
                index = xx;
            else 
                index = xx+1;
            end
        end
        
        seam(yy) = index;
    end
end

end
