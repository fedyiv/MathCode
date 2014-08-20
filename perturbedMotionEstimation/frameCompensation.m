function [ C ] = frameCompensation(ReferenceFrame,MV,D,mbSize)
%Application of MV to Reference Frame which outputs to reconstruction of
%reconstructed frame.  This function does not include motion compensation

[sizeX,sizeY] = size(ReferenceFrame);

sizeMVx=sizeX/mbSize;
sizeMVy=sizeY/mbSize;

C=frameReconstruction(ReferenceFrame,MV,mbSize)-D;

end

