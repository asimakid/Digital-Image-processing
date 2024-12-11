function pairsresult = pairs(pd1,pd2)
    pairstemp = [];   
    length = size(pd1,2);
   for i = 1:size(pd1,1)
       %avoiding the element with zero local descriptor
       if ~any(pd1(i,:))
           %if  all descriptor elements are zero..this were close the
           %bountry of image so have zero local descriptor
            continue;
       end           
        min=[];
        %thrshold has an upper limit so that we finally choose only points
       %that really match.if there was no threshold then there would have
       %been many point pairs with minimum criteria between the others but
       %their descriptors will not be so close
       
       
       % thres is 15  for local descriptor  and 200 for upgrade
        thres = 20;
        for j= 1:size(pd2,1)
            if ~any(pd2(j,:))
               %if  all descriptor elements are zero..this were close the
               %bountry of image so have zero local descriptor
                continue;
            end
            %will not use exxactly the imsse since its calculation is havya
            % and alla descriptors have the same length 
            % so we can stay to norm calculation 
            %err = (norm(x(:)-y(:),2).^2)/numel(x);
            %immse(pd1(i,:),pd2(j,:))
            tempnorm = norm(pd1(i,:)-pd2(j,:),2);
            if tempnorm<thres
                min=[i j];
                thres = tempnorm;
            end
        end
        pairstemp=[pairstemp;min];
   end 
   pairstemp2 = unique(pairstemp,'rows');
   pairsresult = pairstemp2;
end
