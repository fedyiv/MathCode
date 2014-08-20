function [ DivXY, DivYX, pE] = Model2EvaluateDivergenceOfImage1a( directoryX,directoryY,ext,blckSize,ns)
% Takes DCT coefficients for estimation

DivYX=0;
pE=0;
listX=eurModel3getFiles(directoryX,ext);
listY=eurModel3getFiles(directoryY,ext);
N=numel(listY);

im=imread(listY{1});
[M,L]=size(im);
M=floor(M/blckSize);
L=floor(L/blckSize);
k=1;

X=zeros(N*M*L,blckSize^2);
Y=zeros(N*M*L,blckSize^2);


t1=clock;
oldt1=t1;
for i=1:N
   t1=clock;
    if(etime(t1,oldt1)>60)
        oldt1=t1;
        disp(['Processing image for i=' num2str(i) ' from ' num2str(N(numel(N)))]);
    end
    
   imX=imread(listX{i});
   imY=imread(listY{i});    
            
    for m=1:M
        for l=1:L           
            
            xblk=imX(1+(m-1)*blckSize:m*blckSize,1+(l-1)*blckSize:l*blckSize);
            yblk=imY(1+(m-1)*blckSize:m*blckSize,1+(l-1)*blckSize:l*blckSize);
            
            
            dxblk=dct2(xblk);
            dyblk=dct2(yblk);
            

            
            X(k,:)=reshape(dxblk,1,[]);
            Y(k,:)=reshape(dyblk,1,[]);
            
            k=k+1;
        
        end
    end   
    
end
pi0=0.5;
pi1=0.5;
k=1;
for i=ns
    disp(['Processing divirgence for n=' num2str(i) ' from ' num2str(max(ns))]);
    DivXY(k)=getDivergence2(X(1:i,:),Y(1:i,:));
    %DivYX(k)=getDivergence(Y(1:i,:),X(1:i,:));
    
    %J=(DivXY(k)+DivYX(k))/2;
    %pE(k)=pi0*pi1*exp(-J);    
%    disp(['n=' num2str(i) ' DivXY= ' num2str(DivXY(k)) ' DivYX= ' num2str(DivYX(k)) ' pE= ' num2str(pE(k))]);
    disp(['n=' num2str(i) ' DivXY= ' num2str(DivXY(k)) ]);
    
    k=k+1;    
end
%subplot(3,1,1);
plot(ns,DivXY);
%subplot(3,1,2);
%plot(ns,DivYX);
%subplot(3,1,3);
%plot(ns,pE);



end

