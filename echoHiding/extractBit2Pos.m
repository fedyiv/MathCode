function Bit = extractBit2Pos( Mass,Fs,N1,N2,a,n0,dn0)
% Функция извлекает 1 бит из массиа с отсчетами Mass
% с частотой дискретизации Fs , начиная с позиции N1 до N2
% a - коэффициент ослабления эха  ; n0 - задержка
        
        lambda0=0;
        lambda1=0;

        for i=N1:N2
                       
            lambda0=lambda0+Mass(i)*Mass(i-n0);
            lambda1=lambda1+Mass(i)*Mass(i-n0-dn0);
        end
        
       
       
    %   tempMass=zeros(N2-N1,1);
    %   k=0;
    %   for i=1:N2-N1
    %       k=k+(Mass(N1+i-n0))^2;
    %   end
       
    %   lambda=lambda/k;
       
  %  lambda0
  %  lambda1
        if(lambda1 > lambda0)
            Bit=1;
        else
            Bit=0;
        end


end

