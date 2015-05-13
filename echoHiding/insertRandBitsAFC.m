function [z,bits] = insertRandBitsAFC(N,w,dw,a,y,Fs)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

z=y;
for i=1:Num-1
   %w=floor(rand(1,1)*(N-1)/2+2); %эмуляция ппрч
    z=insertBitAFC(z,Fs,bits(i),i*N,(i+1)*N-1,w,dw,a);
end


end 