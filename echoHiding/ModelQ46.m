function [ D] = ModelQ46( N1,N2,dN,NExperiments,Dispersia,h1,h2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here




tic;

[m, lh1]=size(h1);
[m, lh2]=size(h2);


Np=floor((N2-N1)/dN)+1;


MO=zeros(1,Np);
D=zeros(1,Np);

h1=[h1 zeros(1,N1-lh1)];
h2=[h2 zeros(1,N1-lh2)];



for j=1:Np
    
    ch1=cceps(h1);
    ch2=cceps(h2);
    chd=ch1-ch2;
    
    for i=1:NExperiments

        x=Dispersia.*randn(1,N1+(j-1)*dN);
        cx=cceps(x);
    
        MO(j)=MO(j)+sum(cx.*chd);

    end
    
    MO(j)=MO(j)./NExperiments;
    
    %------------------------------------------
    
    for i=1:NExperiments

        x=Dispersia.*randn(1,N1+(j-1)*dN);
        cx=cceps(x);
    
        D(j)=D(j)+sum((sum(cx.*chd)- MO(j)).^2 );

    end
    
    D(j)=D(j)./NExperiments;
    
    %--------------------------------------------
    
    h1=[h1 zeros(1,dN)];
    h2=[h2 zeros(1,dN)];
    
    if (mod(j,100)==0)
        disp(['j= ' num2str(j) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
    end
end





N=N1:dN:N2;

hh=figure();
subplot(2,1,1);
plot(N,MO);
subplot(2,1,2);
plot(N,D);

grid on;
title([ 'NExp  = ' num2str(NExperiments) ]);
print(hh,'-dpng',['d:\\work\\NExp' num2str(NExperiments)]);


end

