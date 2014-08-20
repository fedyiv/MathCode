function [ MV,D ] = codePframe( currentFrame,referenceFrame,mbSize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

MV=motionEstimationFrame(currentFrame,ReferenceFrame,mbSize);
D=frameDiff(referenceFrame,currentFrame,MV,mbSize);

end

