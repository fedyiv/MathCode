function [Bit,lambda0,lambda1] = extractBit2PosCepsKey2Q84( Mass,N1,N2,Npart,NExtZeros,window,blockType,b0,b1,key)
% Функция извлекает 1 бит из массиа с отсчетами Mass
% с частотой дискретизации Fs , начиная с позиции N1 до N2
% a - коэффициент ослабления эха  ; n0 - задержка
        
%        h1=[1 zeros(1,n0+dn0-1) a];
%        h0=[1 zeros(1,n0-1) a];
        
   
   % h1=[1 zeros(1,n0-1) a zeros(1,n0+dn0-1) a];

   %h0=[1 zeros(1,n0+floor(dn0/2)-1) a zeros(1,n0+floor(3*dn0/2)-1)];



    h1=b1;

    h0=b0;


    [x1 x2]=divideBand(Mass(N1:N2),key);
    
    lambda0=corrCepstrMulti2(x1,h0,Npart,NExtZeros,window,blockType);
    lambda1=corrCepstrMulti2(x2,h0,Npart,NExtZeros,window,blockType);
       
       
        
    if(lambda1 > lambda0)
        Bit=1;
    else
        Bit=0;
    end


end

