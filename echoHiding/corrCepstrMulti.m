function  R  = corrCepstrMulti(y,h,Npart,NExtZeros)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[m,n]=size(y);

Np=floor(n/Npart);

Scep=zeros(1,NExtZeros);


t=1:NExtZeros;
w=0.96.^t;

%t=1:Np;
%w=0.96.^t;
%wh=(hann(Np))';
%w=w.*wh*8000;
%W=zeros(1,Np);
%if(mod(Np,2)==1)

%    W((Np-1)/2+1:Np)=w(1:(Np-1)/2+1);
%    W(1:floor(Np/2))=fliplr(w(1:floor(Np/2)));
%else
  
%    W(Np/2+1:Np)=w(1:Np/2);
%    W(1:Np/2)=fliplr(w(1:floor(Np/2)));
   
%end
%w=[W zeros(1,NExtZeros-Np)];

w=(hamming(Np))';

%w=(hann(Np))';


for i=1:Npart
    [R,cTemp,ch]=corrCepstr([y((i-1)*Np+1:i*Np)],NExtZeros,h,w);
    Scep=Scep+cTemp;
end

%plot(Scep);

R = corr(Scep',ch');

end

