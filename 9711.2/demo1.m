rng(1)
dip_2_file = load('dip_hw_2');
d1a = dip_2_file.d1a;
fork2 = myGraphSpectralClustering(d1a,2);
fork3 = myGraphSpectralClustering(d1a,3);
fork4 = myGraphSpectralClustering(d1a,4);
showResultsnonRecursive(fork2,2,3,4)
showResultsnonRecursive(fork3,3,3,4)
showResultsnonRecursive(fork4,4,3,4)