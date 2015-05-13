function res = insertBitMod5(Mass,N1,N2,Npr,delta,bit)


res=Mass;


Num=N2-N1;

a=lpc(Mass(N1:N2-Npr));

Mass(N2-Npr:N2)=rand(Npr+1,1)/100;

y=filter([0 -a(2:end)],1,Mass);

y=y(N2-Npr:N2);

s=sum(abs(y));

flag=0;

s1=s;

b=0.1;

if(bit==1)
    while (flag==0)
        if(s1-s>delta)
            break;
        end
        
        y=y+b*y;
        
        
        s1=sum(abs(y));
         
    end
else
    while (flag==0)
        if(s-s1>delta)
            break;
        end
        
        y=y-b*y;
        
        
        s1=sum(abs(y));
         
    end
    
    
    
end

res(N2-Npr:N2)=y;




end