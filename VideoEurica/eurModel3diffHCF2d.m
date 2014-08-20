function [ diff ] = eurModel3diffHCF2d(directory,ext)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

list=eurModel3getFiles(directory,ext);

N=numel(list);

com=zeros(N,1);
comDownsampled=zeros(N,1);

for i=1:N

    disp(['Image ' list{i} ' is being processed'])
    im=imread(list{i});
    
     if(ndims(im)==3)
        im=im(:,:,1);
     end
        
    
    com(i)=eurModel3centerOfMass2(im);
    comDownsampled(i)=eurModel3centerOfMass2(eurModel3downSample2(im));

end

%Probably the error is here
%diff=abs(com-comDownsampled);

%should be that
diff=com./comDownsampled;


end

