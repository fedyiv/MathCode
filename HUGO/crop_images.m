function [  ] = crop_images(directorySource,directorySG,ext,m,n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
list=eurModel3getFiles(directorySource,ext);

N=numel(list);



for i=1:N

    disp(['Image ' list{i} ' is being processed'])
    im=imread(list{i});
    
  
    im=im(1:m,1:n,:);
    
    
    [fp fn fe]=fileparts(list{i});
    imwrite(im,[directorySG fn '.' ext],ext);
    
end
end
