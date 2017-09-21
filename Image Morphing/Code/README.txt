%MAIN Calls the functions needed to compute and display 1.the midway image, 
%2.the morph sequence, 3.the average face, 4.the caricatures, and 
%bells&whistles 1 and 2. 
%   This function calls all the functions needed to complete the assignment.
%   *Note1* all the static images will be displayed, but the morphing 
%   sequences will be saved but must be manually opened. 
%   *Note2* I use the mytsearch function written by David Martin and 
%   was only able to compile it with the mytsearch_mod.c function. 
%   *Note3* all the figures that I produce have titles for your convenience.
%   *Note4* I used the FEI database for the population mean and for this 
%   submission I included a subset of them in the figure fewbrazilians. 

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

                            >>Face Morphing<<
%CROSSDISSOLVE Computes a weighted average of two images.
%   This function creates a blended image by adding im1*(1-weight) and
%   im2*weight.

%WARPIMAGE This function warps the given image into the specified shape. 
%   This function warps the image into the specified shape via the
%   triangulation. First, I create a list of the triangle each pixel belongs
%   to and then I use that to make a map of the locations I should get the
%   pixels for the warped image from. Once this is done for all triangles I
%   assign the pixels in the warped image from the pixel values in the
%   original image using the pixel map I created. The last step checks
%   where the value of a pixel is NaN and wherever it finds that it inputs
%   the value of the rounded pixel location. 

%ROUNDPIXELMAP Rounds the pixels that are inputted and makes sure that all
%pixels are in the range from 1 to the dimension of the image. 

%INTERMEDIATEMORPH Computes the morphed image of im1 and im2 given their
%points, the triangulation, and the weight to use. 
%   This function makes sure the number of correspoinding points are the
%   same and assumes both images are the same size. Next, it warps
%   the two images in parallel by calling the warpImage function on each
%   image. Finally, it cross-dissolves them by calling crossDissolve in
%   order to produce the morphed image. 

%MORPH Morphs between the two images with a specified number of
%intermediate frames. 
%   This function first creates the average shape between the two images
%   and creates the traingulation to be used by calling Matlab's delaunay 
%   function on this average shape. Next, for each frame (from
%   1:frame_count) it creates the intermediate morph by calling
%   intermediateMorph and adds it to the struct of frames. 

%CREATEGIF Creates a gif from the frames in frames with the delay time
%specified. 
%   The gif that will be created goes through the sequence of frames 
%   forward and backwards and the user specifies the delay time. 

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

                >>The "Mean Face" of a Population<<
%POPULATIONSHAPE Computes the average shape of a population. 
%   This function takes in a struct of shapes and computes the average of
%   these by summing them together and dividing by the number of shapes in
%   the struct. 

%POPULATIONMORPH Morphs all the images to have the shape specified. 
%   This function takes in a struct of images and their shapes and the 
%   average population shape and morphs each image to that shape by calling
%   warp image on each one. The triangulation that it uses is a delaunay
%   triangulation on the average shape. 

%POPULATIONAVERAGE Cross-dissolves all images in the morphed population 
%struct to create the population average. 
%   This function sums all the morphed images together and then divides by
%   the number of images in the population. 

%CARICATURE Makes a caricature of the image by extrapolating it from the
%specified shape
%   This function produces a struct of frames from the extrapolation of
%   the image. The weights that are used are no longer between 0 and 1, 
%   they are between 0 and 2. 

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
        >>Bells & Whistles 1: changing gender and ethnicity<<
%Is done with functions from the previous part. 

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
        >>Bells & Whistles 2: morphing music video<<
%The video can be found on my website. For grading the main file will call 
%morph on 1 of the transitions. 
