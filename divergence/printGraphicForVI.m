function [  ] = printGraphicForVI( R,Pw )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
k=1;

for r=R
    h(k,:)=-(Pw.*log2(Pw)+(1-Pw).*log2(1-Pw));
    I(k,:)=1-h(k,:)./r;    
    k=k+1;
    
end

plot(Pw,I,'-k');   
%legend(num2str(R'));
xlabel('Pw');
ylabel('I');
set(get(gca,'YLabel'),'Rotation',0);
axis([0 0.5 0 1]);

end

