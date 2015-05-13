function [ outBits mExtractedBits] = wpcDecoderB(coverS,N,NH,control,H)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


NI=N-NH;

Num=floor(numel(coverS)/N);

lcontrol=numel(control);

mExtractedBits=0;

alpha=ceil(log2(NI));


outBits=zeros(size(coverS));

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
        
       
        
        fullHeader=wpcDecodeInf(coverS(ih1:ih2),alpha+lcontrol,aH);
        
        testControl=fullHeader(1:lcontrol);
                
        if(sum(abs(testControl-control))~=0)
            %TODO
            
            iNH=iNH+floor(iNH/2);
            iNI=N-iNH;
            if(iNH>N)
                break;
            end
                
            continue;
        end
        header=fullHeader(lcontrol+1:numel(fullHeader));    
       
        M=bi2de(header);
        outBits(mExtractedBits+1:mExtractedBits+M)=wpcDecodeInf(coverS(iC1:iC2),M,iH);
        
        mExtractedBits=mExtractedBits+M;
    
                
        break;
    
    end

end

outBits=outBits(1:mExtractedBits);


end

