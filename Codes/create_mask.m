clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\pimple.jpg');
[h,w,s] = size(img);
if s == 3
    img = rgb2gray(img);
end
figure, imshow(img);
fh = imfreehand();
lmask = fh.createMask();

lmask = double(lmask);
imwrite(lmask,'C:\Third Year Semester 1\Digital Image Processing\Project\Images\pimplemask.png');