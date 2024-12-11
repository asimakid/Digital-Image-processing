function corners = myDetectHarrisFeatures(I) 
    I = double(I);
    I = I/max(I(:));
    imsize =size(I);
    rows = imsize(1,1);
    cols = imsize(1,2);
    corners = [];
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
    sigma = 1;
    filterwidth = round(sigma*3)*2+1;
    half = ceil(filterwidth/2);
    gaussianFilter = fspecial('gaussian',[filterwidth,filterwidth],sigma);
    for i=1:rows
        for j=1:cols
            if myisCorner(I,[i,j],0.04,0.002,Ix2,Iy2,Ixy,gaussianFilter,half) == 1
                corners = [corners;[i j]];
            end
        end
    end 
end