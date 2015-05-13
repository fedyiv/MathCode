function pErr =pErrorSave(N,n0,a,y,Fs,FileName)


[z,bits]=insertRandBits(N,n0,a,y,Fs);

z=z./max(z);

wavwrite(z,Fs,16,FileName);

exbits=extractBits(N,n0,a,z,Fs);

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