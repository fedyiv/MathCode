function [ObshDlit , DlitK, ObshKolvoVib ,KolvoVibInGr, Ratio]= lr(y,a,Fs)

T=getVibrocy(y,a,Fs);

ObshDlit=sum(T);

DlitK=T;

[m,n]=size(T);
ObshKolvoVib=m;

gr=groups(y,T,Fs);

KolvoVibInGr=gr;


N=floor(max(T)*1000)+1;

Ratio=gr./ObshKolvoVib;

RatioMashtabirov=zeros(N,1);
for i=1:N
    RatioMashtabirov(i)=Ratio(i);
end

bar(RatioMashtabirov);


end