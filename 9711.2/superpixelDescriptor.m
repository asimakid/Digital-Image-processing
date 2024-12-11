 function [outputImage,listSuperpixels] = superpixelDescriptor(imIn, labels)
    rows = size(imIn,1);
    cols = size(imIn,2);
    rgb = size(imIn,3);
    numberOfSuperpixels = max(labels,[],'all') +1;
    outputImage = uint8(zeros(rows,cols,rgb));
    listSuperpixels =[];
    for i=1:numberOfSuperpixels
        [trows,tcols] = find(labels == i-1);
        nelems = size(trows,1);
        tempsum = [0 0 0];
        for j = 1:nelems
            test = imIn(trows(j),tcols(j),:);
            test = double([test(1,1,1) test(1,1,2) test(1,1,3)]);
            tempsum = tempsum(:) + test(:);
        end
            tempresult = uint8(floor(tempsum/ nelems));   
         for j = 1:nelems
            outputImage(trows(j),tcols(j),:) = tempresult;
         end
        listSuperpixels =[listSuperpixels;tempresult'];     
    end
 end