function [ gamma ] = ModelQ54(N1gsh, N0,N2,dN,h,NExperiments)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



tic;

[~, lh]=size(h);


Np=floor((N2-N0)/dN)+1;


G=zeros(1,Np);

h=[h zeros(1,N0-lh)];


for j=1:Np
    
    ch=cceps(h);
            
    
    
    for i=1:NExperiments

        x=[randn(1,N1gsh) zeros(1,N0-N1gsh+(j-1)*dN)];
        cx=cceps(x);
    
        z=filter(h,[1],x);
        cz=cceps(z);
        
        delta=cz-(cx+ch);
        
        G(j)=G(j)+((sum(delta.^2))/sum(cx.^2))./NExperiments;

    end
    
    %--------------------------------------------
    
    h=[h zeros(1,dN)];
    
    
    if (mod(j,100)==0)
        disp(['j= ' num2str(j) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
    end
end







N=N0:dN:N2;

hh=figure();
plot(N,G);
grid on;
title([ 'G ,Ngn= ' num2str(N1gsh) 'NExp  = ' num2str(NExperiments) ]);
print(hh,'-dpng',['d:\\work\\NExp' num2str(NExperiments) 'Ngn' num2str(N1gsh)] );



end

