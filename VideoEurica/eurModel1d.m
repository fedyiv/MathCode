function [outMatrix] = eurModel1d(M1,PTr)
%Generating  2D matrix which is connected with matrix M1
%by transition probability PTr


[sizeV,sizeH]=size(M1);

outMatrix=zeros(sizeV,sizeH);





outMatrix=randsrc(sizeV,sizeH,[-1 1; 1-PTr PTr]);
    
for j=1:sizeV
    for k=1:sizeH
        if(outMatrix(j,k)==1)
            outMatrix(j,k)=M1(j,k);
        else
            outMatrix(j,k)=-M1(j,k);
        end
    end
end



end