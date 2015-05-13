function [pErr ] = ModelQ57(N,A0,A1,dA,h0,h1,hwost,window,NExp,NExtZeros)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



b0=h0*A0;
b0(1)=1;

b1=h1*A0;
b1(1)=1;


a=1;


tic;

Np=ceil((A1-A0)/dA)+1;

A=A0:dA:A1;

pErr=zeros(1,Np);

for i=1:Np
    
    err=0;
    
    b0=h0*A(i);
    b1=h1*A(i);

    b0(1)=1;
    b1(1)=1;

    for j=1:NExp

        y=[randn(1,N) zeros(1,NExtZeros-N)];
   
        %y=randn(1,N);
        %-----------practise------------------------------------------
        z0=filter(b0,a,y);
        z1=filter(b1,a,y);
    
        if(hwost==0)
            z0=z0(1:N);
            z1=z1(1:N);    
        end
    
        if(hwost==-1)
            z0=z0(floor(N/3):floor(2*N/3));
            z1=z1(floor(N/3):floor(2*N/3));
        end

        lambda0=corrCepstrMulti55(z0,b0,1,NExtZeros,window,2,0.99);
        lambda1=corrCepstrMulti55(z0,b1,1,NExtZeros,window,2,0.99);
        
        if(lambda1 > lambda0)
            err=err+0.5;
        end

        lambda0=corrCepstrMulti55(z1,b0,1,NExtZeros,window,2,0.99);
        lambda1=corrCepstrMulti55(z1,b1,1,NExtZeros,window,2,0.99);
        
        if(lambda1 < lambda0)
            err=err+0.5;
        end


  
    
    
       

    end
    pErr(i)=err/NExp;
    
     if (mod(i,10)==0)
          disp(['i= ' num2str(i) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
     end
    
end



hh=figure();
plot(A,pErr);
grid on;
title([ 'pErr NExp  = ' num2str(NExp) ]);
print(hh,'-dpng',['d:\\work\\M57NExp' num2str(NExp)]);


end

