function [lambdaM] = ModelQ74(y,N1,N2,NExt,Delays,a,NPart,window,blockType)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


lambdaM=zeros(size(Delays));

tic;

PlusK=0;
MinusK=0;

for k=1:numel(Delays)

    
    
    h=[1 zeros(1,Delays(k)) a];
    
   % NPart=floor((N2-N1)/(4*numel(h)));
    
    lambdaM(k)=corrCepstrMulti2(y(N1:N2),h,NPart,(N2-N1)*2,window,blockType);
    
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
title([ ' N = ' num2str(N2-N1)] );
print(hh,'-dpng',['d:\\work\\MQ74N' num2str(N2-N1) 'a' num2str(a)]);


end

