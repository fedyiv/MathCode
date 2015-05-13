function [ ] =ModelQ78(N,y,h0,h1,NExtZeros,blockType,NPart,aAttack,Delay1,Delay2,delta,window,Smoothing,FileName)


tic;


Num=floor((Delay2-Delay1)/delta)+1;

pErr=zeros(1,Num);



pErr0=ModelQ72bEcho(N,y,0,NPart,NExtZeros,window,blockType,h0,h1,FileName,Smoothing,[1]);

for i=1:Num
    
    hAttack=[1 zeros(1,Delay1+(i-1)*delta) aAttack];

    pErr(i)=ModelQ72bEcho(N,y,0,NPart,NExtZeros,window,blockType,h0,h1,FileName,Smoothing,hAttack);
    
    
    if (mod(i,2)==0)
        disp(['i= ' num2str(i) ' From ' num2str(Num) ' Ellapsed Time'  num2str(toc)]);
    end

end

pErr=abs(pErr);

hh=figure();
plot(Delay1:delta:Delay2,pErr);
grid on;
title([ 'pErr aAttack = ' num2str(aAttack) ' pErrWithoutAttack = ',num2str(pErr0)]);
print(hh,'-dpng',['d:\\work\\M78a' num2str(aAttack) '.png']);



end

