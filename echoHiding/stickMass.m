function res = stickMass(odd,even)

[m,n]=size(odd);



res=zeros(2*m,1);

for i=1:m
    res(2*i-1)=odd(i);
    res(2*i)=even(i);
end


end