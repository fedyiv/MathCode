function gr = groups(y,v,Fs)

[m,n]=size(y);

Ngr=floor(((m)/Fs)*1000);
%Ngr=floor(max(v)*1000)+1;


gr=zeros(Ngr,1);

[m2,n]=size(v);

for i=1:m2
   gr(floor(v(i)*1000)+1)=gr(floor(v(i)*1000)+1)+1; 
end


end