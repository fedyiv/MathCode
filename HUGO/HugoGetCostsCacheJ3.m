function [ Costs ] = HugoGetCostsCacheJ2(imFileName,dim,T,sigma,gamma,weightForm,weightMatrix,sign,probability)

[fp fn fe]=fileparts(imFileName);

costsPath=[fp '\Costs\'];
costsFileName=[fn 'd_' num2str(dim) 'T_' num2str(T) 'sigma_' num2str(sigma) 'gamma_' num2str(gamma) 'wf_' num2str(weightForm) 'sign_' num2str(sign)];


%load('d:\work\FLD_Full.mat')

if(exist([costsPath costsFileName '.costs5'],'file'))
    %load costss from the file
    
    im=imread(imFileName);
    [sizeX sizeY]=size(im);
    
    fid = fopen([costsPath costsFileName '.costs5'], 'r');   
    Costs2=fread(fid,'double');
    Costs=reshape(Costs2,sizeX,sizeY,2);    
    fclose(fid);
    
    
else
    
    if(exist(costsPath,'dir')==0)
        %create folder then
        mkdir(costsPath);
    end
    
    im=imread(imFileName); 
    
     hugo=HUGO(T,gamma,sigma,weightForm,weightMatrix,sign,probability);
     Costs=hugo.getCostsSmart(im,dim);   
  
  
        
    fid = fopen([costsPath costsFileName '.costs5'], 'w');    
    fwrite(fid,reshape(Costs,[],1,1),'double');
    fclose(fid);
    


end

