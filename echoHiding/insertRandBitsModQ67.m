function [z,bits] = insertRandBitsModQ67(N,y,Fs,h0,h1,Smoothing)
%Insert in y random bits

[Num,tmp]=size(y);
Num=floor(Num/N);

%bits=round(rand(Num,1));
%bits=ones(Num,1);

bits=zeros(Num,1);
for i=1:Num
    if(mod(i,2)==0)
        bits(i)=1;
    end
end


y0=filter(h0,[1],y);
y1=filter(h1,[1],y);



%z=y';
z=zeros(size(y'));

y0=y0';
y1=y1';

for i=1:Num
    z=insertBitModQ67(y',z,bits(i),(i-1)*N+1,(i)*N,h0,h1,y0,y1,Smoothing);
    
    if(mod(i,10)==0)
        disp(['Insert bit ' num2str(i) ' From ' num2str(Num)]);
    end
    
    
end

z=z';


end 