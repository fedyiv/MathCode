function [ SVMstruct cross_validation_pe Fcm Fsg] = HugoModel1svmtrainAdvancedCVCache(directoryCM,directorySG,ext,dim,T,sigma,boxconstraint,cross_validation,Fcm,Fsg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
svmCacheDir=[directorySG 'svmCache\'];
svmFileName=['dim_' num2str(dim) '_T_' num2str(T) '_sigma_' num2str(sigma) '_boxconstraint_' num2str(boxconstraint) '_cross_validation_' num2str(cross_validation)];

if(exist([svmCacheDir svmFileName '.psvm'],'file'))
    %load output values from the file    
    load([svmCacheDir svmFileName '.psvm'],'-mat','SVMstruct','cross_validation_pe','Fcm','Fsg');
    return;
end    

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
    Ncm=numel(Fcm(:,1));
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

if(cross_validation>0)
   % Ntrain=uint16(Ncm*(1-cross_validation));
   % Nvalidate=Ncm-Ntrain;
    
   
    n_val=0;
    cross_validation_pe=0;
    while(n_val<cross_validation)
        try
            %Be carefull, this will work only if Ncm==Nsg
            Ntr=floor(0.95*Ncm);
            Ntt=Ncm-Ntr;
            
            [indTrain indTest]=HugoModel1UniqueRandomVectorGenerator(Ncm,Ntr);
            
            F=[Fcm(indTrain,:) ; Fsg(indTrain,:)];
           
            Y=[zeros(Ntr,1); ones(Ntr,1)];
            
            options=statset('MaxIter',80000);
            SVMstruct=svmtrain(F,Y,'kernel_function','rbf','rbf_sigma',sigma,'boxconstraint',boxconstraint,'method','SMO','kernelcachelimit',5000,'kktviolationlevel',0.05,'options',options);
            
            Fcmv=Fcm(indTest,:);
            Fsgv=Fsg(indTest,:);
           
            %In future use HUgoModel1svmclqassify here, in case of OOM 
            Ycm=svmclassify(SVMstruct,Fcmv);
            Ysg=svmclassify(SVMstruct,Fsgv);
            pfa=(nansum(Ycm)+sum(isnan(Ycm)))/numel(Ycm);
            pm=(nansum(1-Ysg)+sum(isnan(Ysg)))/numel(Ysg);
            cross_validation_pe=cross_validation_pe+(pfa+pm)/2;    
        catch ME
            report=ME.getReport();
            disp(report);
                       
            if(strcmp(report,'No convergence achieved within maximum number of iterations.'))
                %will throw error so far - just to see if this happens
              %  error(report); 
              % well this happens, changed to warning  
              warn(report); 
              
                pfa=inf;
                pm=inf;
                cross_validation_pe=inf;
            else
                warning(report);
                %error(report);
            end
        end
        
        n_val=n_val+1;
    end
    
    cross_validation_pe=cross_validation_pe/n_val;
    
    
      try
            %Be carefull, this will work only if Ncm==Nsg
            
            F=[Fcm; Fsg];
           
            Y=[zeros(Ncm,1); ones(Nsg,1)];
            
            options=statset('MaxIter',30000);
            SVMstruct=svmtrain(F,Y,'kernel_function','rbf','rbf_sigma',sigma,'boxconstraint',boxconstraint,'method','SMO','kernelcachelimit',5000,'kktviolationlevel',0.01,'options',options);            
           
        catch ME
            report=ME.getReport();
            disp(report);
                       
            if(strcmp(report,'No convergence achieved within maximum number of iterations.'))
                %will throw error so far - just to see if this happens
                %error(report); 
                warning(report);
                pfa=inf;
                pm=inf;
                cross_validation_pe=inf;
            else
                %error(report);
                warning(report);
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
        error(report)    ;
        end
 end
end

if(exist(svmCacheDir,'dir')==0)
        %create folder then
        mkdir(svmCacheDir);
end

save([svmCacheDir svmFileName '.psvm'],'SVMstruct','cross_validation_pe','Fcm','Fsg','-mat');

end