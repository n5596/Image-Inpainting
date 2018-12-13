clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\pimple.jpg');
mask = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\pimplemask.png');

%---------INITIALIZING THE REGION TO BE INPAINTED------
img = double(img);
mask = im2bw(mask);

maskbar = mask;
mask = imcomplement(mask);

region(:,:,1) = img(:,:,1).*mask;
region(:,:,2) = img(:,:,2).*mask;
region(:,:,3) = img(:,:,3).*mask;

[h1, w1, s1] = size(mask);
if s1 == 3
    M = mask;
else
    for i = 1:3
        M(:,:,i) = mask(:,:);
    end
end

regionc(:,:,1) = img(:,:,1).*maskbar;
regionc(:,:,2) = img(:,:,2).*maskbar;
regionc(:,:,3) = img(:,:,3).*maskbar;
[h,w,s] = size(regionc);
for i = 1:h
    for j = 1:w
        if regionc(i,j,:) ~= 0
            regionc(i,j,:) = 255;
        end
    end
end
figure, imshow(uint8(regionc)); title('Region to be filled');

%---------FINDING THE BOUNDARY-----------
[h,w,s] = size(img);
boundary = zeros(h,w);
for i = 1:h
    for j = 1:w
        if region(i,j,1:3) == 0
            if i~=1 
                boundary(i-1,j) = 1;
            end
            if j~=1 
                boundary(i,j-1) = 1;
            end
            if i~=1 && j~=1 
                boundary(i-1,j-1) = 1;
            end
            if i~=h
                boundary(i+1,j) = 1;
            end
            if j~=w
                boundary(i,j+1) = 1;
            end
            if i~=h && j~=w
                boundary(i+1,j+1) = 1;
            end
        end
    end
end

boundary = boundary.*mask;
b = logical(boundary) & logical(mask);
boundary = logical(boundary) &(b);
boundary = double(boundary);
B = boundary;

dR(:,:,1) = img(:,:,1).*boundary;
dR(:,:,2) = img(:,:,2).*boundary;
dR(:,:,3) = img(:,:,3).*boundary;

figure, imshow(uint8(255*boundary)); title('Boundary');
% figure, imshow(uint8(dR)); title('dR');

imwrite(uint8(region),'C:\Third Year Semester 1\Digital Image Processing\Project\Images\pimpleRegion.png');