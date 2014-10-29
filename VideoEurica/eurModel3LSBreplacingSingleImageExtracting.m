function [ message ] = eurModel3LSBreplacingSingleImageExtracting(pEmb,im)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[~,~,dim]=size(im);
if(dim==1)
    im1=im;
elseif (dim==3)
    im1=im(:,:,2);
else
    assert(0);
end
    
sz=size(im1);
sizeX=sz(1);
sizeY=sz(2);
    
rng(0);% Can replace with secret key in future
mask=randsrc(sizeX,sizeY,[1 0; pEmb 1-pEmb]);


emb=[zeros(1,sum(mask(:)))];

extractedQty=0;
for j=1:sizeX
    for k=1:sizeY        
        if(mask(j,k)==1)
            emb(extractedQty+1)=mod(im1(j,k),2);            
            extractedQty=extractedQty+1;
        end        
    end
end
    

message=emb;

end

