function [ distortion CX CY DX DY] = HugoGetDistortionSmart2(X,Y,dim,T,oldCX,oldDX,oldCY,oldDY,iChanged,jChanged,oldDistortion,sigma,gamma,diff2)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%disp(['Entering getDistortion ' num2str(toc)]);

distortion=0;
%sigma=10;
%gamma=4;
center=int16(((numel(diff2)^(1/3)-1)/2)-T);


if(iChanged==0 && jChanged==0)
    DX=HugoGetD(X);
    CX=HugoGetC(DX,dim,T);
    
    DY=HugoGetD(Y);
    CY=HugoGetC(DY,dim,T);    
    
    
   
    for i=-T:T    
        for j=-T:T
            for z=-T:T
                wc=w(i,j,z,gamma,sigma);
                p11=CX(i+T+1,j+T+1,z+T+1,1)+CX(i+T+1,j+T+1,z+T+1,2)+CX(i+T+1,j+T+1,z+T+1,3)+CX(i+T+1,j+T+1,z+T+1,4);
                p12=CY(i+T+1,j+T+1,z+T+1,1)+CY(i+T+1,j+T+1,z+T+1,2)+CY(i+T+1,j+T+1,z+T+1,3)+CY(i+T+1,j+T+1,z+T+1,4);
                
                p21=CX(i+T+1,j+T+1,z+T+1,5)+CX(i+T+1,j+T+1,z+T+1,6)+CX(i+T+1,j+T+1,z+T+1,7)+CX(i+T+1,j+T+1,z+T+1,8);
                p22=CY(i+T+1,j+T+1,z+T+1,5)+CY(i+T+1,j+T+1,z+T+1,6)+CY(i+T+1,j+T+1,z+T+1,7)+CY(i+T+1,j+T+1,z+T+1,8);
                
                distortion=distortion+sign(diff2(i+T+1+center,j+T+1+center,z+T+1+center))*wc*(p12-p11)+sign(diff2(i+T+1+center,j+T+1+center,z+T+1+center))*wc*(p22-p21);
            end
        end
    end
    
    
    
else
    %tic;
    
   %Very smart :) will work only in case X is the same every time.
   %reasonable in that case
   % DX=HugoGetD(X);
   % CX=HugoSmartRecalculateC(oldDX,DX,oldCX,iChanged,jChanged,dim,T);
   DX=oldDX;
   CX=oldCX;
    
 
    
    diffDY=HugoVerySmartRecalculateD(Y,oldDY,iChanged,jChanged);
    DY=0;
    

  
    

    CY=HugoVerySmartRecalculateC(oldDY,diffDY,oldCY,iChanged,jChanged,dim,T);
    
   
  
   changedElements=find(CY-CX);
   distortion=oldDistortion;
   %This function is too smart, please use carefully
 
   [d1,d2,d3,unused]=ind2sub(size(CY),changedElements) ;
   changedElements2=unique(sub2ind([2*T+1 2*T+1 2*T+1],d1,d2,d3));
   
   [ia,ja,za]= ind2sub(size(CY),changedElements2) ;
   
   for index=1:numel(changedElements2)
 
   i=ia(index);j=ja(index);z=za(index);
       
   
   i=i-T-1;
   j=j-T-1;
   z=z-T-1;
   
   wc=w(i,j,z,gamma,sigma);  
  
   
   p11=CX(i+T+1,j+T+1,z+T+1,1)+CX(i+T+1,j+T+1,z+T+1,2)+CX(i+T+1,j+T+1,z+T+1,3)+CX(i+T+1,j+T+1,z+T+1,4);
   p12=CY(i+T+1,j+T+1,z+T+1,1)+CY(i+T+1,j+T+1,z+T+1,2)+CY(i+T+1,j+T+1,z+T+1,3)+CY(i+T+1,j+T+1,z+T+1,4);
   p21=CX(i+T+1,j+T+1,z+T+1,5)+CX(i+T+1,j+T+1,z+T+1,6)+CX(i+T+1,j+T+1,z+T+1,7)+CX(i+T+1,j+T+1,z+T+1,8);
   p22=CY(i+T+1,j+T+1,z+T+1,5)+CY(i+T+1,j+T+1,z+T+1,6)+CY(i+T+1,j+T+1,z+T+1,7)+CY(i+T+1,j+T+1,z+T+1,8);
   distortion=distortion+sign(diff2(i+T+1+center,j+T+1+center,z+T+1+center))*wc*(p12-p11)+sign(diff2(i+T+1+center,j+T+1+center,z+T+1+center))*wc*(p22-p21);
   
   end 
   
 %  disp(['Distortion was calculated in ' num2str(toc)]);
    
end

%disp(['Exiting getDistortion ' num2str(toc)]);

end

function [w] = w(d1,d2,d3,gamma,sigma)
    w=1/(sqrt(double(d1)^2+double(d2)^2+double(d3)^2)+sigma)^gamma;
end