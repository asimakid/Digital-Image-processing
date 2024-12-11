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
lntks = log(tks);
exposuresred(:,:,:) = exposures(:,:,1,:);
exposuresgreen(:,:,:) = exposures(:,:,2,:);
exposuresblue(:,:,:) = exposures(:,:,3,:);
[gr,lner] = estimateResponseCurve(exposuresred,lntks,10,@uniform);
[gg,lneg] = estimateResponseCurve(exposuresgreen,lntks,10,@uniform);
[gb,lneb] = estimateResponseCurve(exposuresblue,lntks,10,@uniform);
figure 
scatter(gr,0:255)
title("Estimated response of camera for red from set 1")
xlabel("Logarithmic exposure/number of photons")
ylabel("Value of Z")
figure 
scatter(gg,0:255)
title("Estimated response of camera for green from set 1")
xlabel("Logarithmic exposure/number of photons")
ylabel("Value of Z")
figure 
scatter(gb,0:255)
title("Estimated response of camera for blue from set 1")
xlabel("Logarithmic exposure/number of photons")
ylabel("Value of Z")
radianceMapreduni = mergeLDRStackfordemo3(exposuresred,tks,@uniform,0,gr);
radianceMapgreenuni = mergeLDRStackfordemo3(exposuresgreen,tks,@uniform,0,gg);
radianceMapblueuni = mergeLDRStackfordemo3(exposuresblue,tks,@uniform,0,gb);
gamma = 0.9;
red = toneMapping(radianceMapreduni, gamma);
green = toneMapping(radianceMapgreenuni, gamma);
blue = toneMapping(radianceMapblueuni, gamma);
finalimage(:,:,1) = red;
finalimage(:,:,2) = green;
finalimage(:,:,3) = blue;
figure 
imshow(finalimage)

%%SET 2 OF PICTURES
nexposures2 = 7;
exposures2 = [];
for i = 1 :7
  name = "C:\Users\userPc\dip_3\Image2\sample2-0" + num2str(i-1) +".jpg";
    exposures2(:,:,:,i) = imread(name);
end 
tks2 =   [1/400, 1/250, 1/100, 1/40, 1/25, 1/8, 1/3];
lntks2 = log(tks2);
exposuresred2(:,:,:) = exposures2(:,:,1,:);
exposuresgreen2(:,:,:) = exposures2(:,:,2,:);
exposuresblue2(:,:,:) = exposures2(:,:,3,:);
[gr2,lner2] = estimateResponseCurve(exposuresred2,lntks2,1,@uniform);
[gg2,lneg2] = estimateResponseCurve(exposuresgreen2,lntks2,1,@uniform);
[gb2,lneb2] = estimateResponseCurve(exposuresblue2,lntks2,1,@uniform);
figure 
scatter(gr2,0:255)
title("Estimated response of camera for red from set 2")
xlabel("Logarithmic exposure/number of photons")
ylabel("Value of Z")
figure 
scatter(gg2,0:255)
title("Estimated response of camera for green from set 2")
xlabel("Logarithmic exposure/number of photons")
ylabel("Value of Z")
figure 
scatter(gb2,0:255)
title("Estimated response of camera for blue from set 2")
xlabel("Logarithmic exposure/number of photons")
ylabel("Value of Z")
radianceMapreduni2 = mergeLDRStackfordemo3(exposuresred2,tks2,@uniform,0,gr2);
radianceMapgreenuni2 = mergeLDRStackfordemo3(exposuresgreen2,tks2,@uniform,0,gg2);
radianceMapblueuni2 = mergeLDRStackfordemo3(exposuresblue2,tks2,@uniform,0,gb2);
gamma = 0.9;
red2 = toneMapping(radianceMapreduni2, gamma);
green2 = toneMapping(radianceMapgreenuni2, gamma);
blue2 = toneMapping(radianceMapblueuni2, gamma);
finalimage2(:,:,1) = red2;
finalimage2(:,:,2) = green2;
finalimage2(:,:,3) = blue2;
figure 
imshow(finalimage2)

