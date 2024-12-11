rng(1)
imIn = imread('bee.jpg');
rows = size(imIn,1);
cols = size(imIn,2);
[labels , ~] = slicmex(imIn,400,20);
[result,list] = superpixelDescriptor(imIn,labels);
size(list)
size(labels)
figure('Name',['Superpixels of image'])
imshow(result)
%creation of graph for superpixels
graphSuperpixel = im2Graphforlist(list);
%recursive ncuts 
thres1 = 5;
thres2 = 0.94;
[arraySuper,iarraySuper,leafSuper] = recursiveNcuts(graphSuperpixel,1,{},[],[],0,thres1,thres2);
showResultsSupepixelsRacursive(arraySuper,iarraySuper,leafSuper,labels,rows,cols);
thres1 = 5;
thres2 = 0.96;
[arraySuper2,iarraySuper2,leafSuper2] = recursiveNcuts(graphSuperpixel,1,{},[],[],0,thres1,thres2);
showResultsSupepixelsRacursive(arraySuper2,iarraySuper2,leafSuper2,labels,rows,cols);
graphk6 = myGraphSpectralClustering(graphSuperpixel,6);
showResultsSupepixels(graphk6,6,labels,rows,cols)
graphk10 = myGraphSpectralClustering(graphSuperpixel,10);
showResultsSupepixels(graphk10,10,labels,rows,cols)