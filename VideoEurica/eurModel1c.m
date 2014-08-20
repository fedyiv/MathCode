function [ outCorrAvg ] = eurModel1c(M)
%Count average correlation between Matrixes M(:,:,i), i=1,2,...,size of 3rd
%dimension of M


[~,~,m]= size(M);


outCorrAvg=0;

for i=1:m-1
    outCorrAvg=outCorrAvg+eurModel1b(M(:,:,i),M(:,:,i+1));
end
outCorrAvg=outCorrAvg/m;

end

