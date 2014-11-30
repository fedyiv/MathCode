function [pfa pm Fcm Fsg] = DivergenceModel4kNNclassify(directoryCM,directorySG,ext,dim,T,kNNClassifier,Fcm,Fsg)
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
    Nsg=numel(Fsg(:,1))
end



%Ycm=predict(kNNClassifier,Fcm);Not supported in
%matlab 2013
%Ysg=predict(kNNClassifier,Fsg);Not supported in
%matlab 2013

%Ycm=ClassificationKNN.predict(kNNClassifier,Fcm);
Ycm=kNNClassifier.predict(Fcm);
%Ysg=ClassificationKNN.predict(kNNClassifier,Fsg);
Ysg=kNNClassifier.predict(Fsg);



pfa=(nansum(Ycm)+sum(isnan(Ycm)))/numel(Ycm);
pm=(nansum(1-Ysg)+sum(isnan(Ysg)))/numel(Ysg);


end

