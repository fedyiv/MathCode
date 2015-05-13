function [pErr]=ModelQ84(N,y,Fs,NPart,NExtZeros,window,blockType,b0,b1,FileName,Smoothing,key)

tic;

wavwrite(y,Fs,16,[FileName 'Intput84.wav']);

%[exbits,lambda0,lambda1]=extractBitsModQ84(N,y,NPart,NExtZeros,b0,b1,window,blockType,key);

[z,bits]=insertRandBitsModQ84(N,y,Fs,b0,b1,Smoothing,key);

if(max(z)>=1)
    z=z./(max(z)+0.0000000001);
end


%z=filter([ 1 zeros(1,40) 0.9],[1],z);

%z=z+0.005*randn(size(z));
%z=[zeros(450,1) ; z(1:numel(z)-450)];

%z=resample(z,1,4);
%z=resample(z,4,1);

wavwrite(z,Fs,16,[FileName 'Output84.wav']);

[exbits,lambda0,lambda1]=extractBitsModQ84(N,z,NPart,NExtZeros,b0,b1,window,blockType,key);

%[~,lambda00,lambda10]=extractBits2PosCepsKey2(N,n0,dn0,a,y,Fs,NPart,NExtZeros,window,blockType,b0,b1);

ErrorVect=exbits-bits;

%CorruptedSig=zeros(1,N*sum(ErrorVect.^2));
%CorrectSig=zeros(1,N*(numel(bits)-numel(CorruptedSig)/N));

%l00=zeros(1,sum(ErrorVect.^2));
%l01=l00;
%l10=l00;
%l11=l00;
%corruptedBits=l00;

%iCorrect=0;
%iCorrupted=0;
%for i=1:numel(ErrorVect)

 %   if(ErrorVect(i)~=0)
    
  %      CorruptedSig(iCorrupted*N+1:(iCorrupted+1)*N)=y((i-1)*N+1:i*N);
        
   %     l00(iCorrupted+1)=lambda00(i);
   %     l01(iCorrupted+1)=lambda10(i);
   %     l10(iCorrupted+1)=lambda0(i);
   %     l11(iCorrupted+1)=lambda1(i);
   %     corruptedBits(iCorrupted+1)=bits(i);
        
    %    iCorrupted=iCorrupted+1;
        
        
%    else
 %       CorrectSig(iCorrect*N+1:(iCorrect+1)*N)=y((i-1)*N+1:i*N);
  %      iCorrect=iCorrect+1;
        
  %  end
    
%end

%plot(1:numel(lambda00),lambda00,1:numel(lambda00),lambda0);

%subplot(2,1,1);
%plot(y);
%subplot(2,1,2);
%bar(ErrorVect);

MinusK=0;
PlusK=0;

[m,tmp]=size(ErrorVect);

for i=1:m
    if(ErrorVect(i)<0)
        MinusK=MinusK+1;
    else
        if(ErrorVect(i)>0)
            PlusK=PlusK+1;
        end
    end
end


pErr=(abs(MinusK)+abs(PlusK))./m;

if(MinusK>PlusK)
    pErr=-pErr;

end
PlusK
MinusK
pErr
  
%Title= ['bit' 'R0' 'R1' 'R0`' 'R1`'];
%Table=[corruptedBits' l00' l01' l10' l11']


%fid = fopen(['d:\\work\\M56' num2str(N) '.txt'], 'wt');
%fprintf(fid, 'bit \t R0 \t R1 \t R0` \t R1` \n');
%fprintf(fid, '%8i \t %8.5f \t %8.5f \t %8.5f \t %8.5f\n', Table');
%fclose(fid);    
    
    
    
    
toc

end