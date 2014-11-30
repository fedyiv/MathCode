function [P minP] = DivergenceModel4kNNgrid(directoryCMtrain,directorySGtrain,directoryCMtest,directorySGtest,ext,dim,T,kNN)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%This has not been tested and won't work without checking it and fixing.
%The reason is that I realized that I need to use function with caching
%capabilities. SO, see DivergenceModel4kNNgrid2 instead

P=zeros(numel(sigma)*numel(boxconstraint),7);
kP=1;

Fcm_test=[];
Fsg_test=[];

Fcm_train=[];
Fsg_train=[];

for i=kNN    
    tic;

    disp(['Extracting features and training SVM...' ' Ellapsed time: ' num2str(toc)]);
    [screen_output SVMstruct pcv Fcm_train Fsg_train]=evalc('HugoModel1svmtrainAdvancedCV(directoryCMtrain,directorySGtrain,ext,dim,T,i,j,cross_val,Fcm_train,Fsg_train);');
        
    disp(['Testing SVM on training set...' ' Ellapsed time: ' num2str(toc)]);
    [screen_output pfatrain pmtrain Fcm_train Fsg_train]=evalc('HugoModel1svmclassify(directoryCMtrain,directorySGtrain,ext,dim,T,SVMstruct,Fcm_train,Fsg_train);');
       
        
    disp(['Testing SVM on testing set...' ' Ellapsed time: ' num2str(toc)]);
    [screen_output pfa pm Fcm_test Fsg_test]=evalc('HugoModel1svmclassify(directoryCMtest,directorySGtest,ext,dim,T,SVMstruct,Fcm_test,Fsg_test);');
    p=(pfa+pm)/2;
    P(kP,1)=pfa;
    P(kP,2)=pm;
    P(kP,3)=p;
    P(kP,4)=i;
    P(kP,5)=j;       
        
    disp(['pfa=' num2str(pfa) ' pm=' num2str(pm) ' p=' num2str(p) ' sigma=' num2str(i,'%e') ' boxconstraint=' num2str(j) ' pfatrain=' num2str(pfatrain) ' pmtrain=' num2str(pmtrain) ' pcv=' num2str(pcv) 'Elapsed time: ' num2str(toc) ]);
        
    kP=kP+1;
end


    [min_val imin]=min(P(:,8));
    
    minP=P(imin,3);
    disp(['minP=' num2str(minP) ' pfa=' num2str(P(imin,1)) ' pm=' num2str(P(imin,2))  ' sigma=' num2str(P(imin,4),'%e') ' boxconstraint=' num2str(P(imin,5)) ' pfatrain=' num2str(P(imin,6)) ' pmtrain=' num2str(P(imin,7)) ' ptrain=' num2str(P(imin,8)) ' Elapsed time: ' num2str(toc) ]);
    
 
%if(visual>0)
%    hold off;
%    sigmaLin=linspace(min(P(:,4)),max(P(:,4)),numel(P(:,4)));
%    boxconstraintLin=linspace(min(P(:,5)),max(P(:,5)),numel(P(:,5)));
%    [SIGMA,BOXCONSTRAINT]=meshgrid(sigmaLin,boxconstraintLin);
%    Z=griddata(P(:,4),P(:,5),P(:,3),SIGMA,BOXCONSTRAINT,'cubic');
%    mesh(SIGMA,BOXCONSTRAINT,Z);
%    axis tight; hold on;
%    xlabel('sigma');ylabel('boxconstraint');zlabel('Probability of Error');
%    title(['dim=' num2str(dim) ' T=' num2str(T) ' cross_val=' num2str(cross_val)]);
%    plot3(P(:,4),P(:,5),P(:,3),'.','MarkerSize',15);
%    plot3(P(imin,4),P(imin,5),minP,'*','MarkerSize',40);
%end
end

