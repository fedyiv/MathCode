function [bits lambda0 lambda1] = extractBits2PosCepsKey2Q75(N,n0,dn0,a,z,Fs,NPart,NExtZeros,window,blockType,b0,b1,Smoothing)
%Extrat in y random bits

[Num,tmp]=size(z);
Num=floor(Num/N);

bits=zeros(Num,1);
lambda0=zeros(Num,1);
lambda1=zeros(Num,1);

tic;
for i=1:Num-1
    [bits(i),lambda0(i),lambda1(i)]=extractBit2PosCepsKey2(z',Fs,(i-1)*N+1+ceil(N*Smoothing),(i)*N-ceil(N*Smoothing),a,n0,dn0,NPart,NExtZeros,window,blockType,b0,b1);
    if(mod(i,10)==0)
        disp(['Extract bit ' num2str(i) '  From ' num2str(Num) ' Elapsed Time ' num2str(toc)]);
    end
end


end 