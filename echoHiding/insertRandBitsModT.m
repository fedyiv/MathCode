function [Res,bits] = insertRandBitsModT(y,N,a,Fs)

[m,n]=size(y);

Num=floor(m/N)-1; 

bits=round(rand(Num,1));

%bits=ones(Num,1);

%bits=zeros(Num,1);

Res=y;

for i=1:Num
    
    p=(Res(i*N-1)+Res(i*N+1))/2;
    if(bits(i)==1)
        Res(i*N)=p+a*p;
    else
        Res(i*N)=p-a*p;
    end
    
    
end



end