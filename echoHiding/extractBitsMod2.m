function bits = extractBitsMod2(N,n0,nKv,z)
%Extrat in y random bits

[Num,tmp]=size(z);
Num=floor(Num/N);

bits=zeros(Num,1);


for i=1:Num-1
    bits(i)=extractBitMod2(z,i*N,(i+1)*N-1,n0,nKv);
end


end 