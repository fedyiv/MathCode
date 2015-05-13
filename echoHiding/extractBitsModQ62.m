function [bits ] = extractBitsModQ62(N,z,NPart,NExtZeros,window,blockType,h,lKvMin,lKvMax,nKv)
%Extrat in y random bits

[Num,tmp]=size(z);
Num=floor(Num/N);

bits=zeros(Num,1);

for i=1:Num
    
    [bits(i)]=extractBitMod2Ceps(z',(i-1)*N+1,(i)*N,h,NPart,NExtZeros,window,blockType,nKv,lKvMin,lKvMax);
    if(mod(i,10)==0)
        disp(['Extract bit ' num2str(i) '  From ' num2str(Num) ' Elapsed Time ' num2str(toc)]);
    end
end


end 