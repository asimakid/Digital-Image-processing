function [g,lne] = estimateResponseCurve(imgStack,exposureTimes,...
    smoothingLamda,weightingFcn)
    zmax = 255;
    zmin = 0;
    %to be able to store thw matrix A we need to sumbsable the images 
    %n is the step of the sampling rate in every  
    subn=50;
    n = 256; % the number of differen  ceils
    sampledImages = imgStack(1:subn:end,1:subn:end,:);
    size(sampledImages)
    numberofsamples = size(sampledImages(:,:,1));
    numberofsamples = numberofsamples(1,1)*numberofsamples(1,2);
    numberofpictures = size(sampledImages,3)
    %each column has all the samples of the image 
    %dimension is numberofsamples*numberofimages 
    sampledImagesinvectors = zeros(numberofsamples,numberofpictures);
    for i = 1 : numberofpictures
        sampledImagesinvectors(:,i) = reshape(sampledImages(:,:,i),[],1);    
    end
    A = (zeros(numberofsamples*numberofpictures+n+1,numberofsamples+n));
    b = (zeros(numberofsamples*numberofpictures+n+1,1));
    size(b);
    %matrix is seperated in two parts based on the rows
    %the first is the coeeficients for the samples part
    rowcounter = 1;
    for i = 1 : numberofsamples
            for j = 1 : numberofpictures
                tempz = sampledImagesinvectors(i,j);
                tempweigth = weightingFcn(tempz + 1,zmax,zmin);
                A(rowcounter,tempz + 1) = tempweigth;
                A(rowcounter, n + i) = -tempweigth;
                j;
                b(rowcounter,1) =  tempweigth*exposureTimes(j);
                
                rowcounter = rowcounter+1;
            end
    end
    A(rowcounter,129) = 1;
    rowcounter = rowcounter + 1;
    % the other elementsa for the smoothess
    for i =1:n-2
        A(rowcounter,i) = smoothingLamda*weightingFcn(i+1,zmax,zmin);
        A(rowcounter,i+1) = -2*smoothingLamda*weightingFcn(i+1,zmax,zmin);
        A(rowcounter,i+2) = smoothingLamda*weightingFcn(i+1,zmax,zmin);    
        rowcounter = rowcounter + 1;
    end
    x = mldivide(A,b);
    g = x(1:n);
    lne = x(n+1:size(x,1));
end