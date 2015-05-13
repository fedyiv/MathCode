function [lambda,x] = var_a( Mass,n0,N,a1,a2,da,Fs,N1,bit )
%
%   Расчет лямбда для различного значения ослабления эха a

x=a1:da:a2;



Num=(a2-a1)/da+1;
lambda=zeros(1,Num);


for i=1:Num
    z=insertBit(Mass,Fs,bit,N1,N1+N,x(i),n0);
    [temp,lambda(i)] = extractBit(z,Fs,N1,N1+N,x(i),n0);
end


end

