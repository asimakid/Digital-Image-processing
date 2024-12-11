function rotImg = myImgRotation(img, angle)
   angle = mod(angle,360);
   angleInRad = angle*2*pi/360;
   scale = size(img);
   rows = scale(1,1);
   cols = scale(1,2);
   if(size(scale)==[1 3])
       %this check mean the image is rgb colors
        rgb = 3;
   else 
       %if not rgb image then gray scale
        rgb = 1;
   end
   %the four angles 
   A = [0;0];
   B = [0;cols-1];
   C = [rows-1;cols-1];
   D = [rows-1;0];
   %rotation matrix without movement
   T = [cos(angleInRad) -sin(angleInRad);sin(angleInRad) cos(angleInRad)];
   Anew = floor(abs(T*A));
   Bnew = floor(abs(T*B));
   Cnew = floor(abs(T*C));
   Dnew = floor(abs(T*D));
   %transportation of angle in rad calculation
   if  angle >= 0 && angle < 90
        tx = Bnew(1);
        ty = 0;
        rowsnew = Bnew(1) + Dnew(1);
        colsnew = Cnew(2);
   elseif angle >= 90 && angle < 180
       tx = Cnew(1);
       ty = Bnew(2);  
       rowsnew = Cnew(1);
       colsnew = Bnew(2)+Dnew(2);
   elseif angle >= 180 && angle < 270
       tx = Dnew(1);
       ty = Cnew(2);
       rowsnew = Bnew(1) + Dnew(1);
       colsnew = Cnew(2);
   elseif  angle >= 270 && angle < 360 
       tx = 0;
       ty = Dnew(2);
       rowsnew = Cnew(1);
       colsnew = Bnew(2)+ Dnew(2);
   end 
  rowsnew = rowsnew+1;
  colsnew = colsnew+1;
  rotzeros = zeros(rowsnew,colsnew,rgb); 
  rotImg = uint8(rotzeros);
  inverseofT = inv(T);  
  % uint16 cause of overflow
  u16img = uint16(img);
  Pmatrix = uint16([0 1 0;1 4 1;0 1 0]);
  sumP = sum(Pmatrix,'all');
  for temprow = 1:rowsnew
      for tempcol = 1:colsnew
          initialcoord = floor(inverseofT*[temprow-1-tx;tempcol-1-ty]);
          %check if spot belonged to original image
          if initialcoord(1)>=1 && initialcoord(1)<=rows-2 &&initialcoord(2)>=1 && initialcoord(2)<=cols-2
                %uint16 cause 4*temp(2,2) may overflow the limit of uint8
                tempimage = u16img(initialcoord(1):initialcoord(1)+2,initialcoord(2):initialcoord(2)+2,:);
                tempimage = tempimage.*Pmatrix;
                rotImg(temprow,tempcol,:)= (sum(sum(tempimage,2),1))/sumP;
          elseif (initialcoord(1) == 0 || initialcoord(1) ==rows-1) &&(initialcoord(2)>=0 && initialcoord(2)<=cols-1)
                rotImg(temprow,tempcol,:)=img(initialcoord(1) +1 ,initialcoord(2)+1,:);
          elseif (initialcoord(2) == 0 || initialcoord(2)== cols-1) &&(initialcoord(1)>=0 && initialcoord(1)<=rows-1)                
                rotImg(temprow,tempcol,:)=img(initialcoord(1)+1,initialcoord(2)+1,:);              
          end
          %else all colors to zero since background is black          
      end
  end
end 