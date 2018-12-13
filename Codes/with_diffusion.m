clc;
close all;
clear all;

%--------FILTERING--------
img = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lena.png');
mask = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lenamask.png');
originalRegion = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lenaRegion.png');
diffusion = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\lenadiffusion.png');

gsize = 3;

a = 0.073235;
b = 0.176765;
c = 0.125;
gauss1 = [a b a;b 0 b;a b a];
gauss2 = [c c c;c 0 c;c c c];
gauss = gauss1;
[h,w,s] = size(img);
iterations = 200;

originalRegion = double(originalRegion);

mask = im2bw(mask);
maskbar = 1-mask;
diffusion = diffusion/255;
% mask = double(mask);
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

[gmag, gdir] = imgradient(rgb2gray(img));

for iter = 1:iterations
    for i = 2:h-1
        for j = 2:w-1
            if mask(i,j) == 1 
            I = tempImg(i-1:i+1,j-1:j+1,:);
            
             if diffusion(i,j) == 0
                Ibar1 = I(:,:,1).*gauss;
                Ibar2 = I(:,:,2).*gauss;
                Ibar3 = I(:,:,3).*gauss;

                gsum = 1;
                tempImg(i,j,1) = sum(Ibar1(:))/gsum;
                tempImg(i,j,2) = sum(Ibar2(:))/gsum;
                tempImg(i,j,3) = sum(Ibar3(:))/gsum;
             else
                Ipatch = gdir(i-1:i+1,j-1:j+1);
                I = tempImg(i-1:i+1,j-1:j+1,:);
                
                for s = 1:3
                    for t = 1:3
                        if Ipatch(s,t) < 0
                            Ipatch(s,t) = Ipatch(s,t)+360;
                        end
                    end
                end
                Ipatch(:,:) = abs(Ipatch(:,:) - Ipatch(2,2));
                array = [Ipatch(1,1) Ipatch(1,2) Ipatch(1,3) Ipatch(2,1) Ipatch(2,3) Ipatch(3,1) Ipatch(3,2) Ipatch(3,3)];
                [val pos] = min(array);
                
                if pos == 1
                    value = I(1,1,:);
                elseif pos == 2
                    value = I(1,2,:);
                elseif pos == 3
                    value = I(1,3,:);
                elseif pos == 4
                    value = I(2,1,:);
                elseif pos == 5
                    value = I(2,3,:);
                elseif pos == 6
                    value = I(3,1,:);
                elseif pos == 7
                    value = I(3,2,:);
                elseif pos == 8
                    value = I(3,3,:);
                end
                tempImg(i,j,:) = value;
            end
            end
        end
    end
end

added = tempImg.*M;
figure, imshow(uint8(img)); title('Original');
% figure, imshow(uint8(added)); title('Added');
inpainted = originalRegion + added;
figure, imshow(uint8(inpainted)); title('Inpainted');
