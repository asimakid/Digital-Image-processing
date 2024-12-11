function d = myLocalDescriptor(I,p,rhom,rhoM,rhostep ,N)
    imagesize = size(I);
    rows = imagesize(1);
    cols = imagesize(2);
    px = p(1);
    py = p(2);
    r = rhom:rhostep:rhoM;
    dsize = size(r);
    thetas = 0:2*pi/N:2*pi*(N-1)/N;
    d = zeros(dsize);
    dtemp = zeros(dsize);
    allpoints = 1;
    for i = 1:dsize(1,2) 
        rtemp = r(i);
        xtemp = zeros(1,N);
        size(thetas);
        for j = 1:N
            thetatemp = thetas(1,j);
            dx = rtemp*cos(thetatemp);
            dy = rtemp*sin(thetatemp);
            nx = floor(px+dx);
            ny = floor(py+dy);
            if nx>=2&&ny>=2&&nx<=rows-1&&ny<=cols-1
                xtemp(1,j) = sum(I(nx-1:nx+1,ny-1:ny+1),'all')/9;  
            elseif nx>=1&&ny>=1&&nx<=rows&&ny<=cols
                  xtemp(1,j) = I(nx,ny);
            else
                %means  there is a point out of image
                allpoints = 0;
                break
                %break the inner loop
            end
        end
        if allpoints == 1
             dtemp(1,i)=mean(xtemp);
        else
            % else means break the outter loop
            break
        end
    end
    if allpoints == 1
        d = dtemp; 
    end  
    %else means d is the zero vector as created    
end