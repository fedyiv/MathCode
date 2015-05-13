function [ MO D NExperiments] = ModelQ58(y,N,NExt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


NExperiments=floor(numel(y)/N);


MO=zeros(1,NExt);

tic;

for k=1:NExperiments

    x=[y((k-1)*N+1:k*N) zeros(1,NExt-N)];
    cx=cceps(x);
    MO=MO+cx./NExperiments;

    if (mod(k,2000)==0)
     disp([' MO ' 'k= ' num2str(k) ' From ' num2str(NExperiments) ' Ellapsed Time'  num2str(toc)]);
    end
end

D=zeros(1,NExt);

for k=1:NExperiments
    
    x=[y((k-1)*N+1:k*N) zeros(1,NExt-N)];
    cx=cceps(x);
    
    D=D+((cx-MO).^2)/NExperiments;

     if (mod(k,2000)==0)
        disp(['Dispersia ''k= ' num2str(k) ' From ' num2str(NExperiments) ' Ellapsed Time'  num2str(toc)]);
     end
end


hh=figure();
subplot(2,1,1);
plot(MO);
subplot(2,1,2);
plot(D);

grid on;
title([ 'NExp  = ' num2str(NExperiments) ' N = ' num2str(N)] );
print(hh,'-dpng',['d:\\work\\MQ58NExp' num2str(NExperiments) 'N' num2str(N)]);


end

