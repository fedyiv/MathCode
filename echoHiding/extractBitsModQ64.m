function [bits lambda0 lambda1 ] = extractBitsModQ64(N,z,NPart,NExtZeros,window,blockType,h,delta)
%Extrat in y random bits

[Num,tmp]=size(z);
Num=floor(Num/N);

bits=zeros(Num,1);
lambda0=zeros(Num,1);
lambda1=zeros(Num,1);

for i=1:Num
    
    [bits(i) lambda0(i) lambda1(i)]=extractBitMod2CepsModQ64(z',(i-1)*N+1,(i)*N,h,NPart,NExtZeros,window,blockType,delta);
    if(mod(i,10)==0)
        disp(['Extract bit ' num2str(i) '  From ' num2str(Num) ' Elapsed Time ' num2str(toc)]);
    end
end


end 