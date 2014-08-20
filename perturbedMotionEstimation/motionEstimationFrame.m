function [ MV ] = motionEstimationFrame(CurrentFrame,ReferenceFrame,mbSize)
%Motion estimation for an input frame based on reference frame

[sizeX,sizeY] = size(CurrentFrame);

sizeMVx=sizeX/mbSize;
sizeMVy=sizeY/mbSize;

MV=zeros(sizeMVx,sizeMVy,2);

for i=1:sizeMVx
    for j=1:sizeMVy
        mv = motionEstimationMB(CurrentFrame,ReferenceFrame,i,j,mbSize);
        MV(i,j,1)=mv(1);
        MV(i,j,2)=mv(2);
    end
end


end

