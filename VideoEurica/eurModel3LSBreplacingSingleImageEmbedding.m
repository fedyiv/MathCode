function [ im ] = eurModel3LSBreplacingSingleImageEmbedding(pEmb,message,im)
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

if(sum(mask(:))<numel(message))
    error('Impossible to embedd so many message bits in this CM')
end

emb=[message zeros(1,sum(mask(:))-numel(message))];

embeddedQty=0;
for j=1:sizeX
    for k=1:sizeY
        if(embeddedQty>=numel(message))
            break;
        end
        if(mask(j,k)==1)
            if(emb(embeddedQty+1)==1)
                if(mod(im1(j,k),2)==0)
                    im1(j,k)=im1(j,k)+1;
                end
            else
                if(mod(im1(j,k),2)==1)
                    im1(j,k)=im1(j,k)-1;
                end
            end
            embeddedQty=embeddedQty+1;
        end        
    end
end
    

if(dim==1)
    im=im1;
elseif (dim==3)
    im(:,:,2)=im1;;
else
    assert(0);
end
    %[fp fn fe]=fileparts(list{i});
    %imwrite(im1,[directorySG fn '.' ext],ext);  

end

