function [Bit1,Bit2] = extractBit4Pos( Mass,Fs,N1,N2,a,n0,dn0)
% Функция извлекает 1 бит из массиа с отсчетами Mass
% с частотой дискретизации Fs , начиная с позиции N1 до N2
% a - коэффициент ослабления эха  ; n0 - задержка
        
        lambda=zeros(4,1);
        
        for i=N1:N2
                       
            lambda(1)=lambda(1)+Mass(i)*Mass(i-n0);
            lambda(2)=lambda(2)+1.2*Mass(i)*Mass(i-n0-dn0);
            lambda(3)=lambda(3)+1.4*Mass(i)*Mass(i-n0-2*dn0);
            lambda(4)=lambda(4)+1.6*Mass(i)*Mass(i-n0-3*dn0);
        end
        
        if(lambda(1)< max(lambda))
           if(lambda(2)<max(lambda))
               if(lambda(3)<max(lambda))
                   Bit1=1;
                   Bit2=1;
               else
                   Bit1=1;
                   Bit2=0;
               end                   
           else
               Bit1=0;
               Bit2=1;
           end
        else
            Bit1=0;
            Bit2=0;
        end
   

end

