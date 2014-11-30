function [  ] = split_images2b(sourceImageFolder,targetFolder,ext,blkLen)
%Splitting one big image in the folder directorySource to blocks of size
%blkLen x blkLen

list=eurModel3getFiles(sourceImageFolder,ext);
N=numel(list);

    for i=1:N
        disp(['Image ' list{i} ' is being processed']);
        split_images2(list{i},targetFolder,ext,blkLen);
    end

end
