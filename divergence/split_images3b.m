function [  ] = split_images3b(sourceImagesDir,directorySG1,directorySG2,ext,blkLen)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
List=eurModel3getFiles(sourceImagesDir,ext);
for i=1:numel(List)
    split_images3(List{i},directorySG1,directorySG2,ext,blkLen)
end

end
