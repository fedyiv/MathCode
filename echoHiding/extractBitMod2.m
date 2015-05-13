function bit=extractBitMod2(Mass,N1,N2,n0,nKv)


ScaleKv=zeros(nKv,1);

for i=1:nKv
    ScaleKv(i)=(1/nKv)*(i)-(0.5/nKv);

end

ScaleKv=ScaleKv*3-1.5;

lambda0=AutoKorrFNorm(Mass,N1,N2,n0);

flag=0;

Kv=1;
for i=1:nKv

    if(ScaleKv(i)>lambda0)
        if(mod(i,2)==1)
            bit=1;
        else
            bit=0;
        end
        break
    end
                
end

end