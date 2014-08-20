function [ outCorrAvg ] = eurModel1e(sizeV,sizeH,m,PTr)
%Count average correlation pairwise between 'm' matrixes size
%'sizeH'x'sizeV' generated with transition probability PTr. The function
%does almost the same work as 'eurModel1c()' + 'eurModel1b' .This function
%uses memory in more optimal way




outCorrAvg=0;


M1=eurModel1a(1,sizeV,sizeH,0);

for i=1:m-1
    
    M2=eurModel1d(M1,PTr);
    outCorrAvg=outCorrAvg+eurModel1b(M1,M2);
end
outCorrAvg=outCorrAvg/m;

end

