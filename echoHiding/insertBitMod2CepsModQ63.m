function [Res,lambda0]=insertBitMod2CepsModQ63(Mass,bit,N1,N2,h0,h1,NPart,NExtZeros,window,blockType,delta)


Res=Mass;




lambda0=corrCepstrMulti2(Mass(N1:N2-1),h0,NPart,NExtZeros,window,blockType);
lambda1=corrCepstrMulti2(Mass(N1:N2-1),h1,NPart,NExtZeros,window,blockType);

if(isnan(lambda0)||isnan(lambda0))
       return;
end


flag=0;


jj=0;

dh0=[0 h0(2:numel(h0))];
dh1=[0 h1(2:numel(h1))];

while(flag==0)

    lambda0=corrCepstrMulti2(Res(N1:N2-1),h0,NPart,NExtZeros,window,blockType);
    lambda1=corrCepstrMulti2(Res(N1:N2-1),h1,NPart,NExtZeros,window,blockType);
    
    %----------------------------
    if(jj>100||max(abs(h0(2:numel(h0))))>0.5 ||max(abs(h1(2:numel(h1))))>0.5)
        return;
    end
    jj=jj+1;
    %------------------------------
    
    if(lambda1-lambda0 > delta)
         if(bit==1)
             return;
         end 
    end

    if(lambda0-lambda1 > delta)
        if(bit==0)
            return;
        end 
    end
    
    
    if(bit==1)
        Res(N1:N2-1)=filter(h1,[1],Mass(N1:N2-1));
        Res(N1:N2-1)=filter([1 -h0(2:numel(h0))],[1],Res(N1:N2-1));
    else
        Res(N1:N2-1)=filter(h0,[1],Mass(N1:N2-1));
        Res(N1:N2-1)=filter([1 -h1(2:numel(h0))],[1],Res(N1:N2-1));
        
    end

    h1=h1+dh1;
    h0=h0+dh0;
  
    

end

end