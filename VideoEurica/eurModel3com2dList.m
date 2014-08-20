function [ com2 ] = eurModel3com2dList(directory,ext)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

list=eurModel3getFiles(directory,ext);

N=numel(list);

com2=zeros(N,1);


for i=1:N

    disp(['Image ' list{i} ' is being processed'])
    im=imread(list{i});
    im=im(:,:,1);
    com2(i)=eurModel3centerOfMass2(im);
   

end



end

