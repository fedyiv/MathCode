function [C] = HugoGetC(D,dim,T)

[n m K] = size(D);
if(K~=8)
    error('What a shit???!!!')
end



if(dim==2)
   
    C=zeros(2*T+1,2*T+1,K);   
   
    k=1;
    for i=1:n
        for j=1:m-1
            if(abs(D(i,j,k))<=T && abs(D(i,j+1,k))<=T)
                C(D(i,j,k)+T+1,D(i,j+1,k)+T+1,k)=C(D(i,j,k)+T+1,D(i,j+1,k)+T+1,k)+1;
            end
        end
    end
     
    k=2;
    for i=1:n
        for j=2:m
            if(abs(D(i,j,k))<=T && abs(D(i,j-1,k))<=T)
                C(D(i,j,k)+T+1,D(i,j-1,k)+T+1,k)=C(D(i,j,k)+T+1,D(i,j-1,k)+T+1,k)+1;
            end
        end
    end
    
    k=3;
    for i=1:n-1
        for j=1:m
            if(abs(D(i,j,k))<=T && abs(D(i+1,j,k))<=T)
                C(D(i,j,k)+T+1,D(i+1,j,k)+T+1,k)=C(D(i,j,k)+T+1,D(i+1,j,k)+T+1,k)+1;
            end
        end
    end
    
    k=4;
    for i=2:n
        for j=1:m
            if(abs(D(i,j,k))<=T && abs(D(i-1,j,k))<=T)
                C(D(i,j,k)+T+1,D(i-1,j,k)+T+1,k)=C(D(i,j,k)+T+1,D(i-1,j,k)+T+1,k)+1;
            end
        end
    end
    
    k=5;
    for i=1:n-1
        for j=1:m-1
            if(abs(D(i,j,k))<=T && abs(D(i+1,j+1,k))<=T)
                C(D(i,j,k)+T+1,D(i+1,j+1,k)+T+1,k)=C(D(i,j,k)+T+1,D(i+1,j+1,k)+T+1,k)+1;
            end
        end
    end
    
    k=6;
    for i=2:n
        for j=2:m
            if(abs(D(i,j,k))<=T && abs(D(i-1,j-1,k))<=T)
                C(D(i,j,k)+T+1,D(i-1,j-1,k)+T+1,k)=C(D(i,j,k)+T+1,D(i-1,j-1,k)+T+1,k)+1;
            end
        end
    end
    
    k=7;
    for i=1:n-1
        for j=2:m
            if(abs(D(i,j,k))<=T && abs(D(i+1,j-1,k))<=T)
                C(D(i,j,k)+T+1,D(i+1,j-1,k)+T+1,k)=C(D(i,j,k)+T+1,D(i+1,j-1,k)+T+1,k)+1;
            end
        end
    end
    
    k=8;
    for i=2:n
        for j=1:m-1
            if(abs(D(i,j,k))<=T && abs(D(i-1,j+1,k))<=T)
                C(D(i,j,k)+T+1,D(i-1,j+1,k)+T+1,k)=C(D(i,j,k)+T+1,D(i-1,j+1,k)+T+1,k)+1;
            end
        end
    end
   
elseif (dim==3)
     C=zeros(2*T+1,2*T+1,2*T+1,K);   
   
    k=1;
    for i=1:n
        for j=1:m-2
            if(abs(D(i,j,k))<=T && abs(D(i,j+1,k))<=T && abs(D(i,j+2,k))<=T)
                C(D(i,j,k)+T+1,D(i,j+1,k)+T+1,D(i,j+2,k)+T+1,k)=C(D(i,j,k)+T+1,D(i,j+1,k)+T+1,D(i,j+2,k)+T+1,k)+1;
            end
        end
    end
    
    k=2;
    for i=1:n
        for j=3:m
            if(abs(D(i,j,k))<=T && abs(D(i,j-1,k))<=T && abs(D(i,j-2,k))<=T)
                C(D(i,j,k)+T+1,D(i,j-1,k)+T+1,D(i,j-2,k)+T+1,k)=C(D(i,j,k)+T+1,D(i,j-1,k)+T+1,D(i,j-2,k)+T+1,k)+1;
            end
        end
    end
    
    k=3;
    for i=1:n-2
        for j=1:m
            if(abs(D(i,j,k))<=T && abs(D(i+1,j,k))<=T && abs(D(i+2,j,k))<=T)
                C(D(i,j,k)+T+1,D(i+1,j,k)+T+1,D(i+2,j,k)+T+1,k)=C(D(i,j,k)+T+1,D(i+1,j,k)+T+1,D(i+2,j,k)+T+1,k)+1;
            end
        end
    end
    
    k=4;
    for i=3:n
        for j=1:m
            if(abs(D(i,j,k))<=T && abs(D(i-1,j,k))<=T && abs(D(i-2,j,k))<=T)
                C(D(i,j,k)+T+1,D(i-1,j,k)+T+1,D(i-2,j,k)+T+1,k)=C(D(i,j,k)+T+1,D(i-1,j,k)+T+1,D(i-2,j,k)+T+1,k)+1;
            end
        end
    end
    
    k=5;
    for i=1:n-2
        for j=1:m-2
            if(abs(D(i,j,k))<=T && abs(D(i+1,j+1,k))<=T && abs(D(i+2,j+2,k))<=T)
                C(D(i,j,k)+T+1,D(i+1,j+1,k)+T+1,D(i+2,j+2,k)+T+1,k)=C(D(i,j,k)+T+1,D(i+1,j+1,k)+T+1,D(i+2,j+2,k)+T+1,k)+1;
            end
        end
    end
    
    k=6;
    for i=3:n
        for j=3:m
            if(abs(D(i,j,k))<=T && abs(D(i-1,j-1,k))<=T && abs(D(i-2,j-2,k))<=T)
                C(D(i,j,k)+T+1,D(i-1,j-1,k)+T+1,D(i-2,j-2,k)+T+1,k)=C(D(i,j,k)+T+1,D(i-1,j-1,k)+T+1,D(i-2,j-2,k)+T+1,k)+1;
            end
        end
    end
    
    k=7;
    for i=1:n-2
        for j=3:m
            if(abs(D(i,j,k))<=T && abs(D(i+1,j-1,k))<=T && abs(D(i+2,j-2,k))<=T)
                C(D(i,j,k)+T+1,D(i+1,j-1,k)+T+1,D(i+2,j-2,k)+T+1,k)=C(D(i,j,k)+T+1,D(i+1,j-1,k)+T+1,D(i+2,j-2,k)+T+1,k)+1;
            end
        end
    end
    
    k=8;
    for i=3:n
        for j=1:m-2
            if(abs(D(i,j,k))<=T && abs(D(i-1,j+1,k))<=T && abs(D(i-2,j+2,k))<=T)
                C(D(i,j,k)+T+1,D(i-1,j+1,k)+T+1,D(i-2,j+2,k)+T+1,k)=C(D(i,j,k)+T+1,D(i-1,j+1,k)+T+1,D(i-2,j+2,k)+T+1,k)+1;
            end
        end
    end

 
else
     error('What a shit???!!!')
end

 
 C=C/(m*n);


end

