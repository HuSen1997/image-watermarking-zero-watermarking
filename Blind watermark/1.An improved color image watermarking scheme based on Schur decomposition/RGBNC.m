function [ y ] = RGBNC( x1,x2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
x1=double(x1);
x2=double(x2);
[s1,s2,s3] = size(x1);
Mvalue1 = 0;
Mvalue2 = 0;
Mvalue3 = 0;
for k = 1:s3
    for i=1:s1
        for j=1:s2
            Mvalue1 = Mvalue1 + x1(i,j,k)*x2(i,j,k);
            Mvalue2 = Mvalue2 + x1(i,j,k)^2;
            Mvalue3  = Mvalue3 + x2(i,j,k)^2;
        end
    end
end
y = Mvalue1/(sqrtm(Mvalue2*Mvalue3));
end

