function [Res] = insertBitModQ86(y,bit,N1,N2,b0,b1,Smoothing,key)

Res=y;

N=N2-N1+1;

nSm=floor(Smoothing*N);


a=zeros(1,N2-N1+1);


x=0:nSm-1;
ar=(((cos(x/(nSm/pi)))+1)/2).^2;
al=fliplr(ar);


o0=1;
o1=1;
k=1;
while(b0(k)~=1)
    k=k+1;
end
o0=k;

k=1;
while(b0(k)~=1) % Why there is b0 here and there? why not b0 and b1 ?
    k=k+1;
end
o1=k;


db0=b0;
db0(o0)=0;

db1=b1;
db1(o1)=0; 



[x1 x2] = divideBand(y(N1:N2),key);

x1=[x1 zeros(1,o0-1)];
x2=[x2 zeros(1,o1-1)];    


if(bit==0)
    df1=filter(db0,[1],x1);
    df2=filter(db1,[1],x2);    
else
    df1=filter(db1,[1],x1);
    df2=filter(db0,[1],x2);    
end

df1=df1(o0:numel(df1));
df2=df2(o1:numel(df2));
df=df1+df2;



%TODO

%for i=1:numel(df)
%    if(df(i)~=0)
%        break;
%    end    
%end


a(1:numel(al))=al;
a(numel(al)+1:numel(a)-numel(ar))=ones(1,numel(a)-2*numel(ar));
a(numel(a)-numel(ar)+1:numel(a))=ar;

dy12=df.*a;


Res(N1:N2)=Res(N1:N2)+dy12;



end