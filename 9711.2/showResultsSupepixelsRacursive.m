function showResultsSupepixelsRacursive(array,iarray,leaf,labels,rows,cols)
    colorsMatrix = [[255 0 0 ];[0 255 0];[0 0 255];[255 255 0];[0 255 255];[255 0 255];[255 255 255];...
    [127 0 0];[0 127 0];[0 0 127];[127 127 0];[0 127 127];[127 0 127];[127 127 127];...
    [50 0 0];[0 50 0];[0 0 50];[50 50 0];[0 50 50];[50 0 50];[50 50 50]];
    [leafesrows,leafescols] = find(leaf);
    positions = [leafesrows leafescols];
    clusters = {};
    for i=1:size(positions,1)
        clusters{end+1} = array{positions(i,1),positions(i,2)};
    end
    numberOfClusters = size(clusters,2);
    colorsNeeded = colorsMatrix(1:numberOfClusters,:);
    testIm = uint8(zeros(rows,cols,3));
    for i=1:numberOfClusters
        tempelement = clusters{1,i};
         for j = 1:length(tempelement)
            [rows,cols] = find(labels + 1 == tempelement(j));
            for k=1:size(rows,1)
              testIm(rows(k),cols(k),:) = colorsNeeded(i,:);
            end
        end
    end 
    figure('Name',['Recursive  for superpixels with result of ' num2str(numberOfClusters) ' clusters'])
    imshow(testIm)
end