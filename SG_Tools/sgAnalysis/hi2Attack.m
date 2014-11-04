function [ hi2 ] = hi2Attack( im )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[~,~,dim]=size(im);
if(dim==1)
    im1=im;
elseif (dim==3)
    im1=im(:,:,2);
else
    assert(0);
end


V=hist(im1(:),[0:255]);
V=V+1; % Workaround to avoid situation when there are two neighbour values of histogram are zero, which causes error for dividing by zero
hi2=0;

for i=1:128
    hi2=hi2+(V(2*i-1)+V(2*i))^2/(2*(V(2*i-1)+V(2*i)));
end

end

