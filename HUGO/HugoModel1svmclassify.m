function [pfa pm Fcm Fsg] = HugoModel1svmclassify(directoryCM,directorySG,ext,dim,T,SVMstruct,Fcm,Fsg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if(numel(Fcm)==0)
list=eurModel3getFiles(directoryCM,ext);

Ncm=numel(list);
%Ncm=5;

Fcm=zeros(Ncm,2*(2*T+1).^dim);

for i=1:Ncm
    disp(['Image ' list{i} ' is being processed']);
    %im=imread(list{i});    
    %Fcm(i,:)=HugoGetM(HugoGetD(im),dim,T);
    Fcm(i,:)=HugoExtractFeatures(list{i},dim,T);
end

else
    Ncm=numel(Fcm(:,1))
end


if(numel(Fsg)==0)
list=eurModel3getFiles(directorySG,ext);


Nsg=numel(list);
%Nsg=5;

Fsg=zeros(Nsg,2*(2*T+1).^dim);

for i=1:Nsg
   disp(['Image ' list{i} ' is being processed']);
    %im=imread(list{i});    
    %Fsg(i,:)=HugoGetM(HugoGetD(im),dim,T);
    Fsg(i,:)=HugoExtractFeatures(list{i},dim,T);
end
else
    Nsg=numel(Fsg(:,1))
end

%Ncm=4000;
%Nsg=Ncm;
%Fcm=Fcm(1:Ncm); Fsg=Fsg(1:Nsg);
%Fcm=Fcm';Fsg=Fsg';

MAX_SAMPLES_TO_CLASSIFY=2000;% At one time
if(Ncm<MAX_SAMPLES_TO_CLASSIFY) MAX_SAMPLES_TO_CLASSIFY=Ncm; end



for i=1:ceil(Ncm/MAX_SAMPLES_TO_CLASSIFY)

n1=(i-1)*MAX_SAMPLES_TO_CLASSIFY+1;
n2=(i)*MAX_SAMPLES_TO_CLASSIFY;
if(n2>Ncm)
    n2=Ncm;
end
    
Ycm(n1:n2)=svmclassify(SVMstruct,Fcm(n1:n2,:));
Ysg(n1:n2)=svmclassify(SVMstruct,Fsg(n1:n2,:));

end

pfa=(nansum(Ycm)+sum(isnan(Ycm)))/numel(Ycm);
pm=(nansum(1-Ysg)+sum(isnan(Ysg)))/numel(Ysg);


end

