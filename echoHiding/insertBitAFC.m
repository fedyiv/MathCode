function Res=insertBitAFC(Mass,Fs,bit,N1,N2,w,dw,a)
% Функция вставляет  1 бит bit  в массив с отсчетами Mass
% с частотой дискретизации Fs , начиная с позиции N1 до N2
% a - коэффициент ослабления эха  ; n0 - задержка  
Res=Mass;

Num=N2-N1+1;

y=zeros(Num,1);
for j=N1:N2
    y(j-N1+1)=Mass(j);
end




z=fft(y);


R=abs(z);
phi=angle(z);

%subplot(2,1,1);
%bar(R);

if (dw==1)
    p=(R(w-1)+R(w+1))/2;
    if(bit==1)
        R(w)=p+0.5*a*p;
    else
        R(w)=p-a*p;
        
    end
else
    
    if(bit==1)
        for j=w-dw/2:w+dw/2
            R(j)=a;
        end

    else

     for j=w-dw/2:w+dw/2
             R(j)=0;
        end

    end


end
for j=2:floor((Num+1)/2)
    R(Num-j+2)=R(j);
end

%subplot(2,1,2);
%bar(R);


F1=R.*exp(i*phi);
z1=ifft(F1);

y1=real(z1);


for j=1:Num
    Res(N1+j-1)=y1(j);
end


end