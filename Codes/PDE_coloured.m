clc;
clear all;
close all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\horse.png');
Mask = imread('C:\Third Year Semester 1\Digital Image Processing\Project\Images\horsemask.png');

mask_double = Mask;

Mask = im2bw(Mask);

avg = (1/24)*[1 1 1 1 1;1 1 1 1 1;1 1 0 1 1;1 1 1 1 1;1 1 1 1 1];
Img = img;
rows  = size(img,1);
cols  = size(img,2);

maskbar = 1-Mask;

Img(:,:,1) = ((Img(:,:,1)).*uint8(maskbar)); 
Img(:,:,2) = ((Img(:,:,2)).*uint8(maskbar)); 
Img(:,:,3) = ((Img(:,:,3)).*uint8(maskbar)); 
figure,imshow(uint8(Img));title('Input Image');

L = zeros(size(Img));

for nu=1:1200
    h = fspecial('laplacian');

    L(:,:,1) = imfilter(Img(:,:,1),h);
    L(:,:,2) = imfilter(Img(:,:,2),h);
    L(:,:,3) = imfilter(Img(:,:,3),h);
          
    [mag_r,Ni_r] = imgradient(Img(:,:,1));
    [mag_b,Ni_b] = imgradient(Img(:,:,2));
    [mag_g,Ni_g] = imgradient(Img(:,:,3));
    
    [dL_r,XX_r] = imgradient(L(:,:,1));
    [dL_b,XX_b] = imgradient(L(:,:,2));
    [dL_g,XX_g] = imgradient(L(:,:,3));
        
    mr = min(dL_r(:));
    mb = min(dL_b(:));
    mg = min(dL_g(:));
    
    dL_r(:,:) = dL_r(:,:)-mr;
    dL_b(:,:) = dL_b(:,:)-mb;
    dL_g(:,:) = dL_g(:,:)-mg;
    
    mar = max(dL_r(:));
    mab = max(dL_b(:));
    mag = max(dL_g(:));
    
    dL_r(:,:) = dL_r(:,:)*255/mar;
    dL_b(:,:) = dL_b(:,:)*255/mab;
    dL_g(:,:) = dL_g(:,:)*255/mag;
    
    mir = min(Ni_r(:));
    mib = min(Ni_b(:));
    mig = min(Ni_g(:));
    mlr = min(XX_r(:));
    mlb = min(XX_b(:));
    mlg = min(XX_g(:));
    
    Ni_r(:,:) = Ni_r(:,:)-mir;
    Ni_b(:,:) = Ni_b(:,:)-mib;
    Ni_g(:,:) = Ni_g(:,:)-mig;
    XX_r(:,:) = XX_r(:,:)-mlr;
    XX_b(:,:) = XX_b(:,:)-mlb;
    XX_g(:,:) = XX_g(:,:)-mlg;

    N_r = Ni_r-XX_r;
    N_b = Ni_b-XX_b;
    N_g = Ni_g-XX_g;
                 
        Img = double(Img);
        
        for i=3:size(img,1)-2
            for j=3:size(img,2)-2                
                    if Mask(i,j) == 1
                                               
                        xxx_r = (dL_r(i,j))*cosd(N_r(i,j));
                        xxx_b = (dL_b(i,j))*cosd(N_b(i,j));
                        xxx_g = (dL_g(i,j))*cosd(N_g(i,j));
                        
                        r = (Img(i-1,j-1,1)+Img(i+1,j+1,1)+Img(i,j-1,1)+Img(i-1,j,1)+Img(i,j+1,1)+Img(i+1,j,1)+Img(i-1,j+1,1)+Img(i+1,j-1,1))/8;
                        b = (Img(i-1,j-1,2)+Img(i+1,j+1,2)+Img(i,j-1,2)+Img(i-1,j,2)+Img(i,j+1,2)+Img(i+1,j,2)+Img(i-1,j+1,2)+Img(i+1,j-1,2))/8;
                        g = (Img(i-1,j-1,3)+Img(i+1,j+1,3)+Img(i,j-1,3)+Img(i-1,j,3)+Img(i,j+1,3)+Img(i+1,j,3)+Img(i-1,j+1,3)+Img(i+1,j-1,3))/8;

                    denom = 15;
                    
                    xxx_r = abs(xxx_r);
                    xxx_b = abs(xxx_b);
                    xxx_g = abs(xxx_g);
                    
                   thresh = 2; %0 for letters, 2 for horse
                   if (Img(i,j,1)+xxx_r/denom-r) < thresh
                        Img(i,j,1) = Img(i,j,1)+xxx_r/denom;                         
                   end
                   if (Img(i,j,2)+xxx_b/denom-b) < thresh
                        Img(i,j,2) = Img(i,j,2)+xxx_b/denom;                     
                   end
                   if (Img(i,j,3)+xxx_g/denom-g) < thresh
                        Img(i,j,3) = Img(i,j,3)+xxx_g/denom;
                   end
                    end        

                    end
            end
end

figure,imshow(uint8(Img));
title('PDE Inpainted Output Image');