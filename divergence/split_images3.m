function [  ] = split_images3(sourceImage,directorySG1,directorySG2,ext,blkLen)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
im=imread(sourceImage);
    
[m,n]=size(im);

LX=floor(m/blkLen);
LY=floor(n/blkLen);
    
m=floor(m/LX);
n=floor(n/LY);
    
for j=1:LX
    for k=1:LY
        im1=im(1+(j-1)*m:j*m,1+(k-1)*n:k*n);
        [fp ,fn, fe]=fileparts(sourceImage);
        if(mod(j+k,2))
            imwrite(im1,[directorySG1 fn '_' num2str(j) '_' num2str(k) '.' ext],ext);
        else
            imwrite(im1,[directorySG2 fn '_' num2str(j) '_' num2str(k) '.' ext],ext);
        end
    end
end
end
