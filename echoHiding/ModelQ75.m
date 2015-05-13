function [n kChangable mEmbedded]=ModelQ75(N,y,Fs,NPart,NExtZeros,window,blockType,b0,b1,FileName,Smoothing,wpcN,wpcNH,wpcControl,wpcH)

tic;

wavwrite(y,Fs,16,[FileName 'Intput75.wav']);


[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

bits0=zeros(Num,1);
bits1=ones(Num,1);

%for i=1:Num
%    if(mod(i,2)==0)
%        bits1(i)=1;
%    else
%        bits0(i)=1;
%    end
%end


h0=b0;
h1=b1;


%b0=[1 0.5*b0(2:numel(b0))];
%b1=[1 0.5*b1(2:numel(b1))];


[exbitsC,lambda0,lambda1]=extractBits2PosCepsKey2Q75(N,0,0,0,y,Fs,NPart,NExtZeros,window,blockType,b0,b1,Smoothing);

[z]=insertBitsModQ70(N,y,bits0,b0,b1,Smoothing);

%ÊQuantize
%z=round((2.^15).*z)/(2.^15);

[exbits0,lambda0,lambda1]=extractBits2PosCepsKey2Q75(N,0,0,0,z,Fs,NPart,NExtZeros,window,blockType,b0,b1,Smoothing);

[z]=insertBitsModQ70(N,y,bits1,b0,b1,Smoothing);

%ÊQuantize
%z=round((2.^15).*z)/(2.^15);

[exbits1,lambda0,lambda1]=extractBits2PosCepsKey2Q75(N,0,0,0,z,Fs,NPart,NExtZeros,window,blockType,b0,b1,Smoothing);

ErrorVect0=abs(exbits0-bits0);
ErrorVect1=abs(exbits1-bits1);


for i=1:Num
    if(ErrorVect0(i)==1&&ErrorVect1(i)==1)
        ErrorVect0                   
    end  
    if(ErrorVect0(i)==1&&exbitsC(i)==0)
        exbitsC(i)=1;
    end
    if(ErrorVect1(i)==1&&exbitsC(i)==1)
        exbitsC(i)=0;
    end
end

ErrorVect=ErrorVect0|ErrorVect1;

mask=1-ErrorVect;

n=Num
k=n-sum(ErrorVect)
kChangable=k;



%H=round(rand(wpcN,wpcN));

H=wpcH;

%bits=round(rand(Num,1));
bits=bits0;

[outCover mEmbedded] = wpcEncoderB(bits',exbitsC',mask',wpcN,wpcNH,wpcControl,H);


b0=h0;
b1=h1;


[z]=insertBitsModQ70(N,y,outCover,b0,b1,Smoothing);

%ÊQuantize
%z=round((2.^15).*z)/(2.^15);


[exbits,lambda0,lambda1]=extractBits2PosCepsKey2Q75(N,0,0,0,z,Fs,NPart,NExtZeros,window,blockType,b0,b1,Smoothing);

[exbitsWPC mExtractedBits]= wpcDecoderB(exbits',wpcN,wpcNH,wpcControl,H);

Err=abs(exbitsWPC'-bits(1:numel(exbitsWPC)));
nErr=sum(Err)

if(max(z)>=1)
    z=z./(max(z)+0.0000000001);
end

wavwrite(z,Fs,16,[FileName 'Output70.wav']);




toc

end