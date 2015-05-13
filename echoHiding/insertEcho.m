function Res=insertEcho(Mass,N1,N2,a,n0)

Res=Mass;
A=a.*ones(N2-N1+1,1);
k=(N2-N1+1)/10;
for i=1:k
   
    A(i)=A(i)*(cos(pi*i./k+pi)+1)/2;
    A(N2-N1-i+2)=A(i);
end



if (a>0)
    for i=N1:N2
        Res(i)=Res(i)+A(i-N1+1)*Res(i-n0);
    end
end

if (a<0)
    for i=N2:-1:N1
        Res(i)=Res(i)+A(i-N1+1)*Res(i-n0);
    end
end

end