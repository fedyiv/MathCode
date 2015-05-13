function Res=insertBitMod4(Mass,bit,N1,N2,n0,dlambda)
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




%--------------------------------------------------------------------------

R2=zeros(floor(Num/2),1);
for jj=1:floor(Num/2)
    R2(jj)=R(jj);
end

[odd,even]=splitMass(R2);

N1k=1+n0;
N2k=floor(Num/4);

lambdaOdd=AutoKorrFNorm(odd,N1k,N2k,n0);
lambdaEven=AutoKorrFNorm(even,N1k,N2k,n0);


flag=0;


delta=lambdaOdd-lambdaEven;

B=0.01;

while(flag==0)
    
    lambdaOdd=AutoKorrFNorm(odd,N1k,N2k,n0);
    lambdaEven=AutoKorrFNorm(even,N1k,N2k,n0);

      if(bit==1)  
        if(lambdaOdd-lambdaEven>dlambda)
            break;
        else
            odd=insertEcho(odd,N1k,N2k,B/2,n0);
            even=insertEcho(even,N1k,N2k,-2*B,n0);
        end
        
      else
          if(lambdaEven-lambdaOdd>dlambda)
            break;
        else
            odd=insertEcho(odd,N1k,N2k,-2*B,n0);
            even=insertEcho(even,N1k,N2k,B/2,n0);
        end
        
          
          
      end
    
    
end
R2=stickMass(odd,even);


for jj=1:floor(Num/2)
    R(jj)=R2(jj);
end


%--------------------------------------------------------------------------









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