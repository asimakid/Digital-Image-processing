function c = myisCorner(I,p,k,Rthes,Ix2,Iy2,Ixy,gaussianFilter,half)
    imsize =size(I);
    rows = imsize(1,1);
    cols = imsize(1,2);
    px = p(1,1);
    py = p(1,2);
    
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
