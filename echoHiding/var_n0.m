function [lambda,x] = var_n0( Mass,n01,n02,dn0,N,a,Fs,N1,bit )
%
%   Расчет лямбда для различных задержек n0

x=n01:dn0:n02;



Num=(n02-n01)/dn0+1;
lambda=zeros(1,Num);


for i=1:Num
    z=insertBit(Mass,Fs,bit,N1,N1+N,a,x(i));
    [temp,lambda(i)] = extractBit(z,Fs,N1,N1+N,a,x(i));
end


plot(lambda);
end

