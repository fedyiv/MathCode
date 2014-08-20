function [ pN ] = eurModel2a(pe,N)
%This function compute probability of error SG detection when number of
%frames are used. 
% pe - probability of error detection SG in one frame
%pN - probability of error if we have N frames


pN=0;



if(mod(N,2)==0)
    N0=(N/2)+1;
else
    N0=(N+1)/2;
end

for i=N0:N
    pN=pN+nchoosek(N,i)*(pe^i)*((1-pe)^(N-i));
end



end

