function [ Cost ] = getCostsofBitsReplacing( x,pEmb,rho )
%Function to emulate Replacing embedding and get costs

mask=randsrc(1,numel(x),[1 0; pEmb 1-pEmb]);

y=x;
for i=1:numel(x)
    if(mask(i))
        y(i)=round(rand());
    end
end

Cost=sum(abs(x-y).*rho);

end

