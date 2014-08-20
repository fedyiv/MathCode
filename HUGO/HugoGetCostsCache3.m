function [ Costs ] = HugoGetCostsCache3(imFileName,dim,T,sigma,gamma)

[fp fn fe]=fileparts(imFileName);

costsPath=[fp '\Costs\'];
costsFileName=[fn 'd_' num2str(dim) 'T_' num2str(T) 'sigma_' num2str(sigma) 'gamma_' num2str(gamma)];

load('d:\work\FLD_Full.mat')

if(exist([costsPath costsFileName '.costs3'],'file'))
    %load costss from the file
    
    im=imread(imFileName);
    [sizeX sizeY]=size(im);
    
    fid = fopen([costsPath costsFileName '.costs3'], 'r');
    h1=fread(fid,1,'int32');
    Costs2=fread(fid,'double');
    Costs=reshape(Costs2,sizeX,sizeY,2);    
    fclose(fid);
    
    
    h2=int32(mod(sum(Costs2(~isinf(Costs2))),10000));
    
    
    if(h1==h2)
        return;
    end
    
    warning('Costs were changed!!!');

    if(exist(costsPath,'dir')==0)
        %create folder then
        mkdir(costsPath);
    end
    
    im=imread(imFileName); 
    Costs=HugoGetCostsSmart3(im,dim,T,sigma,gamma,diff2);
    Costs2=reshape(Costs,[],1,1);
    h1=int32(mod(sum(Costs2(~isinf(Costs2))),10000));
       
        
    fid = fopen([costsPath costsFileName '.costs3'], 'w');
    fwrite(fid,h1,'int32');
    fwrite(fid,reshape(Costs,[],1,1),'double');
    fclose(fid);
    
else
    
    if(exist(costsPath,'dir')==0)
        %create folder then
        mkdir(costsPath);
    end
    
    im=imread(imFileName); 
    Costs=HugoGetCostsSmart3(im,dim,T,sigma,gamma,diff2);
    Costs2=reshape(Costs,[],1,1);
    h1=int32(mod(sum(Costs2(~isinf(Costs2))),10000));
       
        
    fid = fopen([costsPath costsFileName '.costs3'], 'w');
    fwrite(fid,h1,'int32');
    fwrite(fid,reshape(Costs,[],1,1),'double');
    fclose(fid);
    


end

