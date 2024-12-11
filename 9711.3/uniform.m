function wout = uniform(z,zmax,zmin)
    truearray1 =  z >= zmin;
    truearray2 =  z  <=  zmax;
    nonzeros = truearray1.*truearray2;
    wout = nonzeros;
end