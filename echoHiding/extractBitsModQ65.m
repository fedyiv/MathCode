function [bits lambda0 lambda1 ] = extractBitsModQ65(N,z,NPart,NExtZeros,window,blockType,h0,h1)
%Extrat in y random bits

nP=floor(N/NPart);
N=nP*NPart;


[Num,tmp]=size(z);
Num=floor(Num/N);

while(Num)
    
    if(mod(Num,NPart)==0)
        break;
    else
        Num=Num-1;
    end
end




bits=zeros(Num,1);
lambda0=zeros(Num,1);
lambda1=zeros(Num,1);

for i=1:(Num/NPart)
    
    [bits((i-1)*NPart+1:i*NPart) lambda0((i-1)*NPart+1:i*NPart) lambda1((i-1)*NPart+1:i*NPart)]=extractBitModelQ65(z',(i-1)*N*NPart+1,(i)*N*NPart,h0,h1,NPart,NExtZeros,window,blockType);
    if(mod(i,10)==0)
        disp(['Extract bit ' num2str(i*NPart) '  From ' num2str(Num) ' Elapsed Time ' num2str(toc)]);
    end
end


end 