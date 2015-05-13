function [ psi ] = ModelQ50(lh0,lh1start,lh1end,dlh1, Nzeros )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

h0=[1 zeros(1,lh0) 0.5];
h1=[1 zeros(1,lh1start) 0.5];

Np=floor((lh1end-lh1start)/(dlh1))+1;

psi=zeros(1,Np);
x=psi;

for i=1:Np
    
    lh1=lh1start+(i-1)*dlh1;
    
    x(i)=lh1;
    
    h1=[1 zeros(1,lh1) 0.5 zeros(1,Nzeros)];
    h0=[1 zeros(1,lh0) 0.5 zeros(1,Nzeros + (lh1-lh0))];
    
    ch1=cceps(h1);
    ch0=cceps(h0);
    
    psi(i)=sum(ch0.*ch1)./sum(ch0.^2);

end


hh=figure();
plot(x,psi);

title(['lh0=' num2str(lh0) ' отсчетов' ]);
print(hh,'-dpng',['d:\\work\\Q50 lh1' num2str(lh1) 'lh1max' num2str(lh1end) 'zeros' num2str(Nzeros)] );

end

