rng(1)
dip_2_file = load('dip_hw_2');
d2a = dip_2_file.d2a;
d2b = dip_2_file.d2b;
grapha = Image2Graph(d2a);
graphb = Image2Graph(d2b);
% k = 3
grapha3clusters = myGraphSpectralClustering(grapha,3);
graphb3clusters = myGraphSpectralClustering(graphb,3);
% k = 4
grapha4clusters = myGraphSpectralClustering(grapha,4);
graphb4clusters = myGraphSpectralClustering(graphb,4);
%printing the results 
showResultsnonRecursive(grapha3clusters,3,50,50);
showResultsnonRecursive(graphb3clusters,3,50,50);
showResultsnonRecursive(grapha4clusters,4,50,50);
showResultsnonRecursive(graphb4clusters,4,50,50);