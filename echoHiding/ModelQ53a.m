function [ PTheor alpha] = ModelQ53a( Ni,Zi,NExperiments,Dispersia,h1,h2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here




tic;

[~, lh1]=size(h1);
[~, lh2]=size(h2);
[~, lN]=size(Ni);

Np=lN;


MO=zeros(1,Np);
D=zeros(1,Np);

th1=[h1 zeros(1,Ni(1)-lh1)];
th2=[h2 zeros(1,Ni(1)-lh2)];

H=zeros(1,Np);


for j=1:Np
    
    
    th1=[h1 zeros(1,Zi(j)-lh1)];
    th2=[h2 zeros(1,Zi(j)-lh2)];
    
   
    
    
    
    ch1=cceps(th1);
    ch2=cceps(th2);
    chd=ch1-ch2;
    
    
   
    
    MOG=zeros(size(ch1));
    
    for i=1:NExperiments

        x=[Dispersia.*randn(1,Ni(j)) zeros(1,Zi(j)-Ni(j))];
        cx=cceps(x);
    
        MOG=MOG+cx./NExperiments;

    end
    
    DG=zeros(size(ch1));

    for k=1:NExperiments
    
        x=[Dispersia.*randn(1,Ni(j)) zeros(1,Zi(j)-Ni(j) )];
        cx=cceps(x);
    
        DG=DG+((cx-MOG).^2)/NExperiments;

        if (mod(k,2000)==0)
            disp(['Dispersia ''k= ' num2str(k) ' From ' num2str(NExperiments) ' Ellapsed Time'  num2str(toc)]);
        end
    end

    
    %------------------------------------------
    
    D(j)=sum(((ch1-ch2).^2).*DG);
    H(j)=sum((ch1-ch2).^2);
    
   
        
    
    %--------------------------------------------
    
   
    
    if (mod(j,100)==0)
        disp(['j= ' num2str(j) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
    end
end



alpha=H./sqrt(D);

PTheor=1-normcdf(alpha,0,1);

%N=N1:dN:N2;

%hh=figure();
%plot(N,alpha);
%grid on;
%title([ 'alpha NExp  = ' num2str(NExperiments) ]);
%print(hh,'-dpng',['d:\\work\\NExp' num2str(NExperiments)]);


end

