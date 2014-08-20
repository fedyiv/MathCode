function [ cor div] = Model1EvaluateDivergenceCorr( d,mean1,var1,mean2,var2,N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here



Div=zeros(numel(N),1);
i=1;
for n=N
    disp(['Processing data for n=' num2str(n) ' from ' num2str(N(numel(N)))]);
    X=mean1+var1*randn(n,d);
    %Y=X+mean2+var2*randn(n,d);    
    Y=(X+mean2+var2*randn(n,d))/sqrt(var1^2+var2^2);    
    Div(i)=getDivergence2(X,Y);
    disp(['...Div==' num2str(Div(i))]);
    i=i+1;    
end

%cor=xcorr(X(1,:),Y(1,:),0,'coeff')
x=reshape(X',[],1);
y=reshape(Y',[],1);
cor=sum((x-mean(x)).*(y-mean(y)))/sqrt(sum((x-mean(x)).^2)*sum((y-mean(y)).^2));

figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14)
plot(N,Div);
title(['Corr=' num2str(cor) ' dimension = ' num2str(d)]);

div=Div(numel(Div));


end

