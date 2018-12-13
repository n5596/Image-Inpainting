clc;
close all;
clear all;

%--------FILTERING--------
img = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\pimple.jpg');
mask = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\pimplemask.png');
originalRegion = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\pimpleRegion.png');

gsize = 3;

a = 0.073235;
b = 0.176765;
c = 0.125;
gauss1 = [a b a;b 0 b;a b a];
gauss2 = [c c c;c 0 c;c c c];
gauss = gauss1;
[h,w,s] = size(img);
iterations = 100;

originalRegion = double(originalRegion);

mask = im2bw(mask);
maskbar = 1-mask;
M = zeros(h,w,3);

[a1,a2,a3] = size(mask);
if a3 == 3
    M = mask;
else
    for i = 1:3
        M(:,:,i) = mask(:,:);
    end
end

[g1,g2] = size(gauss);
G = zeros(g1, g2, 3);
for i = 1:3
    G(:,:,i) = gauss(:,:);
end

tempImg(:,:,1) = uint8(maskbar).*img(:,:,1);
tempImg(:,:,2) = uint8(maskbar).*img(:,:,2);
tempImg(:,:,3) = uint8(maskbar).*img(:,:,3);
tempImg = double(tempImg);

for iter = 1:iterations
    for i = 3:h-2
        for j = 3:w-2
            if mask(i,j) == 1
            I = tempImg(i-1:i+1,j-1:j+1,:);
            Ibar1 = I(:,:,1).*gauss;
            Ibar2 = I(:,:,2).*gauss;
            Ibar3 = I(:,:,3).*gauss;

            gsum = 1;
            
            tempImg(i,j,1) = sum(Ibar1(:))/gsum;
            tempImg(i,j,2) = sum(Ibar2(:))/gsum;
            tempImg(i,j,3) = sum(Ibar3(:))/gsum;
            end
        end
    end
end

added = tempImg.*M;
figure, imshow(uint8(img)); title('Original');
% figure, imshow(uint8(added)); title('Added');
inpainted = originalRegion + added;
figure, imshow(uint8(inpainted)); title('Without Diffusion Barriers');
