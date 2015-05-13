function [z,bits] = insertRandBitsModQ62(y,N,h,NPart,NExtZeros,window,blockType,nKv,lKvMin,lKvMax)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

z=y';
for i=1:Num
    z=insertBitMod2Ceps(z,bits(i),(i-1)*N+1,(i)*N,h,NPart,NExtZeros,window,blockType,nKv,lKvMin,lKvMax);
    
    if(mod(i,10)==0)
        disp(['Insert bit ' num2str(i) ' From ' num2str(Num)]);
    end
    
    
end

z=z';


end 