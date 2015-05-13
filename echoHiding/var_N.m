function [lambda,x] = var_lambda( Mass,n0,N,a,Fs,bit )
%
%   Расчет лямбда для различного кол-ва отсчетов N

%x=N1:dN:N1+N;

[m,n]=size(Mass);



Num=m/N-1;
lambda=zeros(1,Num);


for i=1:Num
    %z=insertBit(Mass,Fs,bit,N1,N1+x(i),a,n0);
    [temp,lambda(i)] = extractBit(z,Fs,i*N,(i+1)*N,a,n0);
end

%x=x-N1;

end

