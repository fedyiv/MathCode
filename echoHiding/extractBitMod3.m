function bit=extractBitMod3(Mass,N1,N2,n0)


[odd,even]=splitMass(Mass);

N1=floor(N1/2);
N2=floor(N2/2);

lambdaOdd=AutoKorrFNorm(odd,N1,N2,n0);
lambdaEven=AutoKorrFNorm(even,N1,N2,n0);

if(lambdaOdd>lambdaEven)
    bit=1;
else
    bit=0;
end

end