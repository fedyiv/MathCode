function [bits lambda0 lambda1 ] = extractBitsModQ84(N,z,NPart,NExtZeros,h0,h1,window,blockType,key)
%Extrat in y random bits


tic;
[Num,tmp]=size(z);
Num=floor(Num/N);

bits=zeros(Num,1);
lambda0=zeros(Num,1);
lambda1=zeros(Num,1);

for i=1:Num
    
    [bits(i) lambda0(i) lambda1(i)]=extractBit2PosCepsKey2Q84(z',(i-1)*N+1,(i)*N,NPart,NExtZeros,window,blockType,h0,h1,key);
    if(mod(i,10)==0)
        disp(['Extract bit ' num2str(i) '  From ' num2str(Num) ' Elapsed Time ' num2str(toc)]);
    end
end


end 