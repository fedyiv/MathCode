function  D = ModelQ45(h1,h2,N1,N2,dN)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tic;

[m, lh1]=size(h1);
[m, lh2]=size(h2);


Np=floor((N2-N1)/dN)+1;


h1=[h1 zeros(1,N1-lh1)];
h2=[h2 zeros(1,N1-lh2)];

D=zeros(1,Np);

for i=1:Np
    
    ch1=cceps(h1);
    ch2=cceps(h2);
    D(i)=sum((ch1-ch2).^2);
    
    h1=[h1 zeros(1,dN)];
    h2=[h2 zeros(1,dN)];
    
    if (mod(i,100)==0)
     disp(['i= ' num2str(i) ' From ' num2str(Np) ' Ellapsed Time'  num2str(toc)]);
    end
    
end


N=N1:dN:N2;

plot(N,D);



end

