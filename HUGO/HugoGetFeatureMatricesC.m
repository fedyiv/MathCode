function [C] = HugoGetFeatureMatricesC(D,dim,T)

[n m K] = size(D);
if(K~=8)
    error('What a shit???!!!')
end



if(dim==2)
    
    C=HugoGetC(D,dim,T);
    
    
elseif (dim==3)
   
    C=HugoGetC(D,dim,T);   
else
     error('What a shit???!!!')
end



%F=[reshape(M1,1,[]) reshape(M2,1,[])] ;





 

end

