function nCutValue = calculateNcut(anAffinityMat , clusterIdx)
    indexesA =  find(clusterIdx==1);
    indexesB =  find(clusterIdx==2);
    rowsforA = anAffinityMat(indexesA,:);
    rowsforB = anAffinityMat(indexesB,:);
    assocAV = sum(rowsforA,'all');
    assocBV = sum(rowsforB,'all');
    matrixforallinA = rowsforA(:,indexesA);
    matrixforallinB = rowsforB(:,indexesB);    
    assocAA = sum(matrixforallinA,'all');
    assocBB =  sum(matrixforallinB,'all');
    Nassoc = assocAA/assocAV + assocBB/assocBV;
    nCutValue = 2 - Nassoc;
end

