function bit=extractBitAFC(Mass,Fs,N1,N2,w,dw,a)
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

%plot(R);
if (dw==1)
     p=(R(w-1)+R(w+1))/2;
     if(R(w)>0.75*p)
         bit=1;
     else
         bit=0;
     end

else
    s=0;
    for j=w-dw/2:w+dw/2
        s=s+R(j)/dw;
    end

    if(s<a/2)
        bit=0;
    else
        bit=1;
    end
end

end