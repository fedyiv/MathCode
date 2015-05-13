function [z,bits] = insertRandBitsMod3(N,n0,y,dlambda)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

z=y;

for i=1:Num-1
        i
    z=insertBitMod3(z,bits(i),i*N,(i+1)*N-1,n0,dlambda);   
 
end


end 