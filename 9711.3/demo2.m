clear all
close all
clc
nexposures = 16;
exposures = [];
for i = 1 : 16
    name = "C:\Users\userPc\dip_3\Image1\exposure" + num2str(i) +".jpg";
    exposures(:,:,:,i) = imread(name);
end 
tks =   [1/2500,1/1000,1/500,1/250,1/125,1/60,...
    1/30,1/15,1/8, 1/4, 1/2, 1, 2, 4, 8,15];
exposuresred(:,:,:) = exposures(:,:,1,:)/255;
exposuresgreen(:,:,:) = exposures(:,:,2,:)/255;
exposuresblue(:,:,:) = exposures(:,:,3,:)/255;
radianceMapreduni = mergeLDRStack(exposuresred,tks,@uniform,0);
radianceMapgreenuni = mergeLDRStack(exposuresgreen,tks,@uniform,0);
radianceMapblueuni = mergeLDRStack(exposuresblue,tks,@uniform,0);
gamma = 1.4;
red = toneMapping(radianceMapreduni, gamma);
green = toneMapping(radianceMapgreenuni, gamma);
blue = toneMapping(radianceMapblueuni, gamma);
finalimage(:,:,1) = red;
finalimage(:,:,2) = green;
finalimage(:,:,3) = blue;
figure 
imshow(finalimage)



