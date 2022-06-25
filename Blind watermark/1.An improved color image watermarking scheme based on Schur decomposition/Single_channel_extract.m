function [ bin_w ] = Single_channel_extract( attreimg,pp,w_len )
%extract message from embedded gray image
%   Detailed explanation goes here
bin_w=zeros(1,w_len);
RresubBlock=mat2cell(attreimg,ones(1,128)*512/128,ones(1,128)*512/128);
k = 1;
for i = 1:128
    for j = 1:128
        if pp(i,j) == 1%index the block
            p = RresubBlock{i,j};
            p = double(p);
            [UU , TT] = schur(p);
            [x,y] = find(max(max(abs(TT))));
            
            if abs(UU(2,y))>abs(UU(3,y))
                bin_w(1,k) = 1;
            else
                bin_w(1,k) = 0;
            end
            k = k+1;
        end
        
    end
end

end

