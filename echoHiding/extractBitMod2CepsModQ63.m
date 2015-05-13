function [bit]=extractBitMod2CepsModQ63(Mass,N1,N2,h0,h1,NPart,NExtZeros,window,blockType,delta)


lambda0=corrCepstrMulti2(Mass(N1:N2-1),h0,NPart,NExtZeros,window,blockType);
lambda1=corrCepstrMulti2(Mass(N1:N2-1),h1,NPart,NExtZeros,window,blockType);


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