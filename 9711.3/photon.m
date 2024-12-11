function wout = photon(z,tk,zmax,zmin)
    truearray1 =  z >= zmin;
    truearray2 =  z  <=  zmax;    
    %nonzeros array shows which elements are
    %betwwen zmin and zmax
    nonzeros = truearray1.*truearray2;
    k = length(tk);
    wout = zeros(size(z));
    for i = 1 : k 
        wout(:,:,i) = tk(i)*nonzeros(:,:,i);
    end   
end