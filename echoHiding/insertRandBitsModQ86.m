function [z,bits] = insertRandBitsModQ86(N,y,Fs,h0,h1,Smoothing,key)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

bits=round(rand(Num,1));
%bits=ones(Num,1);

%bits=zeros(Num,1);
%for i=1:Num
%    if(mod(i,2)==0)
%        bits(i)=1;
%    end
%end



%z=y';
z=y;


for i=1:Num
    z=insertBitModQ86(y',bits(i),(i-1)*N+1,(i)*N,h0,h1,Smoothing,key);
    
    y=z';
    
    if(mod(i,10)==0)
        disp(['Insert bit ' num2str(i) ' From ' num2str(Num)]);
    end
    
    
end

z=z';


end 