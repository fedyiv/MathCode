function [bit]=extractBitMod2Ceps(Mass,N1,N2,h,NPart,NExtZeros,window,blockType,nKv,lKvMin,lKvMax)


%summa=0;

%for i=N1:N2
%    summa=summa+abs(Mass(i));
%end

%if(summa/(N2-N1)<0.1)
%    return;
%end


deltaKv=(lKvMax-lKvMin)/nKv;

ScaleKv=zeros(nKv,1);

for i=1:nKv
    ScaleKv(i)=lKvMin+(i-1)*deltaKv;
end

%bar(ScaleKv);

lambda0=corrCepstrMulti2(Mass(N1:N2-1),h,NPart,NExtZeros,window,blockType);


if(isnan(lambda0))
    bit=0;
    return;
end

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