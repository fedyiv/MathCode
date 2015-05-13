function [z,bits] = insertRandBits2PosCepsKey(N,n0,dn0,a,y,Fs,b0,b1)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

z=y';
for i=1:Num
    z=insertBit2PosCepsKey(z,Fs,bits(i),(i-1)*N+1,(i)*N,a,n0,dn0,b0,b1);
    
    if(mod(i,10)==0)
        disp(['Insert bit ' num2str(i) ' From ' num2str(Num)]);
    end
    
    
end

z=z';


end 