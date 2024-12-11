function clusterIdx = myGraphSpectralClustering(anAffinityMat , k)
    D = diag(sum(anAffinityMat,1));
    L = D - anAffinityMat;
    %keep the egigenvalues/eigenvectors with the smallest real parts
    [U,Dt] = eigs(L,D,k,'smallestreal'); 
    %U has the eigenvectors in cols as needed
    clusterIdx  = kmeans(U,k);    
end

