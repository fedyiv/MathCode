function [ Costs ] = HugoGetCostsSmart(I,dim,T,sigma,gamma)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[m n] = size(I);
Costs=zeros(m,n,2);
%1 -1
%2 +1

I1=I;


[unused CX CY DX DY]=HugoGetDistortionSmart(I,I1,dim,T,0,0,0,0,0,0,0,sigma,gamma);
oldDY=DY;
oldCY=CY;

oldCX=CX;
oldDX=DX;
tic;


warning('off','MATLAB:concatenation:integerInteraction');


for i=uint16(1:m)
    for j=uint16(1:n)
       
       % tic;
        
       if(I1(i,j)~=0)
           I1(i,j)=I(i,j)-1;
           [Costs(i,j,1) CX CY DX DY]=HugoGetDistortionSmart(I,I1,dim,T,oldCX,oldDX,oldCY,oldDY,i,j,0,sigma,gamma);
       else
           Costs(i,j,1)=inf;
       end
       I1(i,j)=I(i,j);        
       if(I1(i,j)~=255)
           I1(i,j)=I(i,j)+1;
           [Costs(i,j,2) CX CY DX DY]=HugoGetDistortionSmart(I,I1,dim,T,oldCX,oldDX,oldCY,oldDY,i,j,0,sigma,gamma);
       else
            Costs(i,j,2)=inf;
       end
        
        I1(i,j)=I(i,j);            
       
        
       %disp(['Column ' num2str(j) ' from ' num2str(n) ' Ellapsed time ' num2str(toc)]);
    end
    if(~mod(i,128))
     disp(['Line ' num2str(i) ' from ' num2str(m) ' Ellapsed time ' num2str(toc)]);
    end
end
warning('on','MATLAB:concatenation:integerInteraction');

end

