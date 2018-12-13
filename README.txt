The codes are given in the Codes folder.
	1) create_mask.m : The input is the image to be inpainted and the mask should be manually created and the code will save it.
	2) find_boundary.m: This takes the image to be inpainted as well as the mask and initializes the inpainting region to 0. This saves the region.
	3) without_diffusion.m : This takes in the initial image, mask as well as the region created by find_boundary.m and does Gaussian to give the output.
	4) create_diffusion.m: This takes in the input image as well as the mask and we have to manually create the diffusion barriers with imfreehand(). This saves the diffusion barriers.
	5) with_diffusion.m: This takes in input image, mask, region image and diffusion barriers.The output is the final output.
	6) NearestNeighbour.m: This takes in the region and mask and performs NN algorithm to output final image.
	7) MedianDiffusion.m: This takes in the region and mask and outputs the median diffusion output.
	8) PDE_coloured.m : This takes in the input image and the mask and perform PDE to give the output image. 