function [ outCover mEmbeddedBits] = wpcEncoder( bits,cover,mask,N,NH,H)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


NI=N-NH;

Num=floor(numel(bits)/N);


mEmbeddedBits=0;

alpha=ceil(log2(NI));


aH=H(1:NH,1:NH);


outCover=zeros(size(cover));
for i=1:Num
    
    M=wpcGetM(NI,H,mask((i-1)*N+NH+1:i*N));
    outCover((i-1)*N+NH+1:i*N)=wpcEncodeInf(cover((i-1)*N+NH+1:i*N),bits(mEmbeddedBits+1:mEmbeddedBits+M),mask((i-1)*N+NH+1:i*N),H);
    
     
    
    header=de2bi(M,alpha);
    
    alphaM=wpcGetM(NH,aH,mask((i-1)*N+1:(i-1)*N+NH));
    if(alphaM>=alpha)
        outCover((i-1)*N+1:(i-1)*N+NH)=wpcEncodeInf(cover((i-1)*N+1:(i-1)*N+NH),header,mask((i-1)*N+1:(i-1)*N+NH),aH);
        mEmbeddedBits=mEmbeddedBits+M;
    else
        header=zeros(1,alphaM);
        outCover((i-1)*N+1:(i-1)*N+NH)=wpcEncodeInf(cover((i-1)*N+1:(i-1)*N+NH),header,mask((i-1)*N+1:(i-1)*N+NH),aH);
    end
    

end




end

