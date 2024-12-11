function radianceMap = mergeLDRStackfordemo3(imgStack,exposureTimes,weightingFcn,photon,gfunction)
    %given that the response of camera is linear
    imgStack = int64(imgStack);
    zmax = 255;
    zmin = 5;
    M = size(imgStack(:,:,1),1);
    N = size(imgStack(:,:,1),2);
    radianceMap = zeros(M,N);
    k = length(exposureTimes);
    %biggerthanzmax = int64(imgStack>zmax);
    %smallerthanzmin = int64(imgStack<zmin);
    %correctStack = int64((imgStack<zmax)).*int64((imgStack>zmin));
    %keep only the element between zmax and zmin)
    imgStackforln = int64(imgStack);
   % imgStackforln = int64(imgStackforln + zmax*biggerthanzmax + zmin*smallerthanzmin);
    g = gfunction(imgStackforln(:,:,:)+1);
    imgStack = double(imgStack)/255;
    zmax = 0.99;
    zmin = 0.05;
    for i = 1 : k 
        lntimes(:,:,i) = ones(M,N)*log(exposureTimes(i));
    end    
    a = g-lntimes;   
    if photon == 1
        weightsstack = weightingFcn(imgStack,exposureTimes,zmax,zmin);    
    else
        
        weightsstack = weightingFcn(imgStack,zmax,zmin);
    end  
    weightsstack = double(weightsstack);
    b = weightsstack.*a;
    paronomastis = sum(weightsstack,3); 
    zeroelements = ~paronomastis;
    %an einai na einai ola megalutera i mikrotera tha einai kai stin prwti
    elementsbiggerthanthreshold = zeroelements.*(imgStack(:,:,1) > zmax);
    elementssmallaerthanthreshold  = zeroelements.*(imgStack(:,:,k) < zmin);
    paronomastis = paronomastis + zeroelements;
    arithmitis = sum(b,3);
    radianceMaptemp = arithmitis./paronomastis;
    radianceMapmax = max(radianceMaptemp(:));
    radianceMapmin = min(radianceMaptemp(:));
    %correct paronomastis contains 1 in
    arithmitis  = arithmitis + ...
        radianceMapmax*elementsbiggerthanthreshold+...
        radianceMapmin*elementssmallaerthanthreshold;
    radianceMap = arithmitis./paronomastis;     
end 