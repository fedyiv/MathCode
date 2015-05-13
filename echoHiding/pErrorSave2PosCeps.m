function pErr =pErrorSave2PosCeps(N,n0,dn0,a,y,Fs,NPart,NExtZeros,window,blockType,FileName)

tic;

[z,bits]=insertRandBits2PosCeps(N,n0,dn0,a,y,Fs);



if(max(z)>=1)
    z=z./max(z)+0.0000000001;
end

wavwrite(z,Fs,16,FileName);

exbits=extractBits2PosCeps(N,n0,dn0,a,z,Fs,NPart,NExtZeros,window,blockType);

ErrorVect=exbits-bits;

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



end