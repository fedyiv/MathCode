function [ outBits mExtractedBits] = wpcDecoder(coverS,N,NH,H)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


NI=N-NH;

Num=floor(numel(coverS)/N);


mExtractedBits=0;

alpha=ceil(log2(NI));


aH=H(1:NH,1:NH);


outBits=zeros(size(coverS));

for i=1:Num
    
    
    
    
    
    header=wpcDecodeInf(coverS((i-1)*N+1:(i-1)*N+NH),alpha,aH);
    
    M=bi2de(header);
    
    
    outBits(mExtractedBits+1:mExtractedBits+M)=wpcDecodeInf(coverS((i-1)*N+NH+1:i*N),M,H);
    
    mExtractedBits=mExtractedBits+M;

end

outBits=outBits(1:mExtractedBits);



end

