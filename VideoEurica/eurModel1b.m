function [ outCorr ] = eurModel1b(M1,M2)
%Count correlation between Matrixes M1 and M2

[m,n]=size(M1);

weight=m*n;

outCorr= sum(sum(M1.*M2))/weight;



end

