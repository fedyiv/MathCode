function [pErr]=ModelQ72(N,y,Fs,NPart,NExtZeros,window,blockType,b0,b1,FileName,Smoothing)

tic;

wavwrite(y,Fs,16,[FileName 'Intput72.wav']);


[z,bits]=insertRandBitsModQ67(N,y,Fs,b0,b1,Smoothing);


%z=z+0.1*randn(size(z));

if(max(z)>=1)
    z=z./(max(abs(z))+0.01);
end

ztest=round((2.^15).*z)/(2.^15);

wavwrite(z,Fs,16,[FileName 'Attacked.wav']);


[z,Fs]=wavread([FileName 'Attacked.wav']);

[exbits,lambda0,lambda1]=extractBits2PosCepsKey2(N,0,0,0,z,Fs,NPart,NExtZeros,window,blockType,b0,b1);



ErrorVect=exbits-bits;

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