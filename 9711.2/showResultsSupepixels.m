function showResultsSupepixels(clusterIdx,numberOfClusters,labels, rows,cols)
    colorsMatrix = [[255 0 0 ];[0 255 0];[0 0 255];[255 255 0];[0 255 255];[255 0 255];[255 255 255];...
    [127 0 0];[0 127 0];[0 0 127];[127 127 0];[0 127 127];[127 0 127];[127 127 127];...
    [50 0 0];[0 50 0];[0 0 50];[50 50 0];[0 50 50];[50 0 50];[50 50 50]];
    
    colorsNeeded = colorsMatrix(1:numberOfClusters,:);
    testIm = uint8(zeros(rows,cols,3));
     for i=1:numberOfClusters
            indexes = find(clusterIdx == i);
            for j=1:size(indexes,1)
                [rows,cols] = find(labels+1 == indexes(j));
                for k = 1:size(rows,1)
                    testIm(rows(k),cols(k),:) = colorsNeeded(i,:);
                end
            end
     end
    figure('Name',['Non Recursive  for superpixels with result of ' num2str(numberOfClusters) ' clusters'])
    imshow(testIm)
end