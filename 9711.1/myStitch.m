 function Im=myStitch(im1,im2)
    im1gray = rgb2gray(im1);
    im2gray = rgb2gray(im2);
    [corners1,points1] = myDetectHarrisFeaturesUpgrade(im1gray,0.04,0.004);
    [corners2,points2] = myDetectHarrisFeaturesUpgrade(im2gray,0.04,0.004);
    corners1= uint8(corners1*255);
    corners2 = uint8(corners2*255);
    figure(200)
    imshow(corners1);
    figure(201)
    imshow(corners2);
    %d = the size of the descriptor 
    rmin = 1;
    rmax = 50;
    rstep = 1;
    rs = rmin:rstep:rmax;
    d = size(rs,2);
    %WHEN USING THE INITIAL DESCRIPTOR
    points1descriptor = zeros(size(points1,1),d);
    points2descriptor = zeros(size(points2,1),d);
   %WHEN USING THE UPGRADE DESCRIPTOR
    %points1descriptor = zeros(size(points1,1),2*d);
    %points2descriptor = zeros(size(points2,1),2*d);
    % creating the local descriptor for the first image pooints
    for  i = 1:size(points1,1)
        points1descriptor(i,:) =  myLocalDescriptor(im1gray,points1(i,:),rmin,rmax,rstep,180);      
    end
    %creating the local descriptor for the second image point
    size(points2descriptor)
    for  i = 1:size(points2,1)
        points2descriptor(i,:) =  myLocalDescriptor(im2gray,points2(i,:),rmin,rmax,rstep,180);      
    end
    %indexPairs = matchFeatures(points1descriptor,points2descriptor)
   % points1matched = zeros(size(points1,1),2);
   % points2matched = zeros(size(points2,1),2);
    %points1matched = points1(indexPairs(:,1),:);
   % points2matched = points2(indexPairs(:,2),:);
   % points1matched = [points1matched(:,2),points1matched(:,1)];
   % points2matched = [points2matched(:,2),points2matched(:,1)];
    mypairs = pairs(points1descriptor,points2descriptor);
    if size(mypairs) == [0 0]
       msg = 'Could not find any matching points.Check threshold of my pairs or check if images really match';
        error(msg) 
    end
    mypoints1matched = points1(mypairs(:,1),:);
    mypoints2matched = points2(mypairs(:,2),:);
    tempmypoints1matched = [mypoints1matched(:,2),mypoints1matched(:,1)];
    tempmypoints2matched = [mypoints2matched(:,2),mypoints2matched(:,1)];
    %scatter(points1matched(:,2),points2matched(:,2))
    %figure(100); 
    %showMatchedFeatures(im1,im2,points1matched,points2matched);  
    figure(101); 
    showMatchedFeatures(im1,im2,tempmypoints1matched,tempmypoints2matched); 
     %   figure(198) 
    %    scatter(mypoints1matched(:,1),mypoints2matched(:,1))
    %figure(199) 
       %  scatter(mypoints1matched(:,2),mypoints2matched(:,2))
     [R,T] = estimationOfTransformationWithRansac(mypoints2matched,mypoints1matched);
   % R  = inv(R)
    ctheta1 = R(1,1);
    stheta1 = -R(1,2);
    tx = T(1);
    ty = T(2);
    theta = atan2(stheta1,ctheta1)*180/(pi);
    %test = myImgRotation(im2,theta);
   % [rowsr colsr ~] = size(test);
   % rowsr 
   % colsr
    [rows1 cols1 ~] = size(im1);
    [rows2 cols2 ~] = size(im2);
    [rowsnew1 colsnew1 ~] = size(im1); 
    [rowsnew2 colsnew2] = newdim (im2,R,T,theta);
    %rotatedImage2 = myImgRotation(im2,theta);
   % figure(143)
    %imshow(rotatedImage2);
    rowsnew = max(rowsnew1,rowsnew2);
    colsnew = max(colsnew1,colsnew2);
    test2 = zeros(rowsnew,colsnew,3);    
    test2 = uint8(test2);
    u16im2 = uint16(im2);
    Pmatrix = uint16([0 1 0;1 4 1;0 1 0]);
    sumP = sum(Pmatrix,'all');
    invR = inv(R);
    for i = 1:rowsnew
        for j = 1:colsnew
           startingpoint = floor(invR*[i-tx;j-ty]);
            if startingpoint(1)>= 1 && startingpoint(2) >= 1 && startingpoint(1)<=rows2 && startingpoint(2)<=cols2
                if startingpoint(1)>=2 && startingpoint(1)<=rows2-1 && startingpoint(2)>=2 && startingpoint(2)<=cols2-1
                        %uint16 cause 4*temp(2,2) may overflow the limit of uint8
                        tempimage = u16im2(startingpoint(1)-1:startingpoint(1)+1,startingpoint(2)-1:startingpoint(2)+1,:);
                        tempimage = tempimage.*Pmatrix;
                        test2(i,j,:) = (sum(sum(tempimage,2),1))/sumP;
                  elseif (startingpoint(1) == 1 ||startingpoint(1) ==rows2)
                        test2(i,j,:)=im2(startingpoint(1),startingpoint(2),:);
                  elseif (startingpoint(2) == 1 || startingpoint(2)== cols2)                
                        test2(i,j,:)=im2(startingpoint(1),startingpoint(2),:);          
                end        
            elseif i >= 1 && j >= 1 && i<=rows1 && j<=cols1
                %if it belongs to the first image
                test2(i,j,:) = im1(i,j,:);
            else
                  test2(i,j,:) = [0 0 0];
            end
        end
    end
    figure(150)
    imshow(test2);
     
end