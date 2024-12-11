function c = isCorner(I,p,k,Rthes)
    I = double(I);
    I = I/max(I(:));
    imsize =size(I);
    rows = imsize(1,1);
    cols = imsize(1,2);
    maskfory= [-1 0 1];
    maskforx = [-1;0;1];   
    %derivative of x
    Ix  = conv2(I,maskforx,'same');
    %derivative of y
    Iy  = conv2(I,maskfory,'same');  
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix.*Iy;
    px = p(1,1);
    py = p(1,2);
    sigma = 1;
    filterwidth = round(sigma*3)*2+1;
    half = ceil(filterwidth/2);
    gaussianFilter = fspecial('gaussian',[filterwidth,filterwidth],sigma);
    [rowsg colsg] = size(gaussianFilter);
    M11=0;
    M12=0;
    M22=0;
    if px<half || py<half || px>rows-half ||py>cols-half
       % do no calculation cause mask is out of bounds
        c=0; % return zeros when mask cant fit
    else
        for i = 1:rowsg        
         for j = 1:colsg
            M11 = M11 + Ix2(px+i-half,py+j-half)*gaussianFilter(i,j);
            M12 = M12 + Ixy(px+i-half,py+j-half)*gaussianFilter(i,j);
            M22 = M22 + Iy2(px+i-half,py+j-half)*gaussianFilter(i,j);            
         end
        end
        M = [M11 M12;M12 M22];
        R = det(M) -k*trace(M)^2;
        c = R >= Rthes;
    end
end