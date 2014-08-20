function [PrD] = HugoGetProbofD(D,dim)

[n m K] = size(D);
if(K~=8)
    error('What a shit???!!!')
end



if(dim==2)
    PrD=zeros(511,8);
    for k=1:8
        for i=1:n
            for j=1:m
                if(abs((D(i,j,k)))~=32767)
                    PrD(D(i,j,k)+256,k)=PrD(D(i,j,k)+256,k)+1;
                end
            end
        end
    end
    
    PrD=PrD/(n*m);
    
    
elseif (dim==3)
     error('What a shit???!!! Please use function for calculation ''C'' instead');    
 
else
     error('What a shit???!!!');
end

 

end

