function myAffinityMat = im2Graphforlist(imIn)
    size(imIn)
    rgb = 1;
    rows = size(imIn,1)
    %check if image is rgb
    if size(imIn,2) == 3 
        rgb = 3;
    end
    if rgb == 3 
    size(imIn)
        imInr= double(imIn(:,1))/255;
        imIng = double(imIn(:,2))/255;
        imInb = double(imIn(:,3))/255;
        myAffinityMat = eye(rows,rows);
        for i = 1:rows
            p1r = double(imInr(i));
            p1g = double(imIng(i));
            p1b = double(imInb(i));
            for j = i+1:rows                
                 %fprintf("%d %d \n",i,j);
                 %fprintf("[%d %d] [%d %d]\n",pixel1row,pixel1col,pixel2row,pixel2col);        
                p2r = double(imInr(j));
                p2g = double(imIng(j));
                p2b = double(imInb(j));
                distance = sqrt((p1r-p2r)^2+(p1g-p2g)^2+(p1b-p2b)^2);
                tempresult = 1/exp(distance);
                myAffinityMat(i,j) = tempresult;
                myAffinityMat(j,i) = tempresult;
            end 
        end
    else
         myAffinityMat = eye(rows,rows);
        for i = 1:rows
            for j = i+1:rows
                 %fprintf("%d ", j);
                 %fprintf("[%d %d] [%d %d]\n",pixel1row,pixel1col,pixel2row,pixel2col);        
                pixel1 = int8(imIn(i));
                pixel2 = int8(imIn(j));
                tempresult = exp(double(-abs(pixel1-pixel2)));
                myAffinityMat(i,j) = tempresult;
                myAffinityMat(j,i) = tempresult;
            end 
        end
    end
    
end