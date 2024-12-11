clc 
clear all
close all
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
radianceMapredtent = mergeLDRStack(exposuresred,tks,@tent,0);
radianceMapredgauss = mergeLDRStack(exposuresred,tks,@gaussian,0);
radianceMapredphot = mergeLDRStack(exposuresred,tks,@photon,1);
radianceMapgreenuni = mergeLDRStack(exposuresgreen,tks,@uniform,0);
radianceMapgreentent = mergeLDRStack(exposuresgreen,tks,@tent,0);
radianceMapgreengauss = mergeLDRStack(exposuresgreen,tks,@gaussian,0);
radianceMapgreenphot = mergeLDRStack(exposuresgreen,tks,@photon,1);
radianceMapblueuni = mergeLDRStack(exposuresblue,tks,@uniform,0);
radianceMapbluetent = mergeLDRStack(exposuresblue,tks,@tent,0);
radianceMapbluegauss = mergeLDRStack(exposuresblue,tks,@gaussian,0);
radianceMapbluephot = mergeLDRStack(exposuresblue,tks,@photon,1);
%{
figure
imagesc(radianceMapreduni)
colorbar
figure
imagesc(radianceMapredtent)
colorbar
figure
imagesc(radianceMapredgauss)
colorbar
figure
imagesc(radianceMapredphot)
colorbar
figure
imagesc(radianceMapgreenuni)
colorbar
figure
imagesc(radianceMapgreentent)
colorbar
figure
imagesc(radianceMapgreengauss)
colorbar
figure
imagesc(radianceMapgreenphot)
colorbar
figure
imagesc(radianceMapblueuni)
colorbar
figure
imagesc(radianceMapbluetent)
colorbar
figure
imagesc(radianceMapbluegauss)
colorbar
figure
hist(radianceMapbluephot)

%}
figure
hist(radianceMapreduni)
figure
hist(radianceMapredtent)
figure
hist(radianceMapredgauss)
figure
hist(radianceMapredphot)
figure
hist(radianceMapgreenuni)
figure
hist(radianceMapgreentent)
figure
hist(radianceMapgreengauss)
figure
hist(radianceMapgreenphot)
figure
hist(radianceMapblueuni)
figure
hist(radianceMapbluetent)
figure
hist(radianceMapbluegauss)
figure
hist(radianceMapbluephot)

