function [ D ] = frameDiff(ReferenceFrame,CurrentFrame,MV,mbSize)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[sizeX,sizeY] = size(CurrentFrame);

sizeMVx=sizeX/mbSize;
sizeMVy=sizeY/mbSize;

D=zeros(size(CurrentFrame));

for i=1:sizeMVx
    for j=1:sizeMVy
        D((i-1)*mbSize+1:i*mbSize,(j-1)*mbSize+1:j*mbSize)=mbDiff(ReferenceFrame,CurrentFrame,MV,i,j,mbSize);
    end 
end

end

