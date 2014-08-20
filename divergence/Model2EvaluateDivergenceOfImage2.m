function [ DivXY, DivYX, Pe] = Model2EvaluateDivergenceOfImage2( directoryX,directoryY,ext,dim,T)
% Takes HUGO/SPAM features for estimation


listX=eurModel3getFiles(directoryX,ext);
listY=eurModel3getFiles(directoryY,ext);
N=numel(listX);


for i=1:N
   
    if(~mod(i,50))
        disp(['Processing image for i=' num2str(i) ' from ' num2str(N(numel(N)))]);
    end
    
    FMX=HugoExtractFeatureMatrices(listX{i},dim,T);
    FMY=HugoExtractFeatureMatrices(listY{i},dim,T);
    
    
    
    
    
    X(i,:)=reshape(FMX,1,[]);
    Y(i,:)=reshape(FMY,1,[]);
            

        
       
    
    
end

disp(['Computing divirgence X,Y...Please be patient']);
DivXY=getDivergence(X,Y);
disp(['Computing divirgence Y,X...Please be patient']);
DivYX=getDivergence(Y,X);

J=(DivXY+DivYX)/2;
pi0=0.5;
pi1=0.5;
Pe=pi0*pi1*exp(-J);

end

