function radianceMap = mergeLDRStack(imgStack,exposureTimes,weightingFcn,photon)
    %given that the response of camera is linear
    zmax = 0.95;
    zmin = 0.05;
    M = size(imgStack(:,:,1),1);
    N = size(imgStack(:,:,1),2);
    radianceMap = zeros(M,N);
    k = length(exposureTimes);
    biggerthanzmax = imgStack>zmax;
    smallerthanzmin = imgStack<zmin;
    correctStack =(imgStack<zmax).*(imgStack>zmin);
    %keep only the element between zmax and zmin)
    imgStackforln = correctStack.*imgStack;
    imgStackforln = imgStackforln + zmax*biggerthanzmax + zmin*smallerthanzmin;
    g = log(imgStackforln);
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