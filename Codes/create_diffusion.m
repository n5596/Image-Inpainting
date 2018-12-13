clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lena.png');
mask = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lenamask.png');

[h,w,s] = size(img);
if s == 3
    img = rgb2gray(img);
end

figure, imshow(img);
mask = zeros(size(img));

for i = 1:2
    fh = imfreehand();
    lmask = fh.createMask();
    mask = mask+lmask;
end

mask = double(mask);
figure, imshow(uint8(mask*255)); title('Mask');

imwrite(uint8(255*mask),'C:\Third Year Semester 1\Digital Image Processing\Project\Images\lenadiffusion.png');