function [OutB] = wpcEncodeInf(b,m,mask,H)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


K=sum(mask);
M=numel(m);
N=numel(mask);

vH=H(1:M,:);

vH0=zeros(M,K);

j=1;
for i=1:N
 if(mask(i)==1)
    vH0(:,j)=vH(:,i);
    j=j+1;
 end
 
end


Left=vH0;
Right=mod(m'+vH*b',2);


v0=gflineq(Left,Right);


%inM=[Left Right];
%gaussM=rref(inM);

%gv0=gf(gaussM(:,K+1),2);



v=zeros(1,N);
j=1;
for i=1:N
 if(mask(i)==1)
    v(i)=v0(j);
    j=j+1;
 end
 
end


OutB=mod(v+b,2);

end

