function [z,bits] = insertRandBitsModQ65(y,N,h0,h1,NPart)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

while(Num)
    
    if(mod(Num,NPart)==0)
        break;
    else
        Num=Num-1;
    end
end


bits=round(rand(Num,1));
bits=ones(Num,1);


z=y';
for i=1:(Num/NPart)
    z=insertBitModelQ65(z,(i-1)*N*NPart+1,(i)*N*NPart,bits((i-1)*NPart+1:i*NPart),h0,h1,NPart);
    
    if(mod(i,10)==0)
        disp(['Insert bit ' num2str(i*NPart) ' From ' num2str(Num)]);
    end
    
    
end

z=z';


end 