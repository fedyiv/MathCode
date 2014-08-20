function [ SVMstruct cross_validation_pe] = HugoModel1svmtrain(directoryCM,directorySG,ext,dim,T,sigma,boxconstraint,cross_validation)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


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



%Ncm=4000;
%Nsg=Ncm;
%Fcm=Fcm(1:Ncm); Fsg=Fsg(1:Nsg);
%Fcm=Fcm';Fsg=Fsg';

if(cross_validation>0)
    Ntrain=uint16(Ncm*(1-cross_validation));
    Nvalidate=Ncm-Ntrain;
    
    F=[Fcm(1:Ntrain,:) ; Fsg(1:Ntrain,:)];
    Y=[zeros(Ntrain,1); ones(Ntrain,1)];
    
    try
    options=statset('MaxIter',80000);
    SVMstruct=svmtrain(F,Y,'kernel_function','rbf','rbf_sigma',sigma,'boxconstraint',boxconstraint,'method','SMO','kernelcachelimit',5000,'kktviolationlevel',0.05,'options',options);
    
    
    %cross validation
    
    Fcmv=Fcm(Ntrain+1:Ncm,:);
    Fsgv=Fsg(Ntrain+1:Nsg,:);
    
    Ycm=svmclassify(SVMstruct,Fcmv);
    Ysg=svmclassify(SVMstruct,Fsgv);
    
    pfa=(nansum(Ycm)+sum(isnan(Ycm)))/numel(Ycm);
    pm=(nansum(1-Ysg)+sum(isnan(Ysg)))/numel(Ysg);
    
    cross_validation_pe=(pfa+pm)/2;    
    
    catch ME
        report=ME.getReport();
        disp(report);
        if(strcmp(report,'No convergence achieved within maximum number of iterations.'))
            pfa=inf;
            pm=inf;
            cross_validation_pe=inf;
        else
        error(report)    ;
        end
            
    
    end

else
    
 try
    
F=[Fcm ; Fsg];
Y=[zeros(Ncm,1); ones(Nsg,1)];
cross_validation_pe=nan;

options=statset('MaxIter',30000);
SVMstruct=svmtrain(F,Y,'kernel_function','rbf','rbf_sigma',sigma,'boxconstraint',boxconstraint,'method','SMO','kernelcachelimit',5000,'kktviolationlevel',0.01,'options',options);
 catch ME
        report=ME.getReport();
        disp(report);
        if(strcmp(report,'No convergence achieved within maximum number of iterations.'))
            pfa=inf;
            pm=inf;
            cross_validation_pe=inf;
        else
            disp(report);
        error(report)    ;
        end
 end
end

