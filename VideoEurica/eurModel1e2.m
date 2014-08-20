function [ outCorrAvg ] = eurModel1e2(sizeV,sizeH,m,PTr,pEmb)
%Count average correlation pairwise between 'm' matrixes size
%'sizeH'x'sizeV' generated with transition probability PTr. The function
%does almost the same work as 'eurModel1c()' + 'eurModel1b' .This function
%uses memory in more optimal way




outCorrAvg=0;


M1=eurModel1a(1,sizeV,sizeH,0);

for i=1:m-1    
    if (randsrc(1,1,[0 1; pEmb 1-pEmb]))
        M2=eurModel1d(M1,PTr);   
    else
        M2=eurModel1d(M1,0.5);
    end
    
    outCorrAvg=outCorrAvg+eurModel1b(M1,M2);
end
outCorrAvg=outCorrAvg/m;

end

