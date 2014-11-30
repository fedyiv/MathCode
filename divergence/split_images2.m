function [  ] = split_images2(sourceImage,directorySG,ext,blkLen)
%Splitting one big image in the folder directorySource to blocks of size
%blkLen x blkLen
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
        imwrite(im1,[directorySG fn '_' num2str(j) '_' num2str(k) '.' ext],ext);
    end
end
end
