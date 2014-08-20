function [ outMatrix ] = eurModel4getMat(img)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


if(numel(size(img))~=2 || sum(mod(size(img),8))~=0)
    error('Incorrect input matrix size')
end


[M N]=size(img);
m=M/8;
n=N/8;

outMatrix=zeros(m,n);

for i=1:m
    for j=1:n
        outMatrix(i,j)=eurModel4getValueFromBlock(img((i-1)*8+1:i*8,(j-1)*8+1:j*8));    
    end
end
end

