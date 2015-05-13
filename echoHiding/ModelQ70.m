function [exbitsC ErrorVect]=ModelQ70(N,y,Fs,NPart,NExtZeros,window,blockType,b0,b1,FileName,Smoothing)

tic;

wavwrite(y,Fs,16,[FileName 'Intput70.wav']);


[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

bits0=zeros(Num,1);
bits1=zeros(Num,1);

for i=1:Num
    if(mod(i,2)==0)
        bits1(i)=1;
    else
        bits0(i)=1;
    end
end


[exbitsC,lambda0,lambda1]=extractBits2PosCepsKey2(N,0,0,0,y,Fs,NPart,NExtZeros,window,blockType,b0,b1);

[z]=insertBitsModQ70(N,y,bits0,b0,b1,Smoothing);

if(max(z)>=1)
    z=z./(max(z)+0.0000000001);
end

wavwrite(z,Fs,16,[FileName 'Output70.wav']);

[exbits0,lambda0,lambda1]=extractBits2PosCepsKey2(N,0,0,0,z,Fs,NPart,NExtZeros,window,blockType,b0,b1);

[z]=insertBitsModQ70(N,y,bits1,b0,b1,Smoothing);
[exbits1,lambda0,lambda1]=extractBits2PosCepsKey2(N,0,0,0,z,Fs,NPart,NExtZeros,window,blockType,b0,b1);

ErrorVect0=abs(exbits0-bits0);
ErrorVect1=abs(exbits1-bits1);

ErrorVect=ErrorVect0|ErrorVect1;


n=Num
k=n-sum(ErrorVect)

fid = fopen(['d:\\work\\M70_n_' num2str(n) '.txt'], 'wt');
for i=1:n
    fprintf(fid, '%i',exbitsC(i));
end
fclose(fid);


fid = fopen(['d:\\work\\M70_k_' num2str(k) '.txt'], 'wt');
for i=1:n
    fprintf(fid, '%i',1-ErrorVect(i));
end
fclose(fid);




toc

end