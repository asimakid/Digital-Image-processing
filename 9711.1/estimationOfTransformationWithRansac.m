function [R,T] = estimationOfTransformationWithRansac(points1,points2)
    %number of iterations for the ransac method
    R = [];
    T = [];
    iterations = 20000;
    maximum = 0;
    thres = 20;
    npoints = size(points1);
    npoints = npoints(1,1);
    for i = 1:iterations
        %getting the three random points
        index = randi(npoints,2,1);
        while length(unique(index)) ~=2
           index = randi(npoints,2,1);
        end
        p1 = points1(index(1),:);
        p2 = points1(index(2),:);
        np1 = points2(index(1),:);
        np2 = points2(index(2),:);
        x1 =  p1(1,1);
        y1 =  p1(1,2);
        x2 =  p2(1,1);
        y2 =  p2(1,2);
        nx1 =  np1(1,1);
        ny1 =  np1(1,2);
        nx2 =  np2(1,1);
        ny2 =  np2(1,2);
        [Rtemp,Ttemp] = calculateTransformation(x1,y1,x2,y2,nx1,ny1,nx2,ny2);
        %calculating the position of poins based on Rtemp and Ttemp
        for j= 1:npoints
          newpoints(j,:) = (Rtemp*points1(j,:)'+Ttemp)';
        end
        error = newpoints - points2;
        squares = error.^2;
        criteria = sqrt(squares(:,1)+squares(:,2))<thres;
        tempnumber = sum(criteria,'All');
        if tempnumber>maximum
            maximum = tempnumber;
            R = Rtemp;
            T = Ttemp;
        end        
    end 
end