function lambda = AutoKorrFNorm( Mass,N1,N2,n0)

lambda=0;

for i=N1:N2
    lambda=lambda+Mass(i)*Mass(i-n0);
end
        
       
       
tempMass=zeros(N2-N1,1);
k=0;
for i=1:N2-N1
    k=k+(Mass(N1+i-n0))^2;
end
       
lambda=lambda/k;
        


end
