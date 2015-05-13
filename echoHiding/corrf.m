function res=corrf(x,y)

res=0;

[m,tmp]=size(x);
[m1,tmp]=size(y);

if (m~=m1)
    
    ret='Invalid vector size'
    return;
end

x=x/max(x);
y=y/max(y);

for i=1:m
    res=res+x(i)*y(i);

end


sx=0;
sy=0;

for i=1:m
    sx=sx+x(i)^2;
    sy=sy+y(i)^2;
end

sxy=sqrt(sx+sy);

res=1000*res/sx;


end