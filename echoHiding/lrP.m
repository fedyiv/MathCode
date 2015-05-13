function [ObshDlit , DlitK, ObshKolvoPause ,KolvoPauseInGr, Ratio]= lrP(y,a,Fs)

T=getPause(y,a,Fs);

ObshDlit=sum(T);

DlitK=T;

[m,n]=size(T);
ObshKolvoPause=m;

gr=groups(y,T,Fs);

KolvoPauseInGr=gr;


N=floor(max(T)*1000)+1;

Ratio=gr./ObshKolvoPause;

RatioMashtabirov=zeros(N,1);
for i=1:N
    RatioMashtabirov(i)=Ratio(i);
end

bar(RatioMashtabirov);


end