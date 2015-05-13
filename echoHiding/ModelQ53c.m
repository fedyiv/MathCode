function [ P ] = ModelQ53c(N0,N2,dN,h1,h2,window,NExp)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


tic;

Np=floor((N2-N0)/dN)+1;

P=zeros(1,Np);

for i=1:Np
    P(i)=ModelQ53b(N0,h1,h2,1,window,NExp,N0+(i-1)*dN);
    
    if (mod(i,100)==0)
        disp(['i= ' num2str(i) ' From ' num2str(Np) ' Ellapsed Time '  num2str(toc)]);
    end
end


N=N0:dN:N2;

hh=figure();
plot(N,P);
grid on;
title([ 'P NExp  = ' num2str(NExp) ]);
print(hh,'-dpng',['d:\\work\\NExp' num2str(NExp)]);




end

