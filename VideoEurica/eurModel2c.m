function [ pN ] = eurModel2c(pe,N,pEm)
%This function compute probability of error SG detection when number of
%frames are used. 
% pe - probability of error detection SG in one frame
%pN - probability of error if we have N frames
%pEm - probability of embedding (e.g. pEm=0.1 means that 1 frame from ten is used for embedding)

pN=0;

pe=0.5+pEm*pe-0.5*pEm;

if(mod(N,2)==0)
    N0=(N/2)+1;
else
    N0=(N+1)/2;
end


if(N<1000)
    for i=N0:N
        pN=pN+nchoosek(N,i)*(pe^i)*((1-pe)^(N-i));
    end
else
   % s=['(exp(-n*p)((n*p)^-k)/factorial(k))'];
    for i=N0:N 
           s=['(exp(-' num2str(N) '*' num2str(pe) ')*((' num2str(N) '*' num2str(pe) ')^' num2str(i) ')/factorial(' num2str(i) '))'];
         pN=pN+ double(vpa(s,5));
    end
end 


end

