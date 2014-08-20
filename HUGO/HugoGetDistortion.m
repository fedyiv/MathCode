function [ distortion ] = HugoGetDistortion(X,Y,dim,T,sigma,gamma)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


distortion=0;


CX=HugoGetC(HugoGetD(X),dim,T);
CY=HugoGetC(HugoGetD(Y),dim,T);

for i=-T:T
    for j=-T:T
        for z=-T:T
            wc=w(i,j,z,gamma,sigma);
            p11=CX(i+T+1,j+T+1,z+T+1,1)+CX(i+T+1,j+T+1,z+T+1,2)+CX(i+T+1,j+T+1,z+T+1,3)+CX(i+T+1,j+T+1,z+T+1,4);
            p12=CY(i+T+1,j+T+1,z+T+1,1)+CY(i+T+1,j+T+1,z+T+1,2)+CY(i+T+1,j+T+1,z+T+1,3)+CY(i+T+1,j+T+1,z+T+1,4);
            
            p21=CX(i+T+1,j+T+1,z+T+1,5)+CX(i+T+1,j+T+1,z+T+1,6)+CX(i+T+1,j+T+1,z+T+1,7)+CX(i+T+1,j+T+1,z+T+1,8);
            p22=CY(i+T+1,j+T+1,z+T+1,5)+CY(i+T+1,j+T+1,z+T+1,6)+CY(i+T+1,j+T+1,z+T+1,7)+CY(i+T+1,j+T+1,z+T+1,8);
            
            distortion=distortion+wc*abs(p11-p12)+wc*abs(p21-p22);          
                      
        end
    end
end


end

function [w] = w(d1,d2,d3,gamma,sigma)
    w=1/(sqrt(d1^2+d2^2+d3^2)+sigma)^gamma;
end