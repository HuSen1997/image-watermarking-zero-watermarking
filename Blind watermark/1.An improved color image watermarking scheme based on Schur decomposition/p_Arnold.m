function [ F ] = p_Arnold( img,Frequency,crypt )
%Arnold scrambling encryption 
%   inpute:image(img),secret key(Frequency), encrypt/decrypt(0 or else)
[s1,s2] = size(img);

F = zeros(s1,s2);
if crypt == 0%encrypt
    for f = 1:Frequency
        for i = 1:s1
            for j = 1:s2
                F(mod(i+j-2,s1)+1,mod(i+2*j-3,s2)+1) = img(i,j);
            end
        end
        img = F;
    end
else%decrypt
    for f = 1:Frequency
        for i = 1:s1
            for j = 1:s2
                F(mod(2*i-j-1,s1)+1,mod(j-i,s2)+1) = img(i,j);
            end
        end
        img = F;
    end
end

end

