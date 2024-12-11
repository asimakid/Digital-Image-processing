%to get the same result from kmeans
rng(1);
dip_2_file = load('dip_hw_2');
d1a = dip_2_file.d1a;
d2a = dip_2_file.d2a;
d2b = dip_2_file.d2b;
imIn = uint8(d1a*10);
I = uint8(eye(3));
result = Image2Graph(I);
test = myGraphSpectralClustering(d1a,2)
graph1 = Image2Graph(d2a);
graph2 = Image2Graph(d2b);
graph1k3 = myGraphSpectralClustering(graph1,3);
graph1k4 = myGraphSpectralClustering(graph1,4);
graph2k3 = myGraphSpectralClustering(graph2,3);
graph2k4 = myGraphSpectralClustering(graph2,4);
graph1k2 = myGraphSpectralClustering(graph1,2);
graph2k2 = myGraphSpectralClustering(graph2,2);
