function pErr =pError2PosCepsKey(N,n0,dn0,a,y,Fs,NPart,NExtZeros,window,blockType,b0,b1)

tic;


[z,bits]=insertRandBits2PosCepsKey(N,n0,dn0,a,y,Fs,b0,b1);
exbits=extractBits2PosCepsKey(N,n0,dn0,a,z,Fs,NPart,NExtZeros,window,blockType,b0,b1);

ErrorVect=exbits-bits;

subplot(2,1,1);
plot(y);
subplot(2,1,2);
bar(ErrorVect);

MinusK=0;
PlusK=0;

[m,tmp]=size(ErrorVect);

for i=1:m
    if(ErrorVect(i)<0)
        MinusK=MinusK+1;
    else
        if(ErrorVect(i)>0)
            PlusK=PlusK+1;
        end
    end
end


pErr=(abs(MinusK)+abs(PlusK))./m;

if(MinusK>PlusK)
    pErr=-pErr;

toc

end