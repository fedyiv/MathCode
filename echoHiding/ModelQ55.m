function [pErr ] = ModelQ55(N,a01,a02,da0,h0,h1,hwost,window,NExp,NExtZeros)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



b0=h0;
b1=h1;
a=1;


tic;

Np=ceil((a02-a01)/da0)+1;

a0=a01:da0:a02;

pErr=zeros(1,Np);

for i=1:Np
    
    err=0;

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

        lambda0=corrCepstrMulti55(z0,h0,1,NExtZeros,window,2,a0(i));
        lambda1=corrCepstrMulti55(z0,h1,1,NExtZeros,window,2,a0(i));
        
        if(lambda1 > lambda0)
            err=err+0.5;
        end

        lambda0=corrCepstrMulti55(z1,h0,1,NExtZeros,window,2,a0(i));
        lambda1=corrCepstrMulti55(z1,h1,1,NExtZeros,window,2,a0(i));
        
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
plot(a0,pErr);
grid on;
title([ 'pErr NExp  = ' num2str(NExp) ]);
print(hh,'-dpng',['d:\\work\\M55NExp' num2str(NExp)]);


end

