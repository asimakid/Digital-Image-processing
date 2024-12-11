function [R,T] = calculateTransformation(x1,y1,x2,y2,nx1,ny1,nx2,ny2)
    A = [ x1 -y1  1 0 ;...
          y1 x1 0 1 ;...
          x2 -y2 1 0 ;...
          y2 x2 0 1];
    b = [nx1;ny1;nx2;ny2];
    result = inv(A)*b;
    R = [result(1) -result(2);result(2) result(1)];
    T = [result(3); result(4)];
end
