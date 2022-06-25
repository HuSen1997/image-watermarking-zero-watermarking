function [ reimg,pk ] = embed_schur_colour( img,W,beita,Threshold )
%colour image embed process
%   Detailed explanation goes here
img = double(img);
bin_W = rgbimg2binsequence( W );
[reimg(:,:,1),pk{1,1}] = Single_channel_embedd( img(:,:,1), bin_W(1,:), beita,Threshold );
[reimg(:,:,2),pk{1,2}] = Single_channel_embedd( img(:,:,2), bin_W(2,:), beita,Threshold );
[reimg(:,:,3),pk{1,3}] = Single_channel_embedd( img(:,:,3), bin_W(3,:), beita,Threshold );

reimg = uint8(reimg);


end

