function [Bit,lambda] = extractBit( Mass,Fs,N1,N2,a,n0)
% Функция извлекает 1 бит из массиа с отсчетами Mass
% с частотой дискретизации Fs , начиная с позиции N1 до N2
% a - коэффициент ослабления эха  ; n0 - задержка
        lambda0=1;
       %lambda0=7000;
        
        lambda=0;
        for i=N1:N2
                       
            lambda=lambda+Mass(i)*Mass(i-n0);
        end
        
       
       
       tempMass=zeros(N2-N1,1);
       k=0;
       for i=1:N2-N1
           k=k+(Mass(N1+i-n0))^2;
       end
       
       lambda=lambda/k;
        
        if(lambda > lambda0)
            Bit=1;
        else
            Bit=0;
        end


end

