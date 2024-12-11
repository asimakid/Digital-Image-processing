function showResults(array,iarray,leaf,rows,cols)
    colorsMatrix = [[255 0 0 ];[0 255 0];[0 0 255];[255 255 0];[0 255 255];[255 0 255];[255 255 255];[127 0 0];[0 127 0];[0 0 127];[127 127 0];[0 127 127];[127 0 127];[127 127 127]];
    [leafesrows,leafescols] = find(leaf);
    positions = [leafesrows leafescols];
    clusters = {};
    for i=1:size(positions,1)
        clusters{end+1} = array{positions(i,1),positions(i,2)};
    end
    numberOfClusters = size(clusters,2);
    colorsNeeded = colorsMatrix(1:numberOfClusters,:);
    testIm = uint8(zeros(rows,cols,3));
    for i=1:size(clusters,2)
        tempelement = clusters{1,i};
        pixeltemprow = floor((tempelement-1)/cols) + 1;
        pixeltempcol = mod(tempelement-1,cols) + 1 ;
        for k= 1: size(pixeltemprow,2)
                testIm(pixeltemprow(1,k),pixeltempcol(1,k),:) = colorsNeeded(i,:);
        end
    end
    figure('Name',['Recursive with result of ' num2str(numberOfClusters) ' clusters'])
    imshow(testIm)
end