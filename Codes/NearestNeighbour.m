clc;
clear all;
close all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lettersRegion.png');
mask = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lettersmask.png');

[h,w,s] = size(img);
mask = im2bw(mask);
mask = double(mask);
Img = double(img);
iterations = 100;

count = 0;
for i = 1:h
    for j = 1:w
        if mask(i,j) == 1
            if Img(i,j,:) == 0
                count = count+1;
            end
                if Img(i-1,j,:) ~=0
                    val = Img(i-1,j,:);
                elseif Img(i+1,j,:) ~=0
                    val = Img(i+1,j,:);
                end
            Img(i,j,:) = val;                
        end
    end
end

figure, imshow(uint8(img)); title('Original Region');
figure, imshow(uint8(Img)); title('Nearest Neighbours');