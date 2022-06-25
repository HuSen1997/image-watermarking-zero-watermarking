function [ extract_w ] = extract_schur_colour( attimg,pk )
%extract message from embedded colour image
%   Detailed explanation goes here
attimg=double(attimg);

w_len=sum(sum(pk{1,1}));
bin_w(1,:)= Single_channel_extract( attimg(:,:,1),pk{1,1},w_len );
w_len=sum(sum(pk{1,2}));
bin_w(2,:)= Single_channel_extract( attimg(:,:,2),pk{1,2},w_len );
w_len=sum(sum(pk{1,3}));
bin_w(3,:)= Single_channel_extract( attimg(:,:,3),pk{1,3},w_len );

[ extract_w ] = binsequence2rgbimg( bin_w );
extract_w=uint8(extract_w);
end

