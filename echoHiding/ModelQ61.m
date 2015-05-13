function [lambdaM] = ModelQ61(y,N,NExt,h,NPart,window,blockType)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


NExperiments=floor(numel(y)/N);


lambdaM=zeros(1,NExperiments);

tic;

PlusK=0;
MinusK=0;

for k=1:NExperiments

    x=[y((k-1)*N+1:k*N) zeros(1,NExt-N)];
    lambdaM(k)=corrCepstrMulti2(y(1+N*(k-1):N*k),h,NPart,NExt,window,blockType);
    
    if(lambdaM(k)>0)
        PlusK=PlusK+1;
    else
        MinusK=MinusK+1;
    end

    if (mod(k,2000)==0)
     disp([' lambdaM ' 'k= ' num2str(k) ' From ' num2str(NExperiments) ' Ellapsed Time'  num2str(toc)]);
    end
end


PlusK
MinusK


hh=figure();
bar(lambdaM);


grid on;
title([ 'NExp  = ' num2str(NExperiments) ' N = ' num2str(N)] );
print(hh,'-dpng',['d:\\work\\MQ58NExp' num2str(NExperiments) 'N' num2str(N)]);


end

