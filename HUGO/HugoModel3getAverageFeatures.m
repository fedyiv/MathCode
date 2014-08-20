function [ Mcm,Msg ] = HugoModel3getAverageFeatures(dim,T,directoryCM,directorySG,ext )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

list=eurModel3getFiles(directoryCM,ext);

Ncm=numel(list);
%Ncm=5;


Mcm=zeros(2*T+1,2*T+1,2*T+1,8);

for i=1:Ncm
    disp(['Image ' list{i} ' is being processed']);
   
    Mcm=Mcm+HugoExtractFeatureMatrices(list{i},dim,T);
end

Mcm=Mcm/Ncm;

list=eurModel3getFiles(directorySG,ext);

Nsg=numel(list);
%Nsg=5;

Msg=zeros(2*T+1,2*T+1,2*T+1,8);

for i=1:Nsg
    disp(['Image ' list{i} ' is being processed']);
    %im=imread(list{i});    
    %Fsg(i,:)=HugoGetM(HugoGetD(im),dim,T);
    Msg=Msg+HugoExtractFeatureMatrices(list{i},dim,T);
end

Msg=Msg/Nsg;

imagesc(Msg(:,:,1)-Mcm(:,:,1));

end

