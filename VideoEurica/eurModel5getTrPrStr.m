function [ p] = Model5getTrPrStr(inBlock)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[m n] = size(inBlock);


pj=0;
for i=1:m
    for j=1:n-1
        pj=pj+(inBlock(i,j)==inBlock(i,j+1));
    end
end   

p=pj/(m*(n-1));

end

