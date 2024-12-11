function myAffinityMat = Image2Graph(imIn)
    rgb = 1;
    %check if image is rgb
    if size(imIn,3)==3 
        rgb = 3;
    end
    rows = size(imIn,1);
    cols = size(imIn,2);
    if rgb == 3 
        imInr= imIn(:,:,1);
        imIng = imIn(:,:,2);
        imInb = imIn(:,:,3);
        myAffinityMat = eye(rows*cols,rows*cols);
        for i = 1:rows*cols 
            pixel1row = floor((i-1)/cols) + 1;
            pixel1col = mod(i-1,cols) + 1;
            for j = i+1:rows*cols 
                 pixel2row = floor((j-1)/cols) + 1;
                 pixel2col = mod(j-1,cols) + 1;
                 %fprintf("%d ", j);
                 %fprintf("[%d %d] [%d %d]\n",pixel1row,pixel1col,pixel2row,pixel2col);        
                p1r = double(imInr(pixel1row,pixel1col));
                p1g = double(imIng(pixel1row,pixel1col));
                p1b = double(imInb(pixel1row,pixel1col));
                p2r = double(imInr(pixel2row,pixel2col));
                p2g = double(imIng(pixel2row,pixel2col));
                p2b = double(imInb(pixel2row,pixel2col));
                distance = sqrt((p1r-p2r)^2+(p1g-p2g)^2+(p1b-p2b)^2);
                tempresult = 1/ exp(distance);
                myAffinityMat(i,j) = tempresult;
                myAffinityMat(j,i) = tempresult;
            end 
        end
    else
         myAffinityMat = eye(rows*cols,rows*cols);
        for i = 1:rows*cols 
            pixel1row = floor((i-1)/cols) + 1;
            pixel1col = mod(i-1,cols) + 1;
            for j = i+1:rows*cols 
                 pixel2row = floor((j-1)/cols) + 1;
                 pixel2col = mod(j-1,cols) + 1;
                 %fprintf("%d ", j);
                 %fprintf("[%d %d] [%d %d]\n",pixel1row,pixel1col,pixel2row,pixel2col);        
                pixel1 = int8(imIn(pixel1row,pixel1col));
                pixel2 = int8(imIn(pixel2row,pixel2col));
                tempresult = exp(double(-abs(pixel1-pixel2)));
                myAffinityMat(i,j) = tempresult;
                myAffinityMat(j,i) = tempresult;
            end 
        end
    end
    
end

