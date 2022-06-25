function [ img_bin ] = rgbimg2binsequence( img )
%Transform color watermark logo into binary sequence add arnold encrypt wtih fixed key
%
%   Detailed explanation goes here
% img = imread('logo32.png');
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

R = p_Arnold(R,7,0);
G = p_Arnold(G,8,0);
B = p_Arnold(B,9,0);

img_bin = zeros(3,8192);
k = 1;
for i = 1:32
    for j = 1:32
        p = dec2bin(R(i,j),8);
        img_bin(1,(8*k-7):8*k) = boolean(p-'0');
        k = k+1;
    end
end
k = 1;
for i = 1:32
    for j = 1:32
        p = dec2bin(G(i,j),8);
        img_bin(2,(8*k-7):8*k) = boolean(p-'0');
        k = k+1;
    end
end
k = 1;
for i = 1:32
    for j = 1:32
        p = dec2bin(B(i,j),8);
        img_bin(3,(8*k-7):8*k) = boolean(p-'0');
        k = k+1;
    end
end

end

