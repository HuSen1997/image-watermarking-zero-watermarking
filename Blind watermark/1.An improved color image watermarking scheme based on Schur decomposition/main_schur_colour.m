%Reference: An improved color image watermarking scheme based on Schur decomposition.
%Cite: Su, Q., Chen, B. An improved color image watermarking scheme based on Schur decomposition. Multimed Tools Appl 76, 24221¨C24249 (2017).
%Reference link: https://doi.org/10.1007/s11042-016-4164-x
%
%
%Code author: Hu sen
%e-mail:2641239165@qq.com
%e-mail:husen_232323@163.com
%code link : https://github.com/HuSen1997/image-watermarking-zero-watermarking
clear;clc;
close all;
%% inpute
img=imread('lena.tiff');
W = imread('logo32.png');
beita = 0.4;% recommended parameter in paper (Embedment strength)
Threshold = 0.04;% recommended parameter in paper (Embedment strength)
%% embed 
disp('embed process cost time:')
tic
[ reimg,pk ] = embed_schur_colour( img,W,beita,Threshold );%pk describe as private key in paper
toc

% show result and test
Psnr_num = psnr(img,reimg);
ssim_num=ssim(img,reimg);
figure('numbertitle','off','name','show the embeded results');
subplot(121); imshow(uint8(img)),title('Original image');
subplot(122); imshow(reimg),title('Embedded image'),xlabel(['Psnr/SSIM£º',num2str(Psnr_num),' / ',num2str(ssim_num)]);

%% attack 
att= Attack_bunch1( reimg );
[~,att_num]=size(att);
k=1;
%show the attack results
figure('numbertitle','off','name','show the attack results');
for k=1:att_num
    subplot(4,5,k);imshow(att{1,k});
    title(att{2,k});
end

%% extract
disp('extract process cost time:')% for test time cost
tic
w = extract_schur_colour( att{1,1},pk );
toc

for i=1:att_num
    extract_w{1,i} = extract_schur_colour( att{1,i},pk );%pk describe as private key in paper
    rgbnc{1,i}=RGBNC(extract_w{1,i},W);
end

%show the extract results
figure('numbertitle','off','name','show the extract results');
for k=1:att_num
    subplot(4,5,k);imshow(extract_w{1,k});
    title(strcat('NC=',num2str(rgbnc{1,k})));
end







