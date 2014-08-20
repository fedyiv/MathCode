function [ diff ] = eurModel3diffHCF(directory,ext)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

list=eurModel3getFiles(directory,ext);

N=numel(list);

com=zeros(N,1);
comDownsampled=zeros(N,1);

for i=1:N

    disp(['Image ' list{i} ' is being processed'])
    im=imread(list{i});
    im=im(:,:,1);
    com(i)=eurModel3centerOfMass(im);
    comDownsampled(i)=eurModel3centerOfMass(eurModel3downSample2(im));

end

%diff=abs(com-comDownsampled);

diff=com./comDownsampled;

end

