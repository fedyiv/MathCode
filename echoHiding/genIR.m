function [ IR ] = genIR(start,width,smoth,ampl,mode,n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


temp=ampl.*ones(1,width);
if(smoth==1)
    temp=temp.*(hamming(numel(temp)).^3)';
end


IR=zeros(1,start+width);
IR(start:start+width-1)=temp;
IR(1)=1;


if(mode==1)
    
    h=0;
    ht=zeros(1,numel(IR));
    ht(1)=IR(1);
    
    h=ht;
    for i=2:numel(IR)
        
        mask=[zeros(1,numel(IR))];
        mask(1)=IR(1);
        mask(i)=1;
        htnew=IR.*mask;
        
        h=conv(h,htnew);
       
    end
    
    
    j=numel(h);
    while(h(j)==0)
        j=j-1;
    end
    
    if(n==0)
        IR=h(1:j);
    else
        IR=h(1:n);
    end
    
end

end

