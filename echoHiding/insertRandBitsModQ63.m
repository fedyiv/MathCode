function [z,bits] = insertRandBitsModQ63(y,N,h0,h1,NPart,NExtZeros,window,blockType,delta)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));
bits=ones(Num,1);


z=y';
for i=1:Num
    z=insertBitMod2CepsModQ63(z,bits(i),(i-1)*N+1,(i)*N,h0,h1,NPart,NExtZeros,window,blockType,delta);
    
    if(mod(i,10)==0)
        disp(['Insert bit ' num2str(i) ' From ' num2str(Num)]);
    end
    
    
end

z=z';


end 