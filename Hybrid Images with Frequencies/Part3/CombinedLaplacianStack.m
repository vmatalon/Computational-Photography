function [laplacian_stack_combined] = CombinedLaplacianStack(...
    laplacian_stack_im1,laplacian_stack_im2,gaussian_stack_mask)
%COMBINEDLAPLACIANSTACK Combines the images contained in the stacks to form
%a blended stack. 
%   This function iterates thrugh every level in the inputted stacks and
%   uses the mask stack as weights to smooth the blending. It returns a
%   struct stack of blended levels. 

names = fieldnames(laplacian_stack_im1);
laplacian_stack_combined = struct();

for level = 1:length(names)
    ln = names{level};
    mask = gaussian_stack_mask.(ln);
    t1 = mask.*laplacian_stack_im1.(ln);
    t2 = (1-mask).*laplacian_stack_im2.(ln);
    laplacian_stack_combined.(ln) = t1+t2;
end

end

