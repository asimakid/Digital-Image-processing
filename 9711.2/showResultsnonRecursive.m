function showResultsnonRecursive(clusterIdx,numberOfClusters,rows,cols)
    colorsMatrix = [[255 0 0 ];[0 255 0];[0 0 255];[255 255 0];[0 255 255];[255 0 255];[255 255 255];[127 0 0];[0 127 0];[0 0 127];[127 127 0];[0 127 127];[127 0 127];[127 127 127]];
    colorsNeeded = colorsMatrix(1:numberOfClusters,:);
    testIm = uint8(zeros(rows,cols,3));
    for i=1:numberOfClusters    
        tempelement = find(clusterIdx == i);
        pixeltemprow = floor((tempelement-1)/cols) + 1;
        pixeltempcol = mod(tempelement-1,cols) + 1 ;
        %testIm2(pixeltemprow,pixeltempcol,:) = colorsNeeded(i,:)'
        for k= 1: size(pixeltemprow,1)
                testIm(pixeltemprow(k),pixeltempcol(k),:) = colorsNeeded(i,:);
        end
    end
    figure('Name',['Non Recursive with ' num2str(numberOfClusters) ' clusters'])
    imshow(testIm)
end