function [ reimg,pp ] = Single_channel_embedd( single_channel_img, bin_W, beita,Threshold )
% embedd the watermark message into the gray image
%   Detailed explanation goes here

[s1,s2]=size(single_channel_img);
[~,ws2]=size(bin_W);
Block_num=s1/4;
if mod(Block_num,1)~=0
    error('Suggest image size as 512*512 ');
end
subBlock=mat2cell(single_channel_img,ones(1,Block_num)*s1/Block_num,ones(1,Block_num)*s2/Block_num);
%%  generate a binary map 
Rpp=rand(Block_num);
pp_L=reshape(Rpp,[1,Block_num^2]);
[~,pp_index]=sort(pp_L);
pp_number_index=pp_index(1,1:ws2);
pp_L(pp_number_index)=1.1;
pp_L(pp_L<=1)=0;
pp=reshape(pp_L,[Block_num,Block_num]);
pp(pp>1)=1;
%% embed
k = 1;
for i = 1:Block_num
    for j = 1:Block_num
        if pp(i,j) == 1%index of select blocks named as private key in paper page 8(step2)
            p = subBlock{i,j};
            [UU , TT] = schur(p);
            [x,y] = find(max(max(abs(TT))));% step4 of the paper in page 9
            U_ave = (abs(UU(2,y))+abs(UU(3,y)))/2;
            if bin_W(1,k) == 1 && abs(UU(2,y))-abs(UU(3,y))<=Threshold% step6 of the paper in page 9
                UU(2,y) = sign(UU(2,y))*(U_ave + beita*Threshold);
                UU(3,y) = sign(UU(3,y))*(U_ave - (1-beita)*Threshold);
            end
            if bin_W(1,k) == 0 && abs(UU(3,y))-abs(UU(2,y))<=Threshold
                UU(2,y) = sign(UU(2,y))*(U_ave - beita*Threshold);
                UU(3,y) = sign(UU(3,y))*(U_ave + (1-beita)*Threshold);
            end
            p = UU*TT*UU';%rebuild the matrix in schur way
            subBlock{i,j} = p;
            k = k+1;
        end
    end
end
reimg=cell2mat(subBlock);%rebuild the blocks 

end

