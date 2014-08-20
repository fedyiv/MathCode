function [ ReconstructedFrame ] = frameReconstruction(ReferenceFrame,MV,mbSize)
%Application of MV to Reference Frame which outputs to reconstruction of
%reconstructed frame.  This function does not include motion compensation

[sizeX,sizeY] = size(ReferenceFrame);

sizeMVx=sizeX/mbSize;
sizeMVy=sizeY/mbSize;


for i=1:sizeMVx
    for j=1:sizeMVy
        ReconstructedFrame((i-1)*mbSize+1:i*mbSize,(j-1)*mbSize+1:j*mbSize)=mbReconstruction(ReferenceFrame,MV,i,j,mbSize);
    end
end

end

