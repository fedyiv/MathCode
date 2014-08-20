function [ DivXY, DivYX, Pe] = Model2EvaluateDivergenceOfImage1( directoryX,directoryY,ext,blckSize)
% Takes DCT coefficients for estimation

listX=eurModel3getFiles(directoryX,ext);
listY=eurModel3getFiles(directoryY,ext);
N=numel(listX);

k=1;

im=imread(listX{1});
[M,L]=size(im);
M=M/blckSize;
L=L/blckSize;

for i=1:N
   
    if(~mod(i,50))
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

disp(['Computing divirgence X,Y...Please be patient']);
DivXY=getDivergence(X,Y);
disp(['Computing divirgence Y,X...Please be patient']);
DivYX=getDivergence(Y,X);

J=(DivXY+DivYX)/2;
pi0=0.5;
pi1=0.5;
Pe=pi0*pi1*exp(-J);

end

