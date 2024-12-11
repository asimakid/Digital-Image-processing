function [corners,points] = myDetectHarrisFeaturesUpgrade(I,k,Rthes)
    sigma = 1;
    %filter for gaussian
    I = double(I);
    I = I/max(I(:));
    filterwidth = round(sigma*3)*2+1;
    gaussianFilter = fspecial('gaussian',[filterwidth,filterwidth],sigma);    
    imsize =size(I);
    rows = imsize(1,1);
    cols = imsize(1,2);
    corners = zeros(rows,cols);
    maskfory= [-1 0 1];
    maskforx = [-1;0;1]; 
    %derivative of x
    Ix  = conv2(I,maskforx,'same');
    %derivative of y
    Iy  = conv2(I,maskfory,'same');
    Ix(:,cols) = zeros(rows,1);
    Iy(rows,:) = zeros(1,cols);
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix.*Iy;
    Gxx = conv2(Ix2,gaussianFilter,'same');
    Gyy = conv2(Iy2,gaussianFilter,'same');
    Gxy = conv2(Ixy,gaussianFilter,'same');
    R = ((Gxx.*Gyy) - (Gxy.^2)) - k * (Gxx+Gyy).^2;
    R = R>Rthes;
    points = [];
    for j=  1:cols
        for i = rows:-1:1            
            if R(i,j) == 1 
               points = [points; [i,j]];
            end
        end
    end
    corners = R;
end