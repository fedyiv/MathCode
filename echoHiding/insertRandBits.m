function [z,bits] = insertRandBits(N,n0,a,y,Fs)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

z=y;
for i=1:Num-1
    z=insertBit(z,Fs,bits(i),i*N,(i+1)*N-1,a,n0);
end


end 