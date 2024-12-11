rng(1);
dip_2_file = load('dip_hw_2');
d1a = dip_2_file.d1a;
d2a = dip_2_file.d2a;
d2b = dip_2_file.d2b;
figure(1)
imshow(d2a)
figure(2) 
imshow(d2b)
%creating the graphs
graph1 = Image2Graph(d2a);
graph2 = Image2Graph(d2b);
%sizes of images
rows1 = size(d2a,1);
cols1 = size(d2a,2);
rows2 = size(d2b,1);
cols2 = size(d2b,2);
%recursive ncuts for image a
thres1 = 5;
thres2 = 0.6;
[array1,iarray1,leaf1] = recursiveNcuts(graph1,1,{},[],[],0,thres1,thres2);
thres1 = 5;
thres2 = 0.8;
[array2,iarray2,leaf2] = recursiveNcuts(graph2,1,{},[],[],0,thres1,thres2);
%non Recursive for k = 2 
graph1k2 = myGraphSpectralClustering(graph1,2);
graph2k2 = myGraphSpectralClustering(graph2,2);
%non Recursive for k = 3
graph1k3 = myGraphSpectralClustering(graph1,3);
graph2k3 = myGraphSpectralClustering(graph2,3);
%showing results of recursive functions
showResults(array1,iarray1,leaf1,rows1,cols1);
showResults(array2,iarray2,leaf2,rows2,cols2);
%showing results for non recursive
showResultsnonRecursive(graph1k2,2,50,50)
showResultsnonRecursive(graph2k2,2,50,50)
showResultsnonRecursive(graph1k3,3,50,50)
showResultsnonRecursive(graph2k3,3,50,50)