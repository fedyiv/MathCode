function [Res,lambda0]=insertBitMod2CepsModQ64(Mass,bit,N1,N2,h,NPart,NExtZeros,window,blockType,delta)


Res=Mass;
Res1=Res;
Res2=Res;

N11=N1;
N12=N1+floor((N2-N1)/2)-1;
N21=N1+floor((N2-N1)/2);
N22=N2-1;
N=floor((N22-N11)/2);


lambda0=corrCepstrMulti2(Mass(N11:N12),h,NPart,NExtZeros,window,blockType);
lambda1=corrCepstrMulti2(Mass(N21:N22),h,NPart,NExtZeros,window,blockType);

if(isnan(lambda0)||isnan(lambda0))
       return;
end


flag=0;


jj=0;

dh=[0 h(2:numel(h))];


while(flag==0)

    lambda0=corrCepstrMulti2(Res(N11:N12),h,NPart,NExtZeros,window,blockType);
    lambda1=corrCepstrMulti2(Res(N21:N22),h,NPart,NExtZeros,window,blockType);    
    
    %----------------------------
    if(jj>100||max(abs(h(2:numel(h))))>0.5)
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
    
    
   % if(bit==1)
   %     Res(N11:N12)=filter([1 -h(2:numel(h))],[1],Mass(N11:N12));
   %     Res(N21:N22)=filter(h,[1],Mass(N21:N22));
   % else
   %     Res(N11:N12)=filter(h,[1],Mass(N11:N12));
   %     Res(N21:N22)=filter([1 -h(2:numel(h))],[1],Mass(N21:N22));
        
   % end
   
   Res1(N11:N22)=filter([1 -h(2:numel(h))],[1],Mass(N11:N22));
   Res2(N11:N22)=filter(h,[1],Mass(N11:N22));

   
   
   r1=[ones(1,N-floor(N/10)+1) (1/(1-0.2*N)).*(1:floor(N/5))+1-(1/(1-0.2*N)) zeros(1,floor(0.9*N))];
   r2=[zeros(1,N-floor(N/10)+1) (1/(0.2*N)).*(1:floor(N/5)) ones(1,floor(0.9*N))];
 
   
   if(bit==0)
       Res(N11:N22)=Res2(N11:N22).*r1+Res1(N11:N22).*r2;
   else
       Res(N11:N22)=Res1(N11:N22).*r1+Res2(N11:N22).*r2;
       
   end
   
    
    
    
    h=h+dh;
    
end

end