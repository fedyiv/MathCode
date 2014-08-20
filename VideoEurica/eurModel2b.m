function [ pN ] = eurModel2b(pe,N,pEm)
%This function compute probability of error SG detection when number of
%frames are used. 
% pe - probability of error detection SG in one frame
%pN - probability of error if we have N frames
%pEm - probability of embedding (e.g. pEm=0.1 means that 1 frame from ten is used for embedding)

pN=0;

pe=0.5+pEm*pe-0.5*pEm

if(mod(N,2)==0)
    N0=(N/2)+1;
else
    N0=(N+1)/2;
end

for i=N0:N
    pN=pN+nchoosek(N,i)*(pe^i)*((1-pe)^(N-i));
end



end

