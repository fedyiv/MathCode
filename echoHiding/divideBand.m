function [xl xh] = divideBand(x,mask)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


N=numel(x);

if(mod(N,2)==1)

    NM=(N-1)/2;
else
    NM=N/2;
end


%mask=zeros(1,NM);

%mask(1:NM/2)=1;
%mask(NM/2+1:NM)=0;
%mask=round(rand(1,NM));

%plot(mask);

sax=abs(fft(x));
sphx=angle(fft(x));


saxl05=sax(2:NM+1);
saxh05=sax(2:NM+1);

saxl05=saxl05.*mask;
saxh05=saxh05.*(1-mask);





if(mod(N,2)==1)

    saxl=[ sax(1) saxl05 fliplr(saxl05)];
    saxh=[ 0 saxh05 fliplr(saxh05)];
else
    saxl=[ sax(1) saxl05(1:numel(saxl05)-1) fliplr(saxl05)];
    saxh=[ 0 saxh05(1:numel(saxh05)-1) fliplr(saxh05)];
    
end




xl=real(ifft(saxl.*exp(i.*sphx)));
xh=real(ifft(saxh.*exp(i.*sphx)));



end

