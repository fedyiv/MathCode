function [ output_args ] = HugoModel9a( sigma,gamma,T,shift )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

step=T/30;
[X,Y] = meshgrid(-T:step:T);

Z1=1./(sqrt((X-shift).^2+(Y+shift).^2)+sigma)^gamma;
Z2=1./(sqrt((X+shift).^2+(Y-shift).^2)+sigma)^gamma;

Z=(Z1+Z2)/2;
surf(X,Y,Z);


end

