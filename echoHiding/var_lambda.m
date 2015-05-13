function [lambda,x] = var_lambda( Mass,n0,N,a,Fs,bit )
%
%   ������ ������ ��� ���������� ���-�� �������� N

%x=N1:dN:N1+N;

[m,n]=size(Mass);



Num=floor(m/N)-1;
lambda=zeros(1,Num);


for i=1:Num
    z=insertBit(Mass,Fs,bit,N*i,N*(1+i),a,n0);
    [temp,lambda(i)] = extractBit(z,Fs,i*N,(i+1)*N,a,n0);
end

x=0;

end

