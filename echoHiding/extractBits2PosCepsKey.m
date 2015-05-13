function bits = extractBits2PosCepsKey(N,n0,dn0,a,z,Fs,NPart,NExtZeros,window,blockType,b0,b1)
%Extrat in y random bits

[Num,tmp]=size(z);
Num=floor(Num/N);

bits=zeros(Num,1);


for i=1:Num-1
    bits(i)=extractBit2PosCepsKey(z',Fs,(i-1)*N+1,(i)*N,a,n0,dn0,NPart,NExtZeros,window,blockType,b0,b1);
    if(mod(i,10)==0)
        disp(['Extract bit ' num2str(i) '  From ' num2str(Num) ' Elapsed Time ' num2str(toc)]);
    end
end


end 