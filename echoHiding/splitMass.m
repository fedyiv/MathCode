function [odd,even]=splitMass(Mass)

[m,n]=size(Mass);

m=m/2;

odd=zeros(m,1);
even=zeros(m,1);

for i=1:m
    odd(i)=Mass(2*i-1);
    even(i)=Mass(2*i);
end

end