function wout = tent(z,zmax,zmin)
    truearray1 =  z >= zmin;
    truearray2 =  z  <=  zmax;    
    minmatrix = min(z,1-z);
    nonzeros = truearray1.*truearray2;
    wout = nonzeros.*minmatrix;
end