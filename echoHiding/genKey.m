function [key] = genKey( lenKey,w )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n=floor(lenKey/w);

key=zeros(1,lenKey);

temp=round(rand(1,n+1));



for i=1:lenKey

key(i)=temp(ceil(i/w));

end


end

