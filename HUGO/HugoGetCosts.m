function [ Costs ] = HugoGetCosts(I,dim,T,sigma,gamma)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[m n] = size(I);
Costs=zeros(m,n,2);
%1 -1
%2 +1

I1=I;
tic;
for i=1:m
    for j=1:n
        I1(i,j)=I(i,j)-1;
        Costs(i,j,1)=HugoGetDistortion(I,I1,dim,T,sigma,gamma);
        
        I1(i,j)=I(i,j)+1;
        Costs(i,j,2)=HugoGetDistortion(I,I1,dim,T,sigma,gamma);
        
        I1(i,j)=I(i,j);            
       % disp(['Column ' num2str(j) ' from ' num2str(n) ' Ellapsed time ' num2str(toc)]);
    end
   disp(['Line ' num2str(i) ' from ' num2str(m) ' Ellapsed time ' num2str(toc)]);
end


end

