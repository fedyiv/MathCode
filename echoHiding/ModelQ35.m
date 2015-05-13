function [ Delta2Average ] = ModelQ35( N1,dN,N2,kN,NExperiments )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


NP=floor((N2-N1)/(dN-1));
Delta2Average=zeros(1,NP);


tic;

for k=1:NExperiments

    Delta2=zeros(1,NP);

    for i=1:NP
    
        Ni=N1+(i-1)*dN;
    
        Nv=Ni*kN;
    
        Seq=[randn(1,Ni) zeros(1,Nv-Ni)];
    
        cSeq=cceps(Seq);
    
        for j=1:Nv
            Delta2(i)=Delta2(i)+(cSeq(j)^2)/Nv;
        end
    
    
    

    end
    
    Delta2Average=Delta2Average+Delta2;

    if (mod(k,100)==0)
     disp(['k= ' num2str(k) ' From ' num2str(NExperiments) ' Ellapsed Time'  num2str(toc)]);
    end
end

Delta2Average=Delta2Average./NExperiments;

hh=figure();
plot(Delta2Average);
grid on;
title([ 'NExp  = ' num2str(NExperiments) ' N1 = ' num2str(N1) ' N2 = ' num2str(N2) ' kN = ' num2str(kN)]);
print(hh,'-dpng',['d:\\work\\NExp' num2str(NExperiments) 'N1' num2str(N1) 'N2' num2str(N2) 'kN' num2str(kN)]);


end

