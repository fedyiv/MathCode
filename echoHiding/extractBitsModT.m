function bits = extractBitsModT(z,N,a,Fs)

[m,n]=size(z);

Num=floor(m/N)-1; 

bits=zeros(Num,1);



for i=1:Num
    
    p=(z(i*N-1)+z(i*N+1))/2;
   
        if(abs(z(i*N))>abs(p))
            bits(i)=1;
        else
            bits(i)=0;
        end
    
    
end


end