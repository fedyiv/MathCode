function bits = extractBitsMod4(N,n0,z)
%Extrat in y random bits

[Num,tmp]=size(z);
Num=floor(Num/N);

bits=zeros(Num,1);


for i=1:Num-1
    bits(i)=extractBitMod4(z,i*N,(i+1)*N-1,n0);
end


end 