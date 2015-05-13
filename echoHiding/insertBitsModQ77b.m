function [z] = insertBitsModQ77b(N,y,bits,h0,h1,Smoothing,mask)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

%bits=round(rand(Num,1));
%bits=ones(Num,1);





%z=zeros(size(y'));
z=y';

for i=1:Num
    if(mask(i)==1)
        z=insertBitModQ77(y',bits(i),(i-1)*N+1,(i)*N,h0,h1,Smoothing);
    end
    
    if(mod(i,10)==0)
        disp(['Insert bit ' num2str(i) ' From ' num2str(Num)]);
    end
    
    
end

z=z';


end 