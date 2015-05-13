function [z,bits,lambda] = insertRandBitsMod2(N,n0,y,nKv)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

z=y;

lambda=zeros(Num-1,1);
for i=1:Num-1
    [z,lambda(i)]=insertBitMod2(z,bits(i),i*N,(i+1)*N-1,n0,nKv);
    
    
 
end


end 