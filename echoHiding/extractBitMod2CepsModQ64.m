function [bit lambda0 lambda1]=extractBitMod2CepsModQ64(Mass,N1,N2,h,NPart,NExtZeros,window,blockType,delta)


N11=N1;
N12=N1+floor((N2-N1)/2)-1;
N21=N1+floor((N2-N1)/2);
N22=N2-1;


lambda0=corrCepstrMulti2(Mass(N11:N12),h,NPart,NExtZeros,window,blockType);
lambda1=corrCepstrMulti2(Mass(N21:N22),h,NPart,NExtZeros,window,blockType);


if(isnan(lambda0)||isnan(lambda1))
    bit=0;
    return;
end

if(lambda1>lambda0)
    bit=1;
else
    bit=0;
end


end