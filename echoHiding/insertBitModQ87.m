function [Res] = insertBitModQ87(y,bit,N1,N2,b0,b1,Smoothing)

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
while(b1(k)~=1)
    k=k+1;
end
o1=k;




x=y(N1:N2);

if(bit==0)
    db=b0;
    db(o0)=0;
    x=[x zeros(1,o0-1)];
    df=filter(db,[1],x);
    df=df(o0:numel(df));
else
    db=b1;
    db(o1)=0;
    x=[x zeros(1,o1-1)];
    df=filter(db,[1],x);
    df=df(o1:numel(df));
end

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