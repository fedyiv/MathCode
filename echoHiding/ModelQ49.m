function [ D] = ModelQ49(N1gsh,N1,N2,dN,NExperiments,Dispersia,h1,h2)
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

H=zeros(1,Np);

for j=1:Np
    
    ch1=cceps(h1);
    ch2=cceps(h2);
    chd=ch1-ch2;
    
    MOG=zeros(size(ch1));
    
    for i=1:NExperiments

        x=[Dispersia.*randn(1,N1gsh) zeros(1,N1-N1gsh+(j-1)*dN)];
        cx=cceps(x);
    
        MOG=MOG+cx./NExperiments;

    end
    
    DG=zeros(size(ch1));

    for k=1:NExperiments
    
        x=[Dispersia.*randn(1,N1gsh) zeros(1,N1-N1gsh+(j-1)*dN)];
        cx=cceps(x);
    
        DG=DG+((cx-MOG).^2)/NExperiments;
        
    end

    
    %------------------------------------------

    D(j)=sum(((ch1-ch2).^2).*DG);
    H(j)=sum((ch1-ch2).^2);
   
    %--------------------------------------------
    
    h1=[h1 zeros(1,dN)];
    h2=[h2 zeros(1,dN)];
    
    if (mod(j,100)==0)
        disp(['j= ' num2str(j) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
    end
end



alpha=H./sqrt(D);



N=N1:dN:N2;

hh=figure();
plot(N,alpha);
grid on;
title([ 'alpha ,Ngn= ' num2str(N1gsh) 'NExp  = ' num2str(NExperiments) ]);
print(hh,'-dpng',['d:\\work\\NExp' num2str(NExperiments) 'Ngn' num2str(N1gsh)] );


end

