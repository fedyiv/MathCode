function bits = extractBitsAFC(N,w,dw,a,y,Fs)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=zeros(Num,1);

z=y;
for i=1:Num-1
    bits(i)=extractBitAFC(z,Fs,i*N,(i+1)*N-1,w,dw,a);
end


end 