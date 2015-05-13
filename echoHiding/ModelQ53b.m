function [pErr ] = ModelQ53b(N,h0,h1,hwost,window,NExp,NExtZeros)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



b0=h0;
b1=h1;
a=1;

err=0;

tic;

for j=1:NExp

    %y=[randn(1,N) zeros(1,NExtZeros-N)];
   
    y=randn(1,N);
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

    lambda0=corrCepstrMulti2(z0,h0,1,NExtZeros,window,2);
    lambda1=corrCepstrMulti2(z0,h1,1,NExtZeros,window,2);
        
    if(lambda1 > lambda0)
        err=err+0.5;
    end

    lambda0=corrCepstrMulti2(z1,h0,1,NExtZeros,window,2);
    lambda1=corrCepstrMulti2(z1,h1,1,NExtZeros,window,2);
        
    if(lambda1 < lambda0)
        err=err+0.5;
    end


  
    
    
    if (mod(j,500)==0)
     disp(['j= ' num2str(j) ' From ' num2str(NExp) ' Ellapsed Time'  num2str(toc)]);
    end

end

pErr=err/NExp;
end

