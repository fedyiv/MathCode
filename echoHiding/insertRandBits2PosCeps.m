function [z,bits] = insertRandBits2PosCeps(N,n0,dn0,a,y,Fs)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));

z=y';
for i=1:Num
    z=insertBit2PosCeps(z,Fs,bits(i),(i-1)*N+1,(i)*N,a,n0,dn0);
    
    if(mod(i,10)==0)
        disp(['Insert bit ' num2str(i) ' From ' num2str(Num)]);
    end
    
    
end

z=z';


end 