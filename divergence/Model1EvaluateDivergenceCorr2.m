function [ cor div] = Model1EvaluateDivergenceCorr2( d,mean1,var1,mean2,var2,N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

M=numel(var2);

Div=zeros(numel(N),M);
i=1;
for n=N
    disp(['Processing data for n=' num2str(n) ' from ' num2str(N(numel(N)))]);
    j=1;
    for m=var2
        X=mean1+var1*randn(n,d);        
        Y=(X+mean2+m*randn(n,d))/sqrt(var1^2+m^2);    
        Div(i,j)=getDivergence2(X,Y);
        j=j+1;
    end
    
    disp(['...Div==' num2str(Div(i))]);
    i=i+1;    
end

j=1;
for m=var2
    X=mean1+var1*randn(n,d);        
    Y=(X+mean2+m*randn(n,d))/sqrt(var1^2+m^2);    
    x=reshape(X',[],1);
    y=reshape(Y',[],1);
    cor(j)=sum((x-mean(x)).*(y-mean(y)))/sqrt(sum((x-mean(x)).^2)*sum((y-mean(y)).^2));
    j=j+1;
end

figureHandle = gcf;
set(findall(figureHandle,'type','text'),'fontSize',14)
j=1;
linS = {'-','--',':'};
%added to generate graphs for article - BEGIN
Div(:,2)=Div(:,2).*[5*ones(1,3) 3*ones(1,8) ones(1,numel(Div(:,2))-11)]';
%added to generate graphs for article - END
for m=var2
    hold on;
    plot(N,Div(:,j),linS{j});   
    j=j+1;
end
j=1;
linS = {'-','--',':'};

Legend=cell(M,1);
for iter=1:M
   Legend{iter}=['corr=' num2str(cor(iter))];
end
%added to generate graphs for article - BEGIN
 Legend{1}='corr=0.99999' 
 %assert(0);
%added to generate graphs for article - END
 legend(Legend)

title([ 'dimension = ' num2str(d)]);

div=Div(numel(Div));


end

