function [ outBlock ] = eurModel3downSample2( inBlock )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

outBlock=uint8(zeros(size(inBlock)/2));

[m,n]=size(outBlock);

for i=1:m
    for j=1:n
        %outBlock(i,j)=0.25*(inBlock(2*i-1,2*j-1)+inBlock(2*i,2*j-1)+inBlock(2*i-1,2*j)+inBlock(2*i,2*j) );
        outBlock(i,j)=uint8(0.25*(double(inBlock(2*i-1,2*j-1))+double(inBlock(2*i,2*j-1))+double(inBlock(2*i-1,2*j))+double(inBlock(2*i,2*j) )));
    end
end




end

