main.m contains an implementation of the Unsharp Masking Filter. 
	It reads the images that are contained in the folder and sharpens them.
    The function does this by first creating a blurred version of the 
    original image (by convolving the image with a gaussian whose dimensions
    are a function of the original image's maximum dimension and sigma=2).
    It then creates a mask of the high frequencies by subtracting this 
    unsharpened image from the original. Fianlly, it sharpens the image by
    adding the mask times some constant alpha to the original image. 
    (It displays the image but for grading the saving has been commented out.)