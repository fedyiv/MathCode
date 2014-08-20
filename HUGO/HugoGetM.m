function [F] = HugoGetM(D,dim,T)

[n m K] = size(D);
if(K~=8)
    error('What a shit???!!!')
end



if(dim==2)
    PrD=HugoGetProbofD(D,dim);
    C=HugoGetC(D,dim,T);
    Mt=zeros(size(C));
    
    for k=1:K
    for i=1:2*T+1
        for j=1:2*T+1
            Mt(i,j,k)=C(j,i,k)/PrD(i-T-1+256,k);        
        end
    end
    end
    
    M1=(Mt(:,:,1)+ Mt(:,:,2)+Mt(:,:,3)+Mt(:,:,4))/4;
M2=(Mt(:,:,5)+Mt(:,:,6)+Mt(:,:,7)+Mt(:,:,8))/4;
    
elseif (dim==3)
    C2=HugoGetC(D,dim-1,T);
    C=HugoGetC(D,dim,T);
    Mt=zeros(size(C));
    
    for k=1:K
        for i=1:2*T+1
            for j=1:2*T+1
                for z=1:2*T+1
                    Mt(i,j,z,k)=C(z,j,i,k)/C2(j,i,k);
                end
            end
        end
            
    end
    
    M1=(Mt(:,:,:,1)+ Mt(:,:,:,2)+Mt(:,:,:,3)+Mt(:,:,:,4))/4;
    M2=(Mt(:,:,:,5)+Mt(:,:,:,6)+Mt(:,:,:,7)+Mt(:,:,:,8))/4;
 
else
     error('What a shit???!!!')
end



F=[reshape(M1,1,[]) reshape(M2,1,[])] ;

for i=1:numel(F)
    if(isnan(F(i)))
        F(i)=0;
    end
end




 

end

