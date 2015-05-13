function bit = extractBitMod5(Mass,N1,N2,Npr)


Num=N2-N1;

a=lpc(Mass(N1:N2-Npr));

y=filter([0 -a(2:end)],1,Mass);

y=y(N2-Npr:N2);

s=sum(abs(y));


s1=sum(abs(Mass(N2-Npr:N2)));



if(s1>s)
    bit=1;
else
    bit=0;
end



end