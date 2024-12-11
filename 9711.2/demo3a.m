rng(1);
dip_2_file = load('dip_hw_2');
d1a = dip_2_file.d1a;
d2a = dip_2_file.d2a;
d2b = dip_2_file.d2b;
grapha = Image2Graph(d2a);
graphb = Image2Graph(d2b);
graphak2 = myGraphSpectralClustering(grapha,2);
graphbk2 = myGraphSpectralClustering(graphb,2);
ncuta = calculateNcut(grapha,graphak2)
ncutb = calculateNcut(graphb,graphbk2)
showResultsnonRecursive(graphak2,2,50,50)
showResultsnonRecursive(graphbk2,2,50,50)
