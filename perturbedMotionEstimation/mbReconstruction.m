function [ ReconstructedMB ] = mbReconstruction(ReferenceFrame,MV,nFx,nFy,mbSize)
%Application of MV to Reference Frame which outputs to reconstruction of
%reconstructed frame.  This function does not include motion compensation

[sizeX,sizeY] = size(ReferenceFrame);

sizeMVx=sizeX/mbSize;
sizeMVy=sizeY/mbSize;


ReconstructedMB=ReferenceFrame((nFx-1)*mbSize+1+MV(nFx,nFy,1):nFx*mbSize+MV(nFx,nFy,1),(nFy-1)*mbSize+1+MV(nFx,nFy,2):nFy*mbSize+MV(nFx,nFy,2));


end

