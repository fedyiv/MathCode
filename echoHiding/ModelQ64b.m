function [pErr]=ModelQ64b(N,y,NPart,NExtZeros,window,blockType,h,delta,FileName,Fs)

tic;




wavwrite(y,Fs,16,[FileName 'Intput.wav']);

[z,bits]=insertRandBitsModQ64(y,N,h,NPart,NExtZeros,window,blockType,delta);


z=z+0.001*randn(size(z));


if(max(z)>=1)
    z=z./(max(z)+0.0000000001);
end

wavwrite(z,Fs,16,[FileName 'Output.wav']);


[exbits lambda0 lambda1]=extractBitsModQ64(N,z,NPart,NExtZeros,window,blockType,h,delta);


ErrorVect=exbits-bits;



%plot(1:numel(lambda00),lambda00,1:numel(lambda00),lambda0);

%subplot(2,1,1);
%plot(y);
%subplot(2,1,2);
%bar(ErrorVect);

subplot(3,1,1);
bar(lambda0);
subplot(3,1,2);
bar(lambda1);

subplot(3,1,3);
bar(lambda1-lambda0);

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