function [pErr pErrTheory] = ModelQ82(N,h0,h1,NParts,blockType,window,NExp,NExtZeros)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



b0=h0;
b1=h1;
a=1;

err=0;
errTh=0;

tic;

for j=1:NExp

    y=randn(1,N);
   
    %-----------practise------------------------------------------
    z0=filter(b0,a,y);
    z1=filter(b1,a,y);
    
    

    lambda0=corrCepstrMultiQ82Real(z0,h0,NParts,NExtZeros,window,blockType);
    lambda1=corrCepstrMultiQ82Real(z0,h1,NParts,NExtZeros,window,blockType);
        
    if(lambda1 >= lambda0)
        err=err+0.5;
    end

    lambda0=corrCepstrMultiQ82Real(z1,h0,NParts,NExtZeros,window,blockType);
    lambda1=corrCepstrMultiQ82Real(z1,h1,NParts,NExtZeros,window,blockType);
        
    if(lambda1 <= lambda0)
        err=err+0.5;
    end

   
    %-----------theoretical------------------------------------------
    
    
    
    ty=[y zeros(1,NExtZeros-N)];
    
    [tm,tn]=size(h0);
    th0=[h0 zeros(1,NExtZeros-tn)];
    cth0=rceps(th0);
    sh=sum(cth0.^2);
    
    cty=rceps(ty);
    tempSigma2=sum(cty.^2)/NExtZeros;
    
    errTh=errTh+1-normcdf(sqrt(NParts*sh/(2*tempSigma2)),0,1);
    
    
    if (mod(j,100)==0)
     disp(['j= ' num2str(j) ' From ' num2str(NExp) ' Ellapsed Time'  num2str(toc)]);
    end

end

pErr=err/NExp;
pErrTheory=errTh/NExp;

end

