function [z,bits] = insertRandBitsModQ66(y,N,h0,h1,NPart,Smoothing)
%Insert in y random bits


nP=floor(N/NPart);
N=nP*NPart;


[Num,tmp]=size(y);
Num=floor(Num/N);

while(Num)
    
    if(mod(Num,NPart)==0)
        break;
    else
        Num=Num-1;
    end
end


y0=filter(h0,[1],y);
y1=filter(h1,[1],y);

bits=round(rand(Num,1));
%bits=ones(Num,1);
%bits=zeros(Num,1);



%z=y';
z=zeros(size(y'));
y0=y0';
y1=y1';

for i=1:(Num/NPart)
    z=insertBitModelQ66(y',z,(i-1)*N*NPart+1,(i)*N*NPart,bits((i-1)*NPart+1:i*NPart),h0,h1,NPart,y0,y1,Smoothing);
    
    if(mod(i,10)==0)
        disp(['Insert bit ' num2str(i*NPart) ' From ' num2str(Num)]);
    end
    
    
end

z=z';



end 