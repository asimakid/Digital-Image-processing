function wout = gaussian(z,zmax,zmin)
    truearray1 =  z >= zmin;
    truearray2 =  z  <=  zmax;    
    gaussiantemp = exp(-16*(z-0.5).^2);
    nonzeros= truearray1.*truearray2;
    wout = nonzeros.*gaussiantemp;
    size(wout)
end