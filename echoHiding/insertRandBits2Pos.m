function [z,bits] = insertRandBits2Pos(N,n0,dn0,a,y,Fs)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

z=y;
for i=1:Num-1
    z=insertBit2Pos(z,Fs,bits(i),i*N,(i+1)*N-1,a,n0,dn0);
end


end 