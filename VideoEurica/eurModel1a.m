function [outMatrix] = eurModel1a(m,sizeV,sizeH,PTr)
%Generating 'm' 2D matrixes ('sizeV')x('sizeH') which are connected with each
%other by transition probability PTr


outMatrix=zeros(sizeV,sizeH,m);

outMatrix(:,:,1)= randsrc(sizeV,sizeH,[-1 +1; 0.5 0.5]);%Generating first 2D matrix disregarding transition probability


for i=2:m
    outMatrix(:,:,i)=randsrc(sizeV,sizeH,[-1 1; 1-PTr PTr]);
    
    for j=1:sizeV
        for k=1:sizeH
            if(outMatrix(j,k,i)==1)
                outMatrix(j,k,i)=outMatrix(j,k,i-1);
            else
                outMatrix(j,k,i)=-outMatrix(j,k,i-1);
            end
        end
    end
end


end