function [Res,h] = insertBit2PosCepsKey(Mass,Fs,bit,N1,N2,a,n0,dn0,b0,b1)
% Функция вставляет  1 бит bit  в массив с отсчетами Mass
% с частотой дискретизации Fs , начиная с позиции N1 до N2
% a - коэффициент ослабления эха  ; n0 - задержка  


Res=Mass;


%if(bit==1)
%    b=[1 zeros(1,n0+dn0-1) a];
%else
%    b=[1 zeros(1,n0-1) a];
%end


%if(bit==1)
%    b=[1 zeros(1,n0-1) a zeros(1,n0+dn0-1) a];
%else
%    b=[1 zeros(1,n0+floor(dn0/2)-1) a zeros(1,n0+floor(3*dn0/2)-1)];
%end

if(bit==1)
    b=b1;
else
    b=b0;
end




h=b;

ak=1;

y=Mass(N1:N2);
z=filter(b,ak,y);

Res(N1:N2)= z(1:N2-N1+1);

end