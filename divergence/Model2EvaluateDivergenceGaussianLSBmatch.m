function [ DivXY DivYX pE] = Model2EvaluateDivergenceGaussianLSBmatch(ns)
% Takes HUGO/SPAM features for estimation


listX=eurModel3getFiles(directoryX,ext);
listY=eurModel3getFiles(directoryY,ext);
N=numel(listX);

t1=clock;
oldt1=t1;
X=zeros(N,(2*T+1)^dim);
Y=zeros(N,(2*T+1)^dim);
for i=1:N
   t1=clock;
    if(etime(t1,oldt1)>60)
        oldt1=t1;
        disp(['Processing image for i=' num2str(i) ' from ' num2str(N(numel(N)))]);
    end
    
    FMX=HugoExtractFeatureMatrices(listX{i},dim,T);
    FMY=HugoExtractFeatureMatrices(listY{i},dim,T);
    
    if(dim==2)
        FMX=FMX(:,:,1);
        FMY=FMY(:,:,1);
    elseif(dim==3)
        FMX=FMX(:,:,:,1);
        FMY=FMY(:,:,:,1);
    end
    
    
    
    X(i,:)=reshape(FMX,1,[]);
    Y(i,:)=reshape(FMY,1,[]);
            

        
       
    
    
end
pi0=0.5;
pi1=0.5;
k=1;
for i=ns
    disp(['Processing divirgence for n=' num2str(i) ' from ' num2str(max(ns))]);
    DivXY(k)=getDivergence(X(1:i,:),Y(1:i,:));
  %  DivYX(k)=getDivergence(Y(1:i,:),X(1:i,:));
  DivYX(k)=0
    
    J=(DivXY(k)+DivYX(k))/2;
    pE(k)=pi0*pi1*exp(-J);    
    disp(['n=' num2str(i) ' DivXY= ' num2str(DivXY(k)) ' DivYX= ' num2str(DivYX(k)) ' pE= ' num2str(pE(k))]);
    
    
    k=k+1;    
end
subplot(3,1,1);
plot(ns,DivXY);
subplot(3,1,2);
plot(ns,DivYX);
%subplot(3,1,3);
%plot(ns,pE);

%disp(['Computing divirgence X,Y...Please be patient']);
%DivXY=getDivergence(X,Y);
%disp(['Computing divirgence Y,X...Please be patient']);
%DivYX=getDivergence(Y,X);

%J=(DivXY+DivYX)/2;
%pi0=0.5;
%pi1=0.5;
%Pe=pi0*pi1*exp(-J);

end

