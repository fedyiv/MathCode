function bits = extractBits2PosNTimes(N,n0,dn0,a,z,Fs,kol)
%Extrat in y random bits

[Num,tmp]=size(z);

d=floor(Num/kol);

Num=floor(Num/N)/kol;

bits=zeros(Num,1);

tempBits=zeros(Num,kol);

offset=0;


for j=1:kol
    for i=1:Num-1
        tempBits(i,j)=extractBit2Pos(z,Fs,offset+i*N,offset+(i+1)*N-1,a,n0,dn0);
    end
    offset=offset+d;
end

for i=1:Num-1
    for j=1:kol
        bits(i)=bits(i)+tempBits(i,j);
    end
end


for i=1:Num-1
    if( bits(i)>floor(kol/2))
        bits(i)=1;
    else
        bits(i)=0;
    end

end 