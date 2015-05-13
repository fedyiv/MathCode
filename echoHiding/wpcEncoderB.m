function [ outCover mEmbeddedBits] = wpcEncoderB( bits,cover,mask,N,NH,control,H)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


NI=N-NH;

Num=floor(numel(cover)/N);

lcontrol=numel(control);

mEmbeddedBits=0;

alpha=ceil(log2(NI));





outCover=zeros(size(cover));
for i=1:Num
    
    iNI=NI;
    iNH=NH;
    
    while(1)
        
        ih1=(i-1)*N+1;
        ih2=(i-1)*N+iNH;
        iC1=(i-1)*N+iNH+1;
        iC2=i*N;
    
        iH=H(1:iNI,1:iNI);
        aH=H(1:iNH,1:iNH);
        
       
        alphaM=wpcGetM(iNH,aH,mask(ih1:ih2));
        
        if(alphaM<alpha+lcontrol)
            %TODO
            
            iNH=iNH+floor(iNH/2);
            iNI=N-iNH;
            if(iNH>N)
                break;
            end
                
            continue;
        end
            
       
        M=wpcGetM(iNI,iH,mask(iC1:iC2));
        outCover(iC1:iC2)=wpcEncodeInf(cover(iC1:iC2),bits(mEmbeddedBits+1:mEmbeddedBits+M),mask(iC1:iC2),iH);
    
    
        header=de2bi(M,alpha);
        fullHeader=[ control header];
        
        outCover(ih1:ih2)=wpcEncodeInf(cover(ih1:ih2),fullHeader,mask(ih1:ih2),aH);
        mEmbeddedBits=mEmbeddedBits+M;
        
        break;
    
    end

end




end

