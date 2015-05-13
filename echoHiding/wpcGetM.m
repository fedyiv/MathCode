function [M] = wpcGetM(N,H,mask)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


K=sum(mask);


vH=zeros(N,K);
j=1;
for i=1:N
 if(mask(i)==1)
    vH(:,j)=H(:,i);
    j=j+1;
 end
 
end


M1=K;

while(M1>1)
    
vH0=vH(1:M1,:);

R=gfrank(vH0);

if(R==M1)
    break;
end


M1=M1-1;
end


M=M1;

end

