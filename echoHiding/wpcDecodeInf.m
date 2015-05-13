function [OutB] = wpcDecodeInf(b,M,H)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


N=numel(b);

vH=H(1:M,:);

OutB=mod(vH*b',2);
OutB=OutB';

end

