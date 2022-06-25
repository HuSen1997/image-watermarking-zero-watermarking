function [  attacked ] = Attack_bunch1( img )
%attack embedded image in 'median filtering','wiener filtering','gaussian noise''s&p noise', 'speckle noise','JPEG compression','resize image','cut''rotate','move right down'

a=1;
attacked{1,1}=img;  attacked{2,1}='no attack';     a=a+1;

[~,~,s]=size(img);
if s==3
    for i=3:2:5
        
        attacked{1,a}(:,:,1)= medfilt2( img(:,:,1),[i i]);
        attacked{1,a}(:,:,2)= medfilt2( img(:,:,2),[i i]);
        attacked{1,a}(:,:,3)= medfilt2( img(:,:,3),[i i]);  
        attacked{2,a}=strcat('median filtering',num2str(i),'*',num2str(i));
        a=a+1;
    end
    for i=3:2:5
        attacked{1,a}(:,:,1)= wiener2( img(:,:,1),[i i]);
        attacked{1,a}(:,:,2)= wiener2( img(:,:,2),[i i]);
        attacked{1,a}(:,:,3)= wiener2( img(:,:,3),[i i]);
        attacked{2,a}=strcat('wiener filtering',num2str(i),'*',num2str(i));
        a=a+1;
    end
elseif s==1
    for i=3:2:5
        attacked{1,a}= medfilt2( img,[i i]);    
        attacked{2,a}=strcat('median filtering',num2str(i),'*',num2str(i));
        a=a+1;
    end
    for i=3:2:5
        attacked{1,a}= wiener2( img,[i i]);
        attacked{2,a}=strcat('wiener filtering',num2str(i),'*',num2str(i));
        a=a+1;
    end
else
    error('only support input 1-channel or 3-channel image');
end

for i = 0.001:0.004:0.005
    attacked{1,a} = imnoise(img,'gaussian',0,i);    
    attacked{2,a}=strcat('gaussian noise',num2str(i));
    a=a+1;
end

for i = 0.001:0.004:0.005
    attacked{1,a} = imnoise(img,'salt & pepper',i); 
    attacked{2,a}=strcat('s&p noise',num2str(i));
    a=a+1;
end

for i =  0.001:0.004:0.005
    attacked{1,a} = imnoise(img,'speckle',i);      
    attacked{2,a}=strcat('speckle noise',num2str(i));
    a=a+1;
end

for i = 20:20:40
    imwrite(img,'temp.jpg','quality',i);%
    attacked{1,a} = imread('temp.jpg');   
    attacked{2,a}=strcat('JPEG compression',num2str(i));
    a=a+1;
end
J=imresize(img,2);
attacked{1,a}=imresize(J,0.5);   
attacked{2,a}=strcat('resize image*2*0.5');    a=a+1;

J=imresize(img,4);
attacked{1,a}=imresize(J,0.25);
attacked{2,a}=strcat('resize image*4*0.25');    a=a+1;



p = img;    p(1:64 , 1:64 , : ) = 0;  attacked{1,a} = p;  
attacked{2,a}=strcat('cut 64*64 pixel');      a=a+1;

for i=1:2:3
    attacked{1,a} = imrotate(img,i,'bilinear','crop');
    attacked{2,a}=strcat('rotate degree:',num2str(i));    a=a+1;
end

for i=1:2:3
    se1=translate(strel(1),[i i]);            
    attacked{1,a}=imdilate(img,se1);
    attacked{2,a}=strcat('move line:',num2str(i));a=a+1;
end 
end

