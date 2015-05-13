function bits = extractBits(N,n0,a,z,Fs)
%Extrat in y random bits

[Num,tmp]=size(z);
Num=floor(Num/N);

bits=zeros(Num,1);


for i=1:Num-1
    [bits(i),tmp]=extractBit(z,Fs,i*N,(i+1)*N-1,a,n0);
end


end 