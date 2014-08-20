function [ mv ] = motionEstimationMB(CurrentFrame,ReferenceFrame,nFx,nFy,mbSize)
%motionEstimationMB - estimate motion for macroblock (nFx,nFy) in CurrentFrame
%   on the output we have motion vector pointing to ReferenceFrame
%   now full search is performed


[sizeX,sizeY] = size(CurrentFrame);


mv=zeros(1,2);
min=mae(CurrentFrame((nFx-1)*mbSize+1:nFx*mbSize,(nFy-1)*mbSize+1:nFy*mbSize),ReferenceFrame((nFx-1)*mbSize+1:nFx*mbSize,(nFy-1)*mbSize+1:nFy*mbSize));
for i=1:(sizeX-mbSize+1)
    for j=1:(sizeY-mbSize+1)
        test=mae(CurrentFrame((nFx-1)*mbSize+1:nFx*mbSize,(nFy-1)*mbSize+1:nFy*mbSize),ReferenceFrame(i:(i-1)+mbSize,j:(j-1)+mbSize));
        if( test < min)
            min=test;
            mv(1)=i-((nFx-1)*mbSize+1);
            mv(2)=j-((nFy-1)*mbSize+1);
        end
    end
end


end

function err = mae(mb1,mb2)

    err=sum(reshape(abs(mb1-mb2),[],1))/numel(mb1);

end