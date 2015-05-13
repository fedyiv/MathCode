function Res=insertBit(Mass,Fs,bit,N1,N2,a,n0)
% Функция вставляет  1 бит bit  в массив с отсчетами Mass
% с частотой дискретизации Fs , начиная с позиции N1 до N2
% a - коэффициент ослабления эха  ; n0 - задержка  
Res=Mass;
A=a.*ones(N2-N1+1,1);
k=(N2-N1+1)/4;
for i=1:k
    %A(i)=A(i)*sin(0.5*i./k);
    A(i)=A(i)*(cos(pi*i./k+pi)+1)/2;
    A(N2-N1-i+2)=A(i);
end



   for i=N1:N2
       if(bit==1)
           Res(i)=Res(i)+A(i-N1+1)*Res(i-n0);
       end
   end
end