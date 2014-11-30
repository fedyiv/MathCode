function [  ] = eurModel3emulateLSBreplacing(pEmb,directorySource,directorySG,ext)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

list=eurModel3getFiles(directorySource,ext);

N=numel(list);



for i=1:N

    if(mod(i,100)==0)
        disp(['Image ' list{i} ' is being processed']);
    end
    im=imread(list{i});
    im1=im;
    
    sz=size(im1);
    sizeX=sz(1);
    sizeY=sz(2);
    
    mask=randsrc(sizeX,sizeY,[1 0; pEmb 1-pEmb]);
    emb=round(rand(sizeX,sizeY));
    
    for j=1:sizeX
        for k=1:sizeY
            if(mask(j,k)==1)
                if(emb(j,k)==1)
                    if(mod(im1(j,k),2)==0)
                        im1(j,k)=im1(j,k)+1;
                    end
                else
                    if(mod(im1(j,k),2)==1)
                        im1(j,k)=im1(j,k)-1;
                    end
                end
            end
        end
    end
    
    [fp fn fe]=fileparts(list{i});
    imwrite(im1,[directorySG fn '.' ext],ext);
    
    
    
end
end

