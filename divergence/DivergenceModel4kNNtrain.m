function [ kNNClassifierModel  Fcm Fsg] = DivergenceModel4kNNtrain(directoryCM,directorySG,ext,dim,T,kNN,Fcm,Fsg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if(numel(Fcm)==0)
    list=eurModel3getFiles(directoryCM,ext);
    Ncm=numel(list);
    Fcm=zeros(Ncm,2*(2*T+1).^dim);

    for i=1:Ncm
        disp(['Image ' list{i} ' is being processed']);
        %im=imread(list{i});    
        %Fcm(i,:)=HugoGetM(HugoGetD(im),dim,T);
        Fcm(i,:)=HugoExtractFeatures(list{i},dim,T);
    end

else
    Ncm=numel(Fcm(:,1));
end


if(numel(Fsg)==0)
    list=eurModel3getFiles(directorySG,ext);
    Nsg=numel(list);
    Fsg=zeros(Nsg,2*(2*T+1).^dim);
    for i=1:Nsg
        disp(['Image ' list{i} ' is being processed']);
        Fsg(i,:)=HugoExtractFeatures(list{i},dim,T);
    end
else
    Nsg=numel(Fsg(:,1));
end

F=[Fcm ; Fsg];
Y=[zeros(Ncm,1); ones(Nsg,1)];

%kNNClassifierModel = fitcknn(F,Y,'NumNeighbors',kNN);Not supported in
%matlab 2013
kNNClassifierModel = ClassificationKNN.fit(F,Y,'NumNeighbors',kNN);

end