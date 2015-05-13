function [pErr]=ModelQ62(N,y,NPart,NExtZeros,window,blockType,b,nKv,lKvMin,lKvMax)

tic;






[z,bits]=insertRandBitsModQ62(y,N,b,NPart,NExtZeros,window,blockType,nKv,lKvMin,lKvMax);


[exbits]=extractBitsModQ62(N,z,NPart,NExtZeros,window,blockType,b,lKvMin,lKvMax,nKv);


ErrorVect=exbits-bits;



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