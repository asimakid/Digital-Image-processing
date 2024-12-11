image1 = imread('TestIm1.png');
image2 = imread('TestIm2.png');
%{
figure(1)
imshow(image1);
result1 = myImgRotation(image1,35);
figure(2)
imshow(result1);
result2 = myImgRotation(image1,222);
figure(3)
imshow(result2);
image1grayscale = rgb2gray(image1);
result1grayscale = rgb2gray(result1);
result2grayscale = rgb2gray(result2);
p1 = [100,100];
p2 = [200,200];
p3 = [202,202];
T1 = [0.8192 -0.5736;0.5736 0.8192];
T2 = [-0.7431 0.6691;-0.6691 -0.7431];
tx1 = 703;
ty1 = 0;
tx2 = 919;
ty2 = 1738;
n1p1 = round(T1*[99;99] + [tx1+1;ty1+1])';
n1p2 = round(T1*[199;199]  + [tx1+1;ty1+1])';
n1p3 = round(T1*[201;201] + [tx1+1;ty1+1])';
n2p1 = round(T2*[99;99] + [tx2+1;ty2+1])';
n2p2 = round(T2*[199;199] + [tx2+1;ty2+1])';
n2p3 = round(T2*[201;201] + [tx2+1;ty2+1])';
p1d=myLocalDescriptorUpgrade(image1grayscale,p1,5,20,1,8);
p2d=myLocalDescriptorUpgrade(image1grayscale,p2,5,20,1,8);
p3d=myLocalDescriptorUpgrade(image1grayscale,p3,5,20,1,8);
n1p1d=myLocalDescriptorUpgrade(result1grayscale,n1p1,5,20,1,8);
n1p2d=myLocalDescriptorUpgrade(result1grayscale,n1p2,5,20,1,8);
n1p3d=myLocalDescriptorUpgrade(result1grayscale,n1p3,5,20,1,8);
n2p1d=myLocalDescriptorUpgrade(result2grayscale,n2p1,5,20,1,8);
n2p2d=myLocalDescriptorUpgrade(result2grayscale,n2p2,5,20,1,8);
n2p3d=myLocalDescriptorUpgrade(result2grayscale,n2p3,5,20,1,8);
[test,corners2] =myDetectHarrisFeaturesUpgrade(image1grayscale,0.04,0.002);
corners1 = myDetectHarrisFeatures(image1grayscale);
showHarris1 = showHarris(image1,corners1);
figure(10)
imshow(showHarris1);
showHarris2 = showHarris(image1,corners2);
figure(11) 
imshow(showHarris2);
result3 = myImgRotation(result1grayscale,90);
figure(4)
imshow(result3);
%}
myStitch(image1,image2);