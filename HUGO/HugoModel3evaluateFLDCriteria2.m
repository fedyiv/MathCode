function [ FLD mCM mSG varCM varSG ] = HugoModel3evaluateFLDCriteria2(dim,T,directoryCM,directorySG,ext)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%k - direction

list=eurModel3getFiles(directoryCM,ext);

Ncm=numel(list);
%Ncm=100;

if(dim==3)
Ccm=zeros(2*T+1,2*T+1,2*T+1,8,Ncm);
elseif(dim==2)
Ccm=zeros(2*T+1,2*T+1,8,Ncm);
end

for i=1:Ncm
    disp(['Image ' list{i} ' is being processed']);
   
    if(dim==3)
        Ccm(:,:,:,:,i)=HugoExtractFeatureMatrices(list{i},dim,T);
    elseif(dim==2)
        Ccm(:,:,:,i)=HugoExtractFeatureMatrices(list{i},dim,T);        
    end
end


list=eurModel3getFiles(directorySG,ext);

Nsg=numel(list);
%Nsg=100;
if(dim==3)
Csg=zeros(2*T+1,2*T+1,2*T+1,8,Nsg);
elseif(dim==2)
    Csg=zeros(2*T+1,2*T+1,8,Nsg);
end

for i=1:Nsg
    disp(['Image ' list{i} ' is being processed']);
    if(dim==3)
        Csg(:,:,:,:,i)=HugoExtractFeatureMatrices(list{i},dim,T);
    elseif(dim==2)
        Csg(:,:,:,i)=HugoExtractFeatureMatrices(list{i},dim,T);
    end
end



%imagesc(Msg(:,:,1)-Mcm(:,:,1));


if(dim==3)
  
    mCM=mean(Ccm,5);    
    
  
    mSG=mean(Csg,5);
    
    
    varCM=var(Ccm,0,5);
    varSG=var(Csg,0,5);


elseif(dim==2)   
    
    
    mCM=mean(Ccm,4);
    mSG=mean(Csg,4);
    varCM=var(Ccm,0,4);
    varSG=var(Csg,0,4);
    
end

FLD=sign(mSG-mCM).*((mCM-mSG).^2)./((varCM+varSG).^2);

if(dim==2)
for i=1:8
    figure(i);
    surf(-T:T,-T:T,FLD(:,:,i));
    title(num2str(i));
end
elseif(dim==3)
    diff2=FLD;
    save('d:\work\FLD_Full.mat','diff2');
end

end

