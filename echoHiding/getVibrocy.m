function T = getVibrocy(y,a,Fs)

y=abs(y);
por=max(y)*a;

%size(y)
%M=y(1);
%for i=1:size(y)
%    if(M<y(i))
%        M=y(i);
%    end
%end
%por=M*a;
dt=1/Fs;

if(y(1)>a)
    flag=1;
    n1=1;
else
    flag=0;
    n1=1;
end


oldflag=flag;

k=1;

for i=1:size(y)
    if(y(i)>=por)
        flag=1;
    else
        flag=0;
    end
    
    if(flag==1&oldflag==0)
        if(k>1)
            if(i-(n1+dn)<0.01/(1/Fs))
                k=k-1;
            else%
                n1=i;
            end
        else
            n1=i;
        end
    end
    
    if((flag==0&oldflag==1)|(i==size(y)&flag==1))
        dn=i-n1;
        dT=dn*dt;
        T(k)=dT;
        k=k+1;
    end

    oldflag=flag;
end

T=T';

end