function [ res ] = binsequence2rgbimg( img_bin )
%Transform binary sequence into color logo add arnold encrypt with fixed key
%
%   Detailed explanation goes here
res = zeros(32,32,3);
k = 1;
m = 1;
n = 1;
while (m<=32)
    p = img_bin(1,(8*k-7):8*k);
    res(m,n,1) = p(1)*128 + p(2)*64 + p(3)*32 + p(4)*16 + p(5)*8 + p(6)*4 + p(7)*2 + p(8);
    if n == 32
        m = m+1;
        n = 0;
    end
    n = n+1;
    k = k+1;
end
k = 1;
m = 1;
n = 1;
while (m<=32)
    p = img_bin(2,(8*k-7):8*k);
    res(m,n,2) = p(1)*128 + p(2)*64 + p(3)*32 + p(4)*16 + p(5)*8 + p(6)*4 + p(7)*2 + p(8);
    if n == 32
        m = m+1;
        n = 0;
    end
    n = n+1;
    k = k+1;
end
k = 1;
m = 1;
n = 1;
while (m<=32)
    p = img_bin(3,(8*k-7):8*k);
    res(m,n,3) = p(1)*128 + p(2)*64 + p(3)*32 + p(4)*16 + p(5)*8 + p(6)*4 + p(7)*2 + p(8);
    if n == 32
        m = m+1;
        n = 0;
    end
    n = n+1;
    k = k+1;
end

res(:,:,1) = p_Arnold(res(:,:,1),7,1);
res(:,:,2) = p_Arnold(res(:,:,2),8,1);
res(:,:,3) = p_Arnold(res(:,:,3),9,1);

end

