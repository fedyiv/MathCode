function [ output_args ] = HugoModel9( sigma,gamma,T )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[X,Y] = meshgrid(-T:T);

Z=1./(sqrt(X.^2+Y.^2)+sigma)^gamma;

surf(X,Y,Z);

end

