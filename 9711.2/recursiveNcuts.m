function [finalArray,indexArray,leafArray] = recursiveNcuts(anAffinityMat,level,finalArray,indexArray,leafArray,from,thres1,thres2)
    clusterIdx = myGraphSpectralClustering(anAffinityMat,2);
    ncutvalue = calculateNcut(anAffinityMat,clusterIdx)
    indexesA =  find(clusterIdx==1);
    indexesB =  find(clusterIdx==2);
    if ncutvalue < thres2 && length(indexesA) > thres1 && length(indexesB) > thres1 
        if size(finalArray,1) <level
            tempend=0;
        else
            tempend = size(finalArray(level,:),2);
            while size(finalArray{level,tempend}) == [0 0]
                tempend = tempend - 1;
            end
         end        
        indexArray(level,tempend+1) = 2*from+1;
        indexArray(level,tempend+2) = 2*from+2;
        [rowfrom,colfrom] = find(indexArray==from);
        if size(rowfrom,1)==1 &&size(rowfrom,2)==0 &&size(colfrom,1)==1 && size(colfrom,2)==0 
            finalArray(level,tempend+1) = {indexesA'};
            finalArray(level,tempend+2) = {indexesB'};
        else
            temp = finalArray{rowfrom,colfrom} ;
            finalArray(level,tempend+1) = {temp(indexesA)};
            finalArray(level,tempend+2) = {temp(indexesB)};
        end
            
        rowsforA = anAffinityMat(indexesA,:);
        matrixforallinA = rowsforA(:,indexesA);
        [finalArray,indexArray,leafArray] = recursiveNcuts(matrixforallinA,level+1,finalArray,indexArray,leafArray,2*from+1,thres1,thres2);       
        rowsforB = anAffinityMat(indexesB,:);        
        matrixforallinB = rowsforB(:,indexesB);       
        [finalArray,indexArray,leafArray] = recursiveNcuts(matrixforallinB,level+1,finalArray,indexArray,leafArray,2*from+2,thres1,thres2);      
    else   
        %recusion for this part stops here
        %this is leaf
        [rowfrom,colfrom] = find(indexArray==from);
        leafArray(rowfrom,colfrom) = 1;        
    end
end