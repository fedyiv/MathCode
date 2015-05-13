function [z,bits] = insertRandBits2PosNTimes(N,n0,dn0,a,y,Fs,kol)
%Insert in y random bits

[Num,tmp]=size(y);
d=floor(Num/kol);

Num=floor(Num/N)/kol;

bits=round(rand(Num,1));



z=y;
offset=0;
for j=1:kol
    for i=1:Num-1
        z=insertBit2Pos(z,Fs,bits(i),offset+i*N,offset+(i+1)*N-1,a,n0,dn0);
    end
    
    offset=offset+d;
end

end 