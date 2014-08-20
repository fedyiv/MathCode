function [ TM ] = HugoModel4computeTextureMeasure( inBlock )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 B=im2col(inBlock,[2 2],'distinct');
 
 TM=sum(max(B)-min(B));

end

