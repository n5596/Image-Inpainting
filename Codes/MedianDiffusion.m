clc;
clear all;
close all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lenaRegion.png');
mask = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lenamask.png');

[h,w,s] = size(img);
mask = im2bw(mask);
mask = double(mask);
Img = double(img);
iterations = 2;
ksize = 40;

imgt1(:,:,1) = padarray(img(:,:,1), [floor(ksize/2) floor(ksize/2)]);
imgt1(:,:,2) = padarray(img(:,:,2), [floor(ksize/2) floor(ksize/2)]);
imgt1(:,:,3) = padarray(img(:,:,3), [floor(ksize/2) floor(ksize/2)]);

[h1, w1, s1] = size(imgt1);
maskt1 = padarray(mask, [floor(ksize/2) floor(ksize/2)]);

for i = floor(ksize/2):h1-floor(ksize/2)-1
    for j = floor(ksize/2):w1-floor(ksize/2)-1
        if maskt1(i,j) == 1 || maskt1(i-1,j) == 1 || maskt1(i,j-1) == 1 || maskt1(i+1,j) == 1 || maskt1(i,j+1) == 1 || maskt1(i-1,j-1) == 1 || maskt1(i-1,j+1) == 1 || maskt1(i+1,j-1) == 1 || maskt1(i+1,j+1) == 1
            I = imgt1(i-floor(ksize/2)+1:i+floor(ksize/2)+1,j-floor(ksize/2)+1:j+floor(ksize/2)+1,:);
            I1 = I(:,:,1);
            I2 = I(:,:,2);
            I3 = I(:,:,3);
            Img(i-floor(ksize/2)+1,j-floor(ksize/2)+1,1) = median(I1(:));
            Img(i-floor(ksize/2)+1,j-floor(ksize/2)+1,2) = median(I2(:));
            Img(i-floor(ksize/2)+1,j-floor(ksize/2)+1,3) = median(I3(:));
        end
    end
end

figure, imshow(uint8(img)); title('Original Image');
figure, imshow(uint8(Img)); title('Median Diffusion');
% figure, imshow(uint8(Img-double(img)));