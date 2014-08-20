function [ diffMB ] = mbDiff(ReferenceFrame,CurrentFrame,MV,nFx,nFy,mbSize)


[sizeX,sizeY] = size(ReferenceFrame);

sizeMVx=sizeX/mbSize;
sizeMVy=sizeY/mbSize;


ReconstructedMB=mbReconstruction(ReferenceFrame,MV,nFx,nFy,mbSize);
diffMB=ReconstructedMB-CurrentFrame((nFx-1)*mbSize+1:nFx*mbSize,(nFy-1)*mbSize+1:nFy*mbSize);


end
