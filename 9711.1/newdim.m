function [rowsnew,colsnew] = newdim (img,R,T,angle)
   angleInRad = angle*2*pi/360;
   scale = size(img);
   rows = scale(1,1);
   cols = scale(1,2);
   %the four angles 
   A = [1;1];
   B = [1;cols];
   C = [rows;cols];
   D = [rows;1];
   %new position for the corners
   Anew = round((R*A)+T);
   Bnew = round((R*B)+T);
   Cnew = round((R*C)+T);
   Dnew = round((R*D)+T);
   %transportation of angle in rad calculation
   if  angle >= 0 && angle < 90
        rowsnew = Dnew(1);
        colsnew = Cnew(2);
   elseif angle >= 90 && angle < 180
       %tx = Cnew(1);
       %ty = Bnew(2);  
       rowsnew = 0;
       colsnew = Dnew(2);
   elseif angle >= 180 && angle < 270
       %tx = Dnew(1);
       %ty = Cnew(2);
       rowsnew = Bnew(1);
       colsnew = 0;
   elseif  angle >= 270 && angle < 360 
       %tx = 0;
       %ty = Dnew(2);
       rowsnew = 0;
       colsnew = Bnew(2);
   end   
 % rowsnew = rowsnew  + transx;
  %colsnew = colsnew + transy;
end