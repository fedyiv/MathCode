function [Res] = insertBitModQ77(y,bit,N1,N2,b0,b1,Smoothing)

Res=y;
N=N2-N1+1;

nSm=floor(Smoothing*N);


a=zeros(1,N2-N1+1);


x=0:nSm-1;
ar=(((cos(x/(nSm/pi)))+1)/2).^2;
al=fliplr(ar);

db0=[0 b0(2:numel(b0))];
db1=[0 b1(2:numel(b1))];

if(bit==0)
    df=filter(db0,[1],y(N1:N2));
else
    df=filter(db1,[1],y(N1:N2));
end
    
%TODO

for i=1:numel(df)
    if(df(i)~=0)
        break;
    end    
end


a(i+1:i+numel(al))=al;
a(i+numel(al)+1:numel(a)-numel(ar))=ones(1,numel(a)-i-2*numel(ar));
a(numel(a)-numel(ar)+1:numel(a))=ar;

dy12=df.*a;


Res(N1:N2)=Res(N1:N2)+dy12;



end