function [ FLD mCM mSG varCM varSG ] = HugoModel3evaluateFLDCriteria(dim,T,directoryCM,directorySG,ext,k )
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
   if(~mod(i,40))
    disp(['Image ' list{i} ' is being processed']);
   end
   
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
    if(~mod(i,40))
    disp(['Image ' list{i} ' is being processed']);
    end
    if(dim==3)
        Csg(:,:,:,:,i)=HugoExtractFeatureMatrices(list{i},dim,T);
    elseif(dim==2)
        Csg(:,:,:,i)=HugoExtractFeatureMatrices(list{i},dim,T);
    end
end



%imagesc(Msg(:,:,1)-Mcm(:,:,1));


if(dim==3)
    Ccmk=zeros(2*T+1,2*T+1,2*T+1,Ncm);
    Ccmk(:,:,:,:)=Ccm(:,:,:,k,:);
    mCM=mean(Ccmk,4);
    
    
    Csgk=zeros(2*T+1,2*T+1,2*T+1,Nsg);
    Csgk(:,:,:,:)=Csg(:,:,:,k,:);
    mSG=mean(Csgk,4);
    
    
    varCM=var(Ccmk,0,4);
    varSG=var(Csgk,0,4);


elseif(dim==2)
    Ccmk=zeros(2*T+1,2*T+1,Ncm);
    Ccmk(:,:,:)=Ccm(:,:,k,:);
    
    Csgk=zeros(2*T+1,2*T+1,Nsg);
    Csgk(:,:,:)=Csg(:,:,k,:);
    
    mCM=mean(Ccmk,3);
    mSG=mean(Csgk,3);
    varCM=var(Ccmk,0,3);
    varSG=var(Csgk,0,3);
    
end

%FLD=sign(mSG-mCM).*((mCM-mSG).^2)./(varCM.^2+varSG.^2);
FLD=sign(mSG-mCM).*((mCM-mSG).^2);%./(varCM.^2+varSG.^2);

if(dim==2)

% surf(-T:T,-T:T,FLD);
 surf(-T:T,-T:T,sign(mSG-mCM).*((mCM-mSG).^2));
 xlabel('d1');
 ylabel('d2');
 zlabel('FLD(d1,d2)');
elseif(dim==3)
    diff2=mSG-mCM;
    save('d:\work\diff.mat','diff2');
end

end

