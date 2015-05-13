function [bits ] = extractBitsModQ63(N,z,NPart,NExtZeros,window,blockType,h0,h1,delta)
%Extrat in y random bits

[Num,tmp]=size(z);
Num=floor(Num/N);

bits=zeros(Num,1);

for i=1:Num
    
    [bits(i)]=extractBitMod2CepsModQ63(z',(i-1)*N+1,(i)*N,h0,h1,NPart,NExtZeros,window,blockType,delta);
    if(mod(i,10)==0)
        disp(['Extract bit ' num2str(i) '  From ' num2str(Num) ' Elapsed Time ' num2str(toc)]);
    end
end


end 